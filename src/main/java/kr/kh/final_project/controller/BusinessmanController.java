package kr.kh.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.kh.final_project.service.BusinessmanService;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;

@Controller
public class BusinessmanController {
	
	@Autowired
	private BusinessmanService businessmanService;
	
	@GetMapping("/businessman/facility")
	public String facility(Model model) {
		//서비스에게 시설 리스트 가져오라고 시킴
		List<FacilityVO> list = businessmanService.getFacilityList();
		//가져온 리스트를 화면에 전송
		model.addAttribute("list", list);
		return "/businessman/facility";
	}
	
	@GetMapping("/businessman/facilityInsert")
	public String facilityInsert() {
		return "/businessman/facilityInsert";
	}
	@PostMapping("/businessman/facilityInsert")
	public String insertfacility(FacilityVO facility) {
		System.out.println(facility);
		return "message";
	}
	
}
