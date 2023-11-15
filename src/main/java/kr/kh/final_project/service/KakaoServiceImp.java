package kr.kh.final_project.service;


import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.vo.KakaoAccount;
import kr.kh.final_project.vo.KakaoResponse;
import kr.kh.final_project.vo.MemberVO;

@Service
public class KakaoServiceImp implements KakaoService{

	@Autowired
	MemberDAO memberDao;
	
	@Override
	public void kakaoSignup(String res) {
		
		// 받아온 스트링 정보를 객체로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		
		try {
		    KakaoResponse kakaoResponse = objectMapper.readValue(res, KakaoResponse.class);
		
		    KakaoAccount kakaoAccount = kakaoResponse.getKakao_account();
		    long id =  kakaoResponse.getId();
		    String me_id = String.valueOf(id);
		    me_id  += 'k';
		    String me_name = kakaoAccount.getName();
		    String me_email =  kakaoAccount.getEmail();
		    
		    // 이후에 똑같이 처리
		    MemberVO member = new MemberVO();
		    member.setMe_id(me_id);
		    member.setMe_name(me_name);
		    member.setMe_email(me_email);
		    member.setMe_rg_num(1);
		    
			memberDao.insertMember(member);
		} catch (IOException e) {
		    e.printStackTrace();
		}

		
	}
	

}
