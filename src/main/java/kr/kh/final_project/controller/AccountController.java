package kr.kh.final_project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.final_project.service.AccountService;
import kr.kh.final_project.vo.AccountVO;
import kr.kh.final_project.vo.MemberVO;

@Controller
@RequestMapping("/account")
public class AccountController {
	
	@Autowired
	AccountService accountService;
	
	@GetMapping("/insert")
	public String insert() {
		return "/account/insert";
	}
	@PostMapping("/insert")
	public String insertPost(HttpSession session, Model model, AccountVO account) {
		String msg , url;
		System.out.println(account);
		//세션에서 유저정보 가져오기 코드 추가
		MemberVO user = new MemberVO(1,"test", "test", "홍길동", "길동이", 2 , "01012341234" , "", "", "" , "USER", 0 , "", "실버", 0, 0, 0);
			
		// "1"은 유저 번호임
//				AccountVO account = new AccountVO(1, "KB국민은행", "홍길동", "032744567521231");
		//account의 예금주명은 회원 닉네임으로 받아오기
		if(accountService.insertAccount(account, user)) {
			msg = "계좌등록에 성공하였습니다.";
			url = "/";
		}else {
			msg = "계좌등록에 실패하였습니다.";
			url = "/account/insert"; 
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		// 여기 작업해야됨
		return "/util/message";
	}
}
