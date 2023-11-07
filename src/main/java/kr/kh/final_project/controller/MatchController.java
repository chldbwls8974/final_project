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
import kr.kh.final_project.vo.CouponVO;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;

@Controller
public class MatchController {
	
	@Autowired
	MatchService matchService;

	@GetMapping("/match/search/solo")
	public String searchMatchSolo(Model model, HttpSession session) {
		List<RegionVO> mainRegion = matchService.selectMainRegion();
		List<ExtraVO> week = matchService.selectWeekDayList(0);

		model.addAttribute("mainRegion",mainRegion);
		model.addAttribute("week", week);
		
		return "/match/searchSole";
	}
	
	@ResponseBody
	@PostMapping("/match/searchList/solo")
	public Map<String, Object> selectMatchListOfSolo(
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
		List<MatchVO> matchList = matchService.selectMatchListOfSolo(user.getMe_num(), mt_date, rg_num, check);
		map.put("matchList", matchList);
		return map;
	}
	
	@GetMapping("/match/search/club")
	public String searchMatchClub(Model model, HttpSession session, int weekCount) {
		List<RegionVO> mainRegion = matchService.selectMainRegion();
		List<ExtraVO> week = matchService.selectWeekDayList(weekCount);
		
		model.addAttribute("mainRegion",mainRegion);
		model.addAttribute("week", week);
		model.addAttribute("weekCount", weekCount);
		
		return "/match/searchClub";
	}
	
	@ResponseBody
	@PostMapping("/match/searchList/club")
	public Map<String, Object> selectMatchListOfClub(
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
		List<MatchVO> matchList = matchService.selectMatchListOfClub(user.getMe_num(), mt_date, rg_num, check);
		map.put("matchList", matchList);
		return map;
	}
	
	@GetMapping("/match/application")
	public String matchApplicationPage(Model model, HttpSession session, int mt_num, int type) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MatchVO match = matchService.selectMatchByMtNum(mt_num, user.getMe_num());
		ExpenseVO expense = matchService.selectPrice(type, match.getTi_day());
		List<CouponVO> couponList = matchService.selectCouponListByMeNum(user.getMe_num());
		
		model.addAttribute("user", user);
		model.addAttribute("match", match);
		model.addAttribute("expense", expense);
		model.addAttribute("couponList", couponList);
		return "/match/application";
	}
}
