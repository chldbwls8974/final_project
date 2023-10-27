package kr.kh.final_project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.service.BoardService;
import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.MemberVO;

@Controller
public class ApplicationController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/application/manager")
	public String Manager() {
		return "/application/manager";
	}
	
	@PostMapping("/application/manager")
	public String applyManager(Model model, BoardVO board, HttpSession session, 
			MultipartFile[] files) {
		//System.out.println(board);
		//user 정보를 주고 멤버VO에서 정보를 가져와서 멤버VO user에 저장
		MemberVO user = (MemberVO)session.getAttribute("user");
		//System.out.println(user);
		
		//boardService를 통해 메서드를 호출하고, 매니저 신청 정보(board, member, files)를 전달
		boolean res = boardService.insertMapplication(board, user, files);
		//매니저 신청 시 결과에 따라 메시지 및 URL을 설정
		if(res) {
			model.addAttribute("msg", "매니저 신청이 완료되었습니다.");
			model.addAttribute("url", "/");
		}else {
			model.addAttribute("msg", "신청에 실패했습니다.");
			model.addAttribute("url", "/application/manager");
		}
		
		return "/util/message";
	}
	
	@GetMapping("/application/businessman")
	public String Businessman() {
		return "/application/businessman";
	}
	
	@PostMapping("/application/businessman")
	public String applyBusinessman(Model model, BoardVO board, HttpSession session, 
			MultipartFile[] files) {
		//user 정보를 주고 멤버VO에서 정보를 가져와서 멤버VO user에 저장
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//boardService를 통해 메서드를 호출하고, 사업자 신청 정보(board, member, files)를 전달
		boolean res = boardService.insertBapplication(board, user, files);
		//사업자 신청 시 결과에 따라 메시지 및 URL을 설정
		if(res) {
			model.addAttribute("msg", "사업자 신청이 완료되었습니다.");
			model.addAttribute("url", "/");
		}else {
			model.addAttribute("msg", "신청에 실패했습니다.");
			model.addAttribute("url", "/application/businessman");
		}
		return "/util/message";
	}
}
