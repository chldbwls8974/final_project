package kr.kh.final_project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.service.RegionService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	@Autowired
	RegionService regionService;
	
	@GetMapping("/member/signup")
	public String signup(RegionVO region, Model model) {
		List<RegionVO> MainRegion = regionService.getMainRegion();
		model.addAttribute("MainRegion",MainRegion);
		return "/member/signup";
	}
	
	
	@PostMapping("/member/signup/region")
	public Object region(@RequestParam String rg_main,  Model model){
		List<RegionVO> SubRegion = regionService.getSubRegion(rg_main);
		model.addAttribute("SubRegion",SubRegion);
		return "/member/signup";
	}
	
	
	
	
	
	@PostMapping("/member/signup")
	public String signupPost(MemberVO member, Model model) {
		Message msg = new Message("/member/signup", "회원 가입에 실패했습니다.");
		
		if(memberService.signup(member)) {
			msg = new Message("/", "회원 가입에 성공했습니다.");
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
		MemberVO user = new MemberVO(1,"test", "test", "홍길동", "길동이", 2 , "01012341234" , "", "", "" , "USER", 0 , "", "실버", 0, 0, 0);
//		MemberVO user = memberService.userById(name);
		model.addAttribute("user", user);
		return "/member/refund";
	}
	@PostMapping("/member/refund")
	public String pointRefundPost(Model model, HttpSession session) {
		MemberVO user = new MemberVO(1,"test", "test", "홍길동", "길동이", 2 , "01012341234" , "", "", "" , "USER", 0 , "", "실버", 0, 0, 0);
		model.addAttribute("user", user);
		return "/member/refund";
	}
}
