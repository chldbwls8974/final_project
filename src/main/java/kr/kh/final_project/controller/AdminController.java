package kr.kh.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.vo.MemberVO;

@Controller
public class AdminController {
	
	@Autowired
	MemberService memberService;
	
	// 회원정보 출력하기
	@GetMapping("/admin/member")
	public String adminMember(Model model) {
		//회원정보를 가져오라고 서비스에게 시킨다.
		//가져온 리스트 정보는 list에 담는다.
		int me_num = 1;
		List<MemberVO> list = memberService.getMemberList(me_num);
				
		// 가져온 회원정보를 리스트에 담에 화면에 전송한다.
		model.addAttribute("list", list);
		return "/admin/member";
	}
}
