package kr.kh.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.final_project.service.ScheduleService;
import kr.kh.final_project.vo.OperatingVO;
import kr.kh.final_project.vo.StadiumVO;
import kr.kh.final_project.vo.TimeVO;

@Controller
public class ScheduleController {
	
	@Autowired
	ScheduleService scheduleService;
		
	@GetMapping("/schedule/insert")
	public String insertSchedule(Model model) {
		int fa_num = 1;
		List<StadiumVO> stadiumList = scheduleService.selectStadiumList(fa_num);
		List<OperatingVO> operatingList = scheduleService.selectOperatingList(fa_num);
		List<TimeVO> timeList = scheduleService.selectTimeList();
		model.addAttribute("stadiumList", stadiumList);
		model.addAttribute("operatingList", operatingList);
		model.addAttribute("timeList", timeList);
		return "/schedule/insert";
	}
	
}
