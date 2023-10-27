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

import kr.kh.final_project.service.MatchService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PreferredRegionVO;
import kr.kh.final_project.vo.PreferredTimeVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TimeVO;

@Controller
public class ManagerController {
	
	@Autowired
	MatchService matchService;

	@GetMapping("/manager/select/match")
	public String searchMatchManager(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		if(member == null || !member.getMe_authority().equals("MANAGER")) {
			Message msg = new Message("/", "매니저 권한이 필요합니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		List<RegionVO> mainRegion = matchService.selectMainRegion();
		List<ExtraVO> thirdWeek = matchService.selectThirdWeekDayList();
		
		model.addAttribute("mainRegion",mainRegion);
		model.addAttribute("thirdWeek", thirdWeek);
		
		return "/manager/match";
	}
	
	@ResponseBody
	@PostMapping("/manager/select/date")
	public Map<String, Object> selectStadium(@RequestParam("mt_date")String mt_date_str, @RequestParam("rg_num")int rg_num, @RequestParam("check")boolean check, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO member = (MemberVO)session.getAttribute("user");
		Date mt_date = null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			mt_date = format.parse(mt_date_str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println(mt_date);
		System.out.println(mt_date_str);
		System.out.println(rg_num);
		System.out.println(check);
		//match은 필터
		//fa_rg_num은 지역필터, 0 : 선호 지역, rg_sub = '전체'이면 rg_main 의 모든 지역, 아니면 해당 지역
		//mt_date는 날짜 필터
		if(rg_num == 0) {
			List<PreferredRegionVO> regionList = matchService.selectPRListByMeNum(member.getMe_num());
			map.put("regionList", regionList);
		}else {
			List<RegionVO> regionList = matchService.selectRegionListByRgNum(rg_num);
			map.put("regionList", regionList);
		}
		if(check) {
			List<PreferredTimeVO> timeList = matchService.selectPTListByMeNum(member.getMe_num());
			map.put("timeList", timeList);
		}else {
			List<TimeVO> timeList = matchService.selectTimeListByMtDate(mt_date);
			map.put("timeList", timeList);
		}
		List<MatchVO> matchList = matchService.selectMatchListOfManager(member.getMe_num(), mt_date);
		System.out.println(matchList);
		map.put("matchList", matchList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/manager/select/region")
	public Map<String, Object> selectMatchByRegion(@RequestParam("rg_num")int rg_num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> subRegion = matchService.selectSubRegionByMainRegion(rg_num);
		map.put("subRegion", subRegion);
		return map;
	}
	
	@GetMapping("/manager/manage/schedule")
	public String manageScheduleManager(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		if(member == null || !member.getMe_authority().equals("MANAGER")) {
			Message msg = new Message("/", "매니저 권한이 필요합니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		
		return "/manager/schedule";
	}
}
