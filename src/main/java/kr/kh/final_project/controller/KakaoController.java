package kr.kh.final_project.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.service.KakaoService;
import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.Kakao;
import kr.kh.final_project.vo.KakaoAccount;
import kr.kh.final_project.vo.KakaoResponse;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TimeVO;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class KakaoController {
	private String clientId = "43d6cf2ad0d704405dd762746ac5dfaa";

	@Autowired
	KakaoService kakaoService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MemberDAO memberDao;
	
	@GetMapping("/kakao_callback")
	public String Kakao(Model model,String code, String state) {
		Kakao kakao = getKakaoAccessToken(code);
		
		String res = getUserForKakao(kakao.getAccess_token());
		
		// 받아온 스트링 정보를 객체로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		
		try {
		    KakaoResponse kakaoResponse = objectMapper.readValue(res, KakaoResponse.class);
		    System.out.println(code);
		    // 카카오 토큰 id
		    //System.out.println("ID: " + kakaoResponse.getId());
		    // 토큰에 실린 정보
		    KakaoAccount kakaoAccount = kakaoResponse.getKakao_account();
		    System.out.println(kakaoAccount);
		    long id =  kakaoResponse.getId();
		    String me_id = String.valueOf(id);
		    me_id  += 'k';
		    
		    // 회원가입한 카카오인지 가져옴
		    MemberVO dbMember = memberDao.selectMember(me_id);
		    
		    
		    //회원가입이 안되어있는 상태라면
		    if(dbMember==null) {
		    	List<RegionVO> MainRegion = memberService.getMainRegion();
			    List<TimeVO> time = memberService.getAllTime();
			    model.addAttribute("MainRegion",MainRegion);
			    model.addAttribute("time",time);
			    model.addAttribute("me_id",me_id);
			    model.addAttribute("kakaoAccount",kakaoAccount);
			    
			    return "/kakao/signup_next";
		    }
		    // 회원가입이 되어있는 상태라면
		    else {
		    	MemberVO user = memberService.login(dbMember); 
		    	if(user != null) {
		    		model.addAttribute("user", user);
				}
		    	return "/kakao/login";
		    }
		} catch (IOException e) {
		    e.printStackTrace();
		}
		return "";
		
	}
	
	@PostMapping("/kakao_callback")
	public String signupKakaoPost(MemberVO member, Model model, int[] pr_rg_num,
			 int[] favoriteTime
			,  int[] favoriteHoliTime, int me_rg_num, String me_id
			) 
		{
		
		System.out.println(member);
		Message msg = new Message("/member/signup", "회원 가입에 실패했습니다.");
		if(memberService.signup(member, pr_rg_num,favoriteTime,favoriteHoliTime)) {
			msg = new Message("/", "회원 가입에 성공했습니다.");
		}
		model.addAttribute("msg", msg);
		return "message";
	}
	
	@GetMapping("/kakao/login")
	public String loginKakao() {
		return "/kakao/login";
	}
	
	
	@PostMapping("/kakao/login")
	public String loginKakaoPost(String me_id, Model model) 
	{
		// 여기 해야함. String 으로 받아온 유저 정보 객체로 뜯어서 처리를 하든
		// 아예 가져올때 뜯어서 가져오든 해야함
		Message msg = new Message("", "로그인에 성공했습니다.");
		MemberVO dbMember = memberDao.selectMember(me_id);
		MemberVO user = memberService.login(dbMember); 
		System.out.println(user);
		model.addAttribute("user", user);
		model.addAttribute("msg", msg);
		return "message";
	}

	
	private Kakao getKakaoAccessToken(String code) {
		try {
			String apiUrl = "https://kauth.kakao.com/oauth/token";
			Map<String, String> params = new HashMap<String, String>();
			params.put("client_id",clientId);
			params.put("redirect_url", "http://localhost:8080/final_project/kakao_callback");
			params.put("grant_type", "authorization_code");
			params.put("code", code);
			apiUrl = addParams(apiUrl, params);
					
            URL url = new URL(apiUrl);

            // HTTP 연결 설정
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Content-Type", "application/json"); // 요청 헤더 설정

            // 응답 코드 확인
            int responseCode = connection.getResponseCode();

            // 응답 데이터 읽기
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                StringBuilder response = new StringBuilder();

                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();

                ObjectMapper objectMapper = new ObjectMapper();
                
                Kakao person = objectMapper.readValue(response.toString(), Kakao.class);
                return person;
            } else {
                log.debug("API 호출 실패");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
		return null;
	}
	private String addParams(String url, Map<String, String> parameters) {
		 // StringBuilder를 사용하여 URL 문자열 생성
        StringBuilder urlBuilder = new StringBuilder(url);

        // 파라미터 추가
        if (!parameters.isEmpty()) {
            urlBuilder.append("?");
            for (Map.Entry<String, String> entry : parameters.entrySet()) {
                try {
                    String key = URLEncoder.encode(entry.getKey(), "UTF-8");
                    String value = URLEncoder.encode(entry.getValue(), "UTF-8");
                    urlBuilder.append(key).append("=").append(value).append("&");
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
            // 마지막 '&' 문자 제거
            urlBuilder.deleteCharAt(urlBuilder.length() - 1);
        }

        // 최종 URL 출력
        return urlBuilder.toString();
	}
	private String getUserForKakao(String accessToken) {
		try {
			System.out.println(accessToken);
			log.info(accessToken);
			String apiUrl = "https://kapi.kakao.com/v2/user/me";
            // URL 객체 생성
            URL url = new URL(apiUrl);

            // HTTP 연결 설정
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            //connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8"); // 요청 헤더 설정
            connection.setRequestProperty("Authorization", "Bearer " + accessToken); // 요청 헤더 설정

            // 응답 코드 확인
            int responseCode = connection.getResponseCode();
            log.info("HTTP 응답 코드: " + responseCode);

            // 응답 데이터 읽기
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                StringBuilder response = new StringBuilder();

                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();
                
                // 응답 출력
                ObjectMapper objectMapper = new ObjectMapper();
                return response.toString();
                
            } else {
                log.debug("API 호출 실패");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
		return null;
	}
}
