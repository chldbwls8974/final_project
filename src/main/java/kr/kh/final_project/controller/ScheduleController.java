package kr.kh.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.final_project.service.ScheduleService;
import kr.kh.final_project.vo.StadiumVO;

@Controller
public class ScheduleController {
	
	@Autowired
	ScheduleService scheduleService;
	
	@GetMapping("/schedule/insert")
	public String insertSchedule(Model model) {
		List<StadiumVO> stadiumList = scheduleService.selectStadiumList(1);
		model.addAttribute("stadiumList", stadiumList);
		return "/schedule/insert";
	}
	
}
