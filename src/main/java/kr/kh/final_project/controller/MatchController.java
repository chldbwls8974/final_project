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
import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.ClubMemberVO;
import kr.kh.final_project.vo.ClubVO;
import kr.kh.final_project.vo.CouponVO;
import kr.kh.final_project.vo.EntryVO;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TeamVO;

@Controller
public class MatchController {
	
	@Autowired
	MatchService matchService;
	
	@Autowired
	MemberService memberService;

	@GetMapping("/match/search/solo")
	public String searchMatchSolo(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null) {
			Message msg = new Message("/", "로그인이 필요한 기능입니다.");
			
			model.addAttribute("msg", msg);
			return "/message";
		}
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
		//fa_rg_num은 지역필터, 0 : 선호 지역, 246 : 전체지역, rg_sub = '전체'이면 rg_main 의 모든 지역, 아니면 해당 지역
		//mt_date는 날짜 필터
		List<MatchVO> matchList = matchService.selectMatchListOfSolo(user.getMe_num(), mt_date, rg_num, check);
		map.put("matchList", matchList);
		return map;
	}
	
	@GetMapping("/match/search/club")
	public String searchMatchClub(Model model, HttpSession session, int weekCount) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(weekCount > 1) {
			weekCount = 1;
		}else if(weekCount < 0) {
			weekCount = 0;
		}
		if(user == null) {
			Message msg = new Message("/", "로그인이 필요한 기능입니다.");
			
			model.addAttribute("msg", msg);
			return "/message";
		}
		//병합후 서비스 변경
		List<ClubVO> clubList = matchService.selectClubListByMeNum(user.getMe_num());
		List<ExtraVO> week = matchService.selectWeekDayList(weekCount);
		
		model.addAttribute("clubList", clubList);
		model.addAttribute("week", week);
		model.addAttribute("weekCount", weekCount);
		
		return "/match/searchClub";
	}
	
	@ResponseBody
	@PostMapping("/match/searchList/club")
	public Map<String, Object> selectMatchListOfClub(
			@RequestParam("mt_date")String mt_date_str,
			@RequestParam("cl_num")int cl_num,
			HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		Date mt_date = null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			mt_date = format.parse(mt_date_str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		List<MatchVO> matchList = matchService.selectMatchListOfClub(cl_num, mt_date);
		map.put("matchList", matchList);
		return map;
	}
	
	@GetMapping("/match/application")
	public String matchApplicationPage(Model model, HttpSession session, int mt_num, int cl_num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			Message msg = new Message("member/login", "로그인 후 이용 가능합니다.");
			
			model.addAttribute("msg", msg);
			return "/message";			

		}
		
		MatchVO dbMatch = matchService.selectDBMatchByMtNum(mt_num);
		ClubMemberVO dbCM = matchService.selectClubMemberByMeNum(user.getMe_num(), cl_num);
		
		if(dbMatch == null || dbMatch.getMt_state1() == 1) {
			Message msg = new Message("match/search/solo", "삭제되거나 없는 경기입니다.");
			
			model.addAttribute("msg", msg);
			return "/message";			
		}else if(dbMatch.getMt_state1() == 2) {
			Message msg = new Message("match/search/solo", "종료된 경기입니다.");
			
			model.addAttribute("msg", msg);
			return "/message";			
		}
		
		if(cl_num == 0) {
			if(dbMatch.getMt_type() == 2) {
				Message msg = new Message("match/search/club?weekCount=0", "잘못된 접근입니다.");
				
				model.addAttribute("msg", msg);
				return "/message";
			}
		}else {
			if(dbMatch.getMt_type() == 1) {
				Message msg = new Message("match/search/solo", "잘못된 접근입니다.");
				
				model.addAttribute("msg", msg);
				return "/message";
			}
			//클럽 매치로 들어왔을 때 cl_num이 참가한 클럽이지만 접근한 계정이 해당 클럽의 소속이 아닌 경우 예외
			if(dbCM == null || (!dbCM.getCm_authority().equals("LEADER") && !dbCM.getCm_authority().equals("MEMBER"))) {
				Message msg = new Message("match/search/club?weekCount=0", "해당 클럽의 클럽원이 아닙니다.");
				
				model.addAttribute("msg", msg);
				return "/message";
			}else {
				model.addAttribute("authority", dbCM.getCm_authority());
			}
		}
		
		MatchVO match = matchService.selectMatchByMtNum(mt_num, user.getMe_num(), cl_num);
		ExpenseVO expense = matchService.selectPrice(cl_num, match.getTi_day());
		
		if(cl_num == 0) {
			if(match.getEntry_res() == 0) {
				if(match.getEntry_count() == match.getMt_personnel() * (match.getMt_rule() == 0 ? 2 : 3)) {
					Message msg = new Message("match/search/solo", "신청이 마감된 경기입니다.");
					
					model.addAttribute("msg", msg);
					return "/message";
				}
			}
			List<CouponVO> couponList = matchService.selectCouponListByMeNum(user.getMe_num());
			
			model.addAttribute("couponList", couponList);
		}else {
			//클럽 매치로 들어왔을 때 cl_num이 참가한 클럽이 아닌데 매치에 참가한 클럽팀의 수가 다찼으면 예외
			if(match.getEntry_res() == 0) {
				if(match.getTeam_count() == (match.getMt_rule() == 0 ? 2 : 3)) {
					Message msg = new Message("match/search/club?weekCount=0", "신청이 마감된 경기입니다.");
					
					model.addAttribute("msg", msg);
					return "/message";
				}
			}
		}
		List<TeamVO> teamList = matchService.selectTeamByMtNum(mt_num);
		List<EntryVO> entryList = matchService.selectEntryByMtNum(mt_num);
		
		model.addAttribute("cl_num", cl_num);
		model.addAttribute("user", user);
		model.addAttribute("match", match);
		model.addAttribute("expense", expense);
		model.addAttribute("teamList", teamList);
		model.addAttribute("entryList", entryList);
		return "/match/application";
	}
	
	@ResponseBody
	@PostMapping("/application/print/team")
	public Map<String, Object> printApplicationTeam(@RequestParam("mt_num")int mt_num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO manager = matchService.selectManagerByMtNum(mt_num);
		List<TeamVO> teamList = matchService.selectTeamByMtNum(mt_num);
		List<EntryVO> entryList = matchService.selectEntryByMtNum(mt_num);
		
		map.put("manager", manager);
		map.put("teamList", teamList);
		map.put("entryList", entryList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/application/print/club")
	public Map<String, Object> printApplicationClub(@RequestParam("mt_num")int mt_num, @RequestParam("cl_num")int cl_num){
		Map<String, Object> map = new HashMap<String, Object>();
		List<ClubMemberVO> CMList = matchService.selectClubMemberListByMtNum(cl_num, mt_num);
		MatchVO match = matchService.selectMatchByMtNum(mt_num, 0, cl_num);
		boolean res = true;
		if(match.getClub_entry_count() == match.getMt_personnel()) {
			res = false;
		}
		
		map.put("res", res);
		map.put("CMList", CMList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/match/application/solo")
	public Map<String, Object> applicationMatchSolo(
			@RequestParam("mt_num")int mt_num,
			@RequestParam("total_price")int point,
			@RequestParam("hp_num")int hp_num,
			HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO dbMember = memberService.getMember(user.getMe_id());
		
		boolean res = false;
		String msg = "신청 실패";
		
		if(dbMember.getMe_point() < point) {
			msg = "포인트가 부족합니다.\n보유 포인트 : " + dbMember.getMe_point();
			map.put("msg", msg);
			map.put("res", res);
			return map;
		}
		res = matchService.applicationMatchSolo(dbMember, mt_num, point, hp_num);
		if(res) {
			msg = "신청 성공";
		}
		
		map.put("msg", msg);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/match/cansel/solo")
	public Map<String, Object> canselMatchSolo(@RequestParam("mt_num")int mt_num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		boolean res = false;
		String msg = "취소 실패";
		
		res = matchService.canselMatchSolo(user.getMe_num(), mt_num);
		if(res) {
			msg = "취소 성공";
		}
		
		map.put("msg", msg);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/match/application/club")
	public Map<String, Object> applicationMatchClub(
			@RequestParam("mt_num")int mt_num,
			@RequestParam("total_price")int point,
			@RequestParam("cl_num")int cl_num,
			HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO dbMember = memberService.getMember(user.getMe_id());
		//병합후 서비스 변경
		ClubMemberVO dbCM = matchService.selectClubMemberByMeNum(user.getMe_num(), cl_num);
		
		boolean res = false;
		String msg = "신청 실패";
		
		if(!dbCM.getCm_authority().equals("LEADER")) {
			msg = "클럽 매치 신청권한이 없습니다.";
			map.put("msg", msg);
			map.put("res", res);
			return map;
		}
		if(dbMember.getMe_point() < point) {
			msg = "포인트가 부족합니다.\n보유 포인트 : " + dbMember.getMe_point();
			map.put("msg", msg);
			map.put("res", res);
			return map;
		}
		res = matchService.applicationMatchClub(user, cl_num, mt_num, point);
		if(res) {
			msg = "신청 성공";
		}

		map.put("msg", msg);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/match/cansel/club")
	public Map<String, Object> canselMatchClub(@RequestParam("mt_num")int mt_num, @RequestParam("cl_num")int cl_num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		ClubMemberVO dbCM = matchService.selectClubMemberByMeNum(user.getMe_num(), cl_num);

		boolean res = false;
		String msg = "취소 실패";
		
		if(dbCM == null || !dbCM.getCm_authority().equals("LEADER")) {
			msg = "클럽장만 취소 가능합니다.";
			
			map.put("msg", msg);
			map.put("res", res);
			return map;
		}
		
		res = matchService.canselMatchClub(user.getMe_num(), mt_num, cl_num);
		if(res) {
			msg = "취소 성공";
		}
		
		map.put("msg", msg);
		map.put("res", res);
		return map;
	}
	@ResponseBody
	@PostMapping("/club/entry/add")
	public Map<String, Object> insertEntryClub(
			@RequestParam("me_num")int me_num,
			@RequestParam("cl_num")int cl_num,
			@RequestParam("mt_num")int mt_num,
			HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MatchVO match = matchService.selectMatchByMtNum(mt_num, 0, cl_num);
		String msg = "등록 성공";
		boolean res = false;
		if(match.getClub_entry_count() == match.getMt_personnel()) {
			msg = "참가자를 모두 선택하였습니다.";
		}else {
			res = matchService.insertEntryClub(me_num, cl_num, mt_num);			
		}
		
		map.put("msg", msg);
		map.put("res", res);
		return map;
	}
	@ResponseBody
	@PostMapping("/club/entry/del")
	public Map<String, Object> deleteEntryClub(@RequestParam("en_num")int en_num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = matchService.deleteEntryClub(en_num);
		
		map.put("res", res);
		return map;
	}
}
