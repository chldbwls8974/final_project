package kr.kh.final_project.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.final_project.service.ManagerService;
import kr.kh.final_project.service.MatchService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;

@Controller
public class ManagerController {
	
	@Autowired
	MatchService matchService;
	
	@Autowired
	ManagerService managerService;

	@GetMapping("/manager/select/match")
	public String searchMatchManager(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		if(member == null || !member.getMe_authority().equals("MANAGER")) {
			Message msg = new Message("/", "매니저 권한이 필요합니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		List<RegionVO> mainRegion = matchService.selectMainRegion();
		List<ExtraVO> thirdWeek = matchService.selectWeekDayList(2);
		
		model.addAttribute("mainRegion",mainRegion);
		model.addAttribute("thirdWeek", thirdWeek);
		
		return "/manager/match";
	}
	
	@ResponseBody
	@PostMapping("/manager/select/date")
	public Map<String, Object> selectMatchListOfManager(
			@RequestParam("mt_date")String mt_date_str,
			@RequestParam("rg_num")int rg_num,
			@RequestParam("check")boolean check,
			HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Date mt_date = null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			mt_date = format.parse(mt_date_str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		//match은 필터
		//fa_rg_num은 지역필터, 0 : 선호 지역, rg_sub = '전체'이면 rg_main 의 모든 지역, 아니면 해당 지역
		//mt_date는 날짜 필터
		List<MatchVO> matchList = matchService.selectMatchListOfManager(user.getMe_num(), mt_date, rg_num, check);
		map.put("matchList", matchList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/manager/select/region")
	public Map<String, Object> selectMatchByRegion(@RequestParam("rg_num")int rg_num){
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> subRegion = matchService.selectSubRegionByMainRegion(rg_num);
		map.put("subRegion", subRegion);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/manager/insert/match")
	public Map<String, Object> insertManagerMatch(@RequestParam("mt_num")int mt_num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = managerService.insertManagerToMatch(mt_num, user.getMe_num());
		map.put("res", res);
		return map;
	}
	
	@GetMapping("/manager/manage/schedule")
	public String manageScheduleManager(Model model, HttpSession session, int weekCount) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		if(member == null || !member.getMe_authority().equals("MANAGER")) {
			Message msg = new Message("/", "매니저 권한이 필요합니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		List<ExtraVO> week = matchService.selectWeekDayList(weekCount);
		model.addAttribute("weekCount", weekCount);
		model.addAttribute("week", week);
		return "/manager/schedule";
	}
	@ResponseBody
	@PostMapping("/manager/manage/schedule")
	public Map<String, Object> managerManagerMatch(@RequestParam("mt_date")String mt_date_str, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Date mt_date = null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			mt_date = format.parse(mt_date_str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		List<MatchVO> matchList = managerService.selectManagerMatchListByMtDate(user.getMe_num(), mt_date);
		map.put("matchList", matchList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/manager/delete/schedule")
	public Map<String, Object> deleteManagerMatch(@RequestParam("mt_num")int mt_num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		boolean res = managerService.deleteManagerToMatch(mt_num, user.getMe_num());
		map.put("res", res);
		return map;
	}
}
