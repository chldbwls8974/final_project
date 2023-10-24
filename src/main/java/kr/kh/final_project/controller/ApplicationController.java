package kr.kh.final_project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.vo.MemberVO;

@Controller
public class ApplicationController {

//	@Autowired
//	MemberService memberService;
//	
//	@GetMapping("/application/manager")
//	public String applyManager() {
//		return "/application/manager";
//	}
//	
//	@PostMapping("/application/manager")
//	public String memberList(MemberVO member, 
//			HttpSession session, Model model, MultipartFile[] files) {
//		MemberVO user = (MemberVO)session.getAttribute("user");
//		String msg = "신청을 완료하지 못했습니다.";
//		String url = "/application/manager";
//
//		if(memberService.applyManager(member, user, files)) {
//			msg = "신청이 완료되었습니다.";
//			url = "/";
//		}
//		model.addAttribute("msg", msg);
//		model.addAttribute("url", url);
//		return "application/message";
//	}
	
	
}
