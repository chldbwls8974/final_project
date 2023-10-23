package kr.kh.final_project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

	@GetMapping("/member/mypage")
	public String mepage() {
		return "/member/mypage";
	}
}
