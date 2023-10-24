package kr.kh.final_project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.vo.MemberVO;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@GetMapping("/member/mypage")
	public String mepage(HttpSession session, Model model) {
		String name = (String) session.getAttribute("name");
		MemberVO user = memberService.userById(name);
		model.addAttribute("user", user);
		return "member/mypage";
	}
}
