package kr.kh.final_project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.final_project.service.AccountService;
import kr.kh.final_project.vo.AccountVO;
import kr.kh.final_project.vo.BankVO;
import kr.kh.final_project.vo.MemberVO;

@Controller
@RequestMapping("/account")
public class AccountController {
	
	@Autowired
	AccountService accountService;
	
	@GetMapping("/insert")
	public String insert(Model model, HttpSession session ) {
		String url;
		//세션에서 유저정보 가져와야 함
		MemberVO user = (MemberVO)session.getAttribute("user");
		//멤버의 계좌 정보 가져오는 메서드
		AccountVO dbMemberAccount = accountService.getAccount(user);
		List<BankVO> bankList = accountService.getBankList();
		
		//db에 유저의 계좌가 없으면 -> 등록, 있으면 -> 수정
		if(dbMemberAccount != null) {
			url = "/account/change";
		}else {
			url ="/account/insert";
		}
		model.addAttribute("user",user);
		model.addAttribute("account", dbMemberAccount);
		model.addAttribute("bankList", bankList);
		return url;
	}
	@PostMapping("/insert")
	public String insertPost(HttpSession session, Model model, AccountVO account) {
		String msg , url;
		// 1.세션에서 유저정보 가져오기 코드 추가
		MemberVO user = (MemberVO)session.getAttribute("user");
			
		if(accountService.insertAccount(account, user)) {
			msg = "계좌등록에 성공하였습니다.";
			url = "/";
		}else {
			msg = "계좌등록에 실패하였습니다.";
			url = "/account/insert"; 
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		return "/util/message";
	}
	@PostMapping("/change")
	public String changePost(HttpSession session, Model model, AccountVO account) {
		String msg , url;
		// 1.세션에서 유저정보 가져오기 코드 추가
		MemberVO user = (MemberVO)session.getAttribute("user");
			
		if(accountService.updateAccount(account, user)) {
			msg = "계좌변경에 성공하였습니다.";
			url = "/";
		}else {
			msg = "계좌변경에 실패하였습니다.";
			url = "/"; 
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		return "/util/message";
	}
	
}
