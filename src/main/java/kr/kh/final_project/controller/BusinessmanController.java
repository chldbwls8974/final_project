package kr.kh.final_project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.kh.final_project.service.BusinessmanService;
import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;

@Controller
public class BusinessmanController {
	
	@Autowired
	BusinessmanService businessmanService;
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/businessman/facility")
	public String facility(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		//서비스에게 시설 리스트 가져오라고 시킴
		List<FacilityVO> list = businessmanService.getFacilityList();
		
		//가져온 리스트를 화면에 전송
		model.addAttribute("list", list);
		return "/businessman/facility";
	}
	
	@GetMapping("/businessman/facilityInsert")
	public String facilityInsert(Model model, HttpSession session) {
		//로그인한 회원 정보를 가져오고, 권한이 사업자일 경우에만 사업자가 등록한 시설 정보를 알 수 있음
		//멤버와 사업자를 연결하기 위해 user를 통해 me_num을 가져옴 (session은 로그인한 정보와 interception에 있는 정보만 가져오는 역할)
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//user의 me_num을 가져와서 business에 저장 -> BusinessmanVO의 bu_num으로 facility 정보도 확인 가능
		BusinessmanVO business = businessmanService.getBusinessmanByNum(user.getMe_num());

		//business에 저장된 user의 me_num을 화면에 보여줌
		model.addAttribute("business", business);
		return "/businessman/facilityInsert";
	}
	
	@PostMapping("/businessman/facilityInsert")
	public String insertfacility(Model model, FacilityVO facility, 
			BusinessmanVO business, MemberVO member, HttpSession session) {
		//System.out.println(facility);
		
		return "/util/message";
	}
	
}
