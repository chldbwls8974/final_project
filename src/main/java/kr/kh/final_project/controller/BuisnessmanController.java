package kr.kh.final_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.final_project.service.ScheduleService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.OperatingVO;
import kr.kh.final_project.vo.ScheduleVO;
import kr.kh.final_project.vo.StadiumVO;
import kr.kh.final_project.vo.TimeVO;

@Controller
public class BuisnessmanController {
	
	@Autowired
	ScheduleService scheduleBService;
		
	@GetMapping("/buisnessman/manage/schedule")
	public String insertSchedule(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		if(member == null || !member.getMe_authority().equals("BUSINESS")) {
			Message msg = new Message("/", "사업자 권한이 필요합니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		int fa_num = scheduleBService.selectFaNumByMeNum(member.getMe_num());
		if(fa_num == 0) {
			Message msg = new Message("/", "등록된 시설이 없습니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		
		List<StadiumVO> stadiumList = scheduleBService.selectStadiumListByFaNum(fa_num);
		List<OperatingVO> operatingList = scheduleBService.selectOperatingListByFaNum(fa_num);
		List<TimeVO> timeList = scheduleBService.selectTimeList();
		model.addAttribute("stadiumList", stadiumList);
		model.addAttribute("operatingList", operatingList);
		model.addAttribute("timeList", timeList);
		return "/buisnessman/schedule";
	}
	
	@ResponseBody
	@PostMapping("/select/stadium")
	public Map<String, Object> selectStadium(@RequestParam("st_num")Integer st_num){
		Map<String, Object> map = new HashMap<String, Object>();
		List<ScheduleVO> scheduleList = scheduleBService.selectScheduleListByStNum(st_num);
		StadiumVO stadium = scheduleBService.selectStadiumByStNum(st_num);
		map.put("scheduleList", scheduleList);
		map.put("stadium", stadium);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/insert/schedule")
	public Map<String, Object> insertScheduel(@RequestBody ScheduleVO schedule){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = scheduleBService.insertSchedule(schedule);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/delete/schedule")
	public Map<String, Object> deleteScheduel(@RequestBody ScheduleVO schedule){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = scheduleBService.deleteSchedule(schedule);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/update/schedule")
	public Map<String, Object> updateScheduel(@RequestBody ScheduleVO schedule){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = scheduleBService.updateSchedule(schedule);
		map.put("res", res);
		return map;
	}
}
