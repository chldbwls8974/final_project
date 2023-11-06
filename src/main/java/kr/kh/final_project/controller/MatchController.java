package kr.kh.final_project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.final_project.service.MatchService;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;

@Controller
public class MatchController {
	
	@Autowired
	MatchService matchService;

	@GetMapping("/match/search/solo")
	public String searchMatchSolo(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		List<RegionVO> mainRegion = matchService.selectMainRegion();
		List<ExtraVO> week = matchService.selectWeekDayList(0);

		model.addAttribute("mainRegion",mainRegion);
		model.addAttribute("week", week);
		
		return "/match/searchSole";
	}
	
	@GetMapping("/match/search/club")
	public String searchMatchClub(Model model, HttpSession session, int weekCount) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		List<RegionVO> mainRegion = matchService.selectMainRegion();
		List<ExtraVO> week = matchService.selectWeekDayList(weekCount);
		
		model.addAttribute("mainRegion",mainRegion);
		model.addAttribute("week", week);
		model.addAttribute("weekCount", weekCount);
		
		return "/match/searchClub";
	}
}
