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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.final_project.service.MatchService;
import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PreferredRegionVO;
import kr.kh.final_project.vo.PreferredTimeVO;
import kr.kh.final_project.vo.RegionVO;

@Controller
public class ManagerController {
	
	@Autowired
	MemberService memberService;
	
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
		List<RegionVO> mainRegion = memberService.getMainRegion();
		List<ExtraVO> thirdWeek = matchService.selectThirdWeekDayList();
		
		model.addAttribute("mainRegion",mainRegion);
		model.addAttribute("thirdWeek", thirdWeek);
		
		return "/manager/match";
	}
	
	@ResponseBody
	@PostMapping("/manager/select/date")
	public Map<String, Object> selectStadium(@RequestBody MatchVO match, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO member = (MemberVO)session.getAttribute("user");
		List<PreferredRegionVO> PRList = matchService.selectPRListByMeNum(member.getMe_num());
		List<PreferredTimeVO> PTList = matchService.selectPTListByMeNum(member.getMe_num());
		List<MatchVO> matchList = matchService.selectMatchListOfManager(member.getMe_num(), match.getMt_date());
		map.put("matchList", matchList);
		map.put("PRList", PRList);
		map.put("PTList", PTList);
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
