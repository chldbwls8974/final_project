package kr.kh.final_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.service.RegionService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TimeVO;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	@Autowired
	RegionService regionService;
	
	@GetMapping("/member/signup")
	public String signup(Model model) {
		List<RegionVO> MainRegion = memberService.getMainRegion();
		List<TimeVO> time = memberService.getAllTime();
		model.addAttribute("MainRegion",MainRegion);
		model.addAttribute("time",time);
		return "/member/signup";
	}
	
	@ResponseBody
	@GetMapping("/member/signup/region")
	public Map<String, Object> region(@RequestParam String rg_main,  Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> SubRegion = memberService.getSubRegionByMainRegion(rg_main);
		map.put("SubRegion", SubRegion);
		return map;
	}
	
	// 추천인 닉네임 입력 시, 입력한 닉네임의 회원이 존재하는지 확인
	@ResponseBody
	@GetMapping("/member/signup/check")
	public Map<String, Object> check(@RequestParam String check,  Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO checked = memberService.isCheck(check);
		map.put("checked",checked);
		return map;
	}
	
	//인증번호 전송
	@ResponseBody
	@GetMapping("/member/signup/checkmail")
	public boolean checkmail(@RequestParam String to,@RequestParam String randomCode, Model model){
		//Map<String, Object> map = new HashMap<String, Object>();
		String title= "인증번호 메일 테스트";
		String contents = 
				"홈페이지를 방문해주셔서 감사합니다." + 	//html 형식으로 작성 ! 
                "<br><br>" + 
			    "인증 번호는 " + randomCode + "입니다." + 
			    "<br>" + 
			    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
		return memberService.sendMail(to, title, contents);
	}
	
	// 아이디 중복 체크
	@ResponseBody
	@PostMapping("/member/check/id")
	public Object idCheck(@RequestParam("id")String id){
		return memberService.checkId(id);
	}
	
	// 이메일 중복 체크
	@ResponseBody
	@PostMapping("/member/check/email")
	public Object emailCheck(@RequestParam("email")String email){
		return memberService.checkEmail(email);
	}
	
	// 닉네임 중복 체크
	@ResponseBody
	@PostMapping("/member/check/nickname")
	public Object nickNameCheck(@RequestParam("nickname")String nickname){
		return memberService.checkNickName(nickname);
	}
	
	
	@PostMapping("/member/signup")
	public String signupPost(MemberVO member, Model model, int[] pr_rg_num,
			 int[] favoriteTime
			,  int[] favoriteHoliTime
			) 
		{
		
		Message msg = new Message("/member/signup", "회원 가입에 실패했습니다.");
		
		if(memberService.signup(member, pr_rg_num,favoriteTime,favoriteHoliTime)) {
			msg = new Message("/", "회원 가입에 성공했습니다.");
		}
		model.addAttribute("msg", msg);
		return "message";
	}
	
	
	@GetMapping(value="/member/login")
	public String memberLogin() {
		return "/member/login";
	}
	
	@PostMapping(value="/member/login")
	public String memberLoginPost(MemberVO member, Model model) {
		Message msg = new Message("/member/login", "로그인에 실패했습니다.");
		//DB에서 로그인 정보를 이용하여 가져온 회원정보. 자동로그인 여부가 없음
		MemberVO user = memberService.login(member); 
		if(user != null) {
			msg = new Message("", "로그인에 성공했습니다.");
			//화면에서 선택/미선택한 자동로그인 여부를 user에 저장해서 인터셉터에게 전달 
			user.setAutoLogin(member.isAutoLogin());
		}
		model.addAttribute("user", user);
		model.addAttribute("msg", msg);
		return "message";
	}
	
	@GetMapping("/member/logout")
	public String memberLogout(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO)session.getAttribute("user");
		user.setMe_session_limit(null);
		memberService.updateMemberSession(user);
		Message msg = new Message("/", null);
		if(user != null) {
			session.removeAttribute("user");
			msg.setMsg("로그아웃에 성공했습니다.");
		}
		model.addAttribute("msg", msg);
		return "message";
	}
	
	
	
	@GetMapping("/member/mypage")
	public String mepage(HttpSession session, Model model) {
		String name = (String) session.getAttribute("name");
		MemberVO user = memberService.userById(name);
		model.addAttribute("user", user);
		return "/member/mypage";
	}
	
	//포인트 환급 페이지
	@GetMapping("/member/refund")
	public String pointRefund(Model model, HttpSession session) {
		
		//유저정보 세션에서 가져오도록 수정
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		
//		MemberVO user = memberService.userById(name);
		model.addAttribute("user", user);
		return "/member/refund";
	}
	@PostMapping("/member/refund")
	public String pointRefundPost(Model model, HttpSession session, MemberVO user, PointHistoryVO pointHistory) {
		String msg, url;
		//포인트내역 테이블의 용도 속성정보를 서비스에서 추가해 줘야 함.
		System.out.println(pointHistory);
		System.out.println(user);
		if(memberService.pointRefundApply(user, pointHistory)) {
			msg = "환급 신청이 성공하였습니다.";
			url = "/";
		}else {
			msg = "환급 신청이 실패하였습니다.";
			url = "/"; 
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		return "/util/message";
	}
}
