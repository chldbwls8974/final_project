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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.final_project.service.ManagerService;
import kr.kh.final_project.service.MatchService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.EntryVO;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.QuarterVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TeamVO;

@Controller
public class ManagerController {
	
	@Autowired
	MatchService matchService;
	
	@Autowired
	ManagerService managerService;

	@GetMapping("/manager/select/match")
	public String searchMatchManager(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null || !user.getMe_authority().equals("MANAGER")) {
			Message msg = new Message("/", "매니저 권한이 필요합니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		List<RegionVO> mainRegion = matchService.selectMainRegion();
		List<ExtraVO> thirdWeek = matchService.selectWeekDayList(2);
		
		model.addAttribute("mainRegion",mainRegion);
		model.addAttribute("thirdWeek", thirdWeek);
		
		return "/manager/searchMatch";
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
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(weekCount > 2) {
			weekCount = 2;
		}
		if(user == null || !user.getMe_authority().equals("MANAGER")) {
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
	
	@GetMapping("/manager/manage/match")
	public String matchApplicationPage(Model model, HttpSession session, int mt_num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MatchVO match = managerService.selectManageMatchByMtNum(mt_num);
		
		if(user == null || !user.getMe_authority().equals("MANAGER")) {
			Message msg = new Message("/", "매니저 권한이 필요합니다.");
		
			model.addAttribute("msg", msg);
			return "/message";
		}
		if(match == null) {
			Message msg = new Message("manager/manage/schedule?weekCount=0", "삭제되거나 없는 경기입니다.");
			
			model.addAttribute("msg", msg);
			return "/message";			
		}
		if(match.getMn_me_num() != user.getMe_num()) {
			Message msg = new Message("/manager/manage/schedule?weekCount=0", "등록된 매니저가 아닙니다.");
			
			model.addAttribute("msg", msg);
			return "/message";			
		}
		List<TeamVO> teamList = matchService.selectTeamByMtNum(mt_num);
		List<EntryVO> entryList = matchService.selectEntryByMtNum(mt_num);
		
		model.addAttribute("match", match);
		model.addAttribute("teamList", teamList);
		model.addAttribute("entryList", entryList);
		return "/manager/manageMatch";
	}
	
	@ResponseBody
	@PostMapping("/insert/team/solo")
	public Map<String, Object> insertTeamSolo(@RequestParam("mt_num")int mt_num){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean res = matchService.insertMatchTeamSolo(mt_num);
		
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/update/entry/team")
	public Map<String, Object> updateEntryTeam(@RequestParam("en_num")int en_num, @RequestParam("te_num")int te_num){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean res = managerService.updateEntryTeam(en_num, te_num);
		
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/reset/entry/team")
	public Map<String, Object> resetEntryTeam(@RequestParam("mt_num")int mt_num){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean res = managerService.resetEntryTeam(mt_num);
		
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/auto/Balance")
	public Map<String, Object> autoBalance(@RequestParam("mt_num")int mt_num){
		Map<String, Object> map = new HashMap<String, Object>();

		boolean res = managerService.autoBalanceByMtNum(mt_num);
		
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/complete/team")
	public Map<String, Object> completeTeam(@RequestParam("mt_num")int mt_num){
		Map<String, Object> map = new HashMap<String, Object>();

		boolean res = managerService.completeTeamByMtNum(mt_num);
		String msg = "팀이 확정되었습니다.";
		
		if(!res) {
			msg = "모든 참가자가 팀에 속해야합니다.";
		}
		
		map.put("msg", msg);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/confirm/match")
	public Map<String, Object> confirmMatch(@RequestParam("mt_num")int mt_num){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean res = matchService.updateRatingMatchResult(mt_num);
		
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/insert/quarter")
	public Map<String, Object> insertQuarter(@RequestBody QuarterVO quarter){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean res = managerService.insertQuarter(quarter);
		
		map.put("res", res);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/count/quarter")
	public Map<String, Object> countQuarter(@RequestParam("mt_num")int mt_num){
		Map<String, Object> map = new HashMap<String, Object>();
		
		int count = matchService.countQuarterByMtNum(mt_num);

		map.put("count", count);
		return map;
	}
	@ResponseBody
	@PostMapping("/select/quarter")
	public Map<String, Object> selectQuarter(@RequestParam("mt_num")int mt_num){
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<QuarterVO> quarterList = matchService.selectQuarterListByMtNum(mt_num);

		map.put("quarterList", quarterList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/update/quarter")
	public Map<String, Object> updateQuarter(@RequestBody QuarterVO quarter){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean res = managerService.updateQuarter(quarter);
		
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/delete/quarter")
	public Map<String, Object> deleteQuarter(@RequestParam("qu_num")int qu_num){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean res = managerService.deleteQuarter(qu_num);
		
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/print/team/entry")
	public Map<String, Object> printTeam(@RequestParam("mt_num")int mt_num){
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<TeamVO> teamList = matchService.selectTeamByMtNum(mt_num);
		List<EntryVO> entryList = matchService.selectEntryByMtNum(mt_num);
		int entry_count = 0;
		for(EntryVO entry : entryList) {
			if(entry.getTe_type() != 0) {
				entry_count++;
			}
		}
		map.put("teamList", teamList);
		map.put("entryList", entryList);
		map.put("entry_count", entry_count);
		return map;
	}
}
