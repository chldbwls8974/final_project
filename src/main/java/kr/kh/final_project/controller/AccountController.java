package kr.kh.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.final_project.service.AccountService;

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
	public String insertPost() {
		//세션에서 유저정보 가져오기 코드 추가
		
		// 여기 작업해야됨
		return "/account/insert";
	}
}
