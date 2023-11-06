package kr.kh.final_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.BusinessmanService;
import kr.kh.final_project.service.RegionService;
import kr.kh.final_project.service.ScheduleService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.OperatingVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.ScheduleVO;
import kr.kh.final_project.vo.StadiumVO;
import kr.kh.final_project.vo.TimeVO;

@Controller
public class BusinessmanController {
	
	@Autowired
	ScheduleService scheduleBService;
		
	@Autowired
	private BusinessmanService businessmanService;
	
	@Autowired
	RegionService regionService;
	
	//시설 목록
	@GetMapping("/businessman/facility")
	public String facility(Model model, HttpSession session, Criteria cri) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		//서비스에게 user 정보를 주고 시설 리스트 가져오라고 시킴
		//현재 페이지 정보에 맞는 게시글을 가져오라고 서비스에게 시킴
		List<FacilityVO> list = businessmanService.getFacilityList(member, cri);
		
		//현재 페이지 정보(검색어, 타입)에 맞는 전체 게시글 수를 가져옴
		int totalCount = businessmanService.getTotalCount(cri, member);
		//페이지네이션 페이지수
		final int DISPLAY_PAGE_NUM = 3;
		
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		
		if(member == null || !member.getMe_authority().equals("BUSINESS")) {
			Message msg = new Message("/", "사업자 권한이 필요합니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		if(list.size() == 0) {
	        Message msg = new Message("/businessman/facilityInsert", "등록된 시설이 없습니다. 시설을 등록해주세요");
			model.addAttribute("msg", msg);
			return "/message";
		}
		model.addAttribute("list", list);
		model.addAttribute("pm", pm);
		return "/businessman/facility";
	}		
	//시설 등록
	@GetMapping("/businessman/facilityInsert")
	public String facilityInsert(Model model, FacilityVO facility, HttpSession session) {
		//멤버와 사업자를 연결하기 위해 user 정보를 가져옴 
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		//user의 me_num을 가져와서 business에 저장 -> BusinessmanVO의 bu_num으로 facility 정보도 확인 가능
		BusinessmanVO business = businessmanService.getBusinessmanByMeNum(member.getMe_num());
		
		//서비스에게 MainRegion메서드를 가져와서 MainRegion에 저장
		List<RegionVO> MainRegion = businessmanService.getMainRegion();

		if(member == null || !member.getMe_authority().equals("BUSINESS")) {
			Message msg = new Message("/", "사업자 권한이 필요합니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		model.addAttribute("business", business);
		model.addAttribute("MainRegion", MainRegion);
		return "/businessman/facilityInsert";
	}	
	//시설 등록 시 지역 선택(select box)
	@ResponseBody
	@GetMapping("/businessman/facilityInsert/region")
	public Map<String, Object> region(@RequestParam String rg_main, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> SubRegion = businessmanService.getSubRegionByMainRegion(rg_main);
		map.put("SubRegion", SubRegion);
		return map;
	}
	//시설 등록
	@PostMapping("/businessman/facilityInsert")
	public String insertfacility(Model model, FacilityVO facility, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		System.out.println(user);
		List<RegionVO> MainRegion = businessmanService.getMainRegion();

		//Service에게 user, facility 정보를 주고 insertFacility 메서드로 저장
		boolean res = businessmanService.insertFacility(user, facility);
			if(res) {
				model.addAttribute("msg", "시설 등록이 완료되었습니다.");
				model.addAttribute("url", "/businessman/facility");
			}else {
				model.addAttribute("msg", "시설을 등록하지 못했습니다.");
				model.addAttribute("url", "/businessman/facilityInsert");
			}
		model.addAttribute("MainRegion", MainRegion);
		return "/util/message";
	}	
	//시설 정보 수정
	@GetMapping("/businessman/facilityUpdate")
	public String updateFacility(Model model, Integer fa_num, 
			HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		//회원번호로 사업자 정보 가져와서 저장
		BusinessmanVO business = businessmanService.getBusinessmanByMeNum(member.getMe_num());
		//시설번호로 시설 정보 가져와서 저장
		FacilityVO facility = businessmanService.getFacility(fa_num);
		
		List<RegionVO> MainRegion = businessmanService.getMainRegion();

		if(member == null || facility == null || !member.getMe_num().equals(business.getBu_me_num())) {
			Message msg = new Message("/businessman/facility", "잘못된 접근입니다.");
			model.addAttribute("msg", msg);
			return "message";
		}
		System.out.println(MainRegion);
		model.addAttribute("business", business);
		model.addAttribute("facility", facility);
		model.addAttribute("MainRegion", MainRegion);
		return "/businessman/facilityUpdate";
	}
	//시설 정보 수정 시 지역 수정 => region1로 메서드명 변경 (facilityInsert와 중복되어서 바꿈)
	@ResponseBody
	@GetMapping("/businessman/facilityUpdate/region1")
	public Map<String, Object> region1(@RequestParam String rg_main, Model model){
		System.out.println("region");
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> SubRegion = businessmanService.getSubRegionByMainRegion(rg_main);
		System.out.println(SubRegion);
		map.put("SubRegion", SubRegion);
		return map;
	}
	
	//시설 정보 수정
	@PostMapping("/businessman/facilityUpdate")
	public String facilityUpdate(Model model, FacilityVO facility, HttpSession session) {
		Message msg;
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원번호로 사업자 정보 가져와서 business에 저장
		BusinessmanVO business = businessmanService.getBusinessmanByMeNum(user.getMe_num());
		
		List<RegionVO> MainRegion = businessmanService.getMainRegion();
		
		if(businessmanService.updateFacility(facility, business)) {
			msg = new Message("/businessman/facility?fa_num="+facility.getFa_num(), "시설 정보를 수정했습니다.");
		}else {
			msg = new Message("/businessman/facilityUpdate?fa_num="+facility.getFa_num(), "시설 정보를 수정하지 못했습니다."); 
		}
		model.addAttribute("MainRegion", MainRegion);
		model.addAttribute("msg", msg);
		return "message";
	}
	
	
	//경기장 목록
	@GetMapping("/businessman/stadium/{fa_num}")
	public String stadium(Model model, @PathVariable("fa_num")Integer fa_num, 
			HttpSession session) {
		//시설 번호를 통해 시설 정보를 가져와서 facility에 저장
		FacilityVO facility = businessmanService.getFacility(fa_num);
		
		//시설 번호를 주고 해당 시설번호에 등록된 경기장 리스트를 저장
		List<StadiumVO> stadiumList = businessmanService.getStadiumList(fa_num);
		
		if(stadiumList.size() == 0) {
	        Message msg = new Message("/businessman/stadiumInsert/" + fa_num , "등록된 경기장이 없습니다. 경기장을 등록해주세요");
			model.addAttribute("msg", msg);
			return "/message";
		}
		model.addAttribute("facility", facility);
		model.addAttribute("stadiumList", stadiumList);
		return "/businessman/stadium";
	}
	//경기장 등록
	@GetMapping("/businessman/stadiumInsert/{fa_num}")
	public String stadiumInsertGet(Model model, @PathVariable("fa_num")Integer fa_num, 
			FacilityVO facility, HttpSession session) {
		return "/businessman/stadiumInsert";
	}
	//경기장 등록
	@PostMapping("/businessman/stadiumInsert")
	public String insertStadium(Model model, 
			StadiumVO stadium, HttpSession session) {

		//'등록'버튼을 누르면 url에 저장한 시설의 번호(fa_num)가 표기되어야 해서 'i'에 시설 번호 저장
		int i = stadium.getSt_fa_num();
		
		//Service에게 stadium 정보를 주고 메서드로 가져와서 res에 저장
		boolean res = businessmanService.insertStadium(stadium);
			if(res) {
				model.addAttribute("msg", "경기장 등록이 완료되었습니다.");
				//경기장 등록이 완료되면 등록한 시설의 경기장 목록으로 돌아가야 함
				model.addAttribute("url", "/businessman/stadium/" + i);
			}else {
				model.addAttribute("msg", "경기장을 등록하지 못했습니다.");
				model.addAttribute("url", "/businessman/stadiumInsert");
			}
		return "/util/message";
	}
	//경기장 정보 수정
	@GetMapping("/businessman/stadiumUpdate")
	public String updateStadium(Model model, Integer st_num, HttpSession session) {
		//st_num을 통해서 경기장 정보를 가져오고 stadium에 저장(st_fa_num 정보도 포함됨)
		StadiumVO stadium= businessmanService.getStadium(st_num);
		
		model.addAttribute("stadium", stadium);
		return "/businessman/stadiumUpdate";
	}
	//경기장 정보 수정
	@PostMapping("/businessman/stadiumUpdate")
	public String stadiumUpdate(Model model, StadiumVO stadium, FacilityVO facility, HttpSession session) {
		//'j'에 해당 경기장의 '시설 번호' 저장 
		int j = stadium.getSt_fa_num();

		boolean res = businessmanService.updateStadium(stadium);
		if(res) {
			model.addAttribute("msg", "경기장 수정이 완료되었습니다.");
			model.addAttribute("url", "/businessman/stadium/" + j);
		}else {
			model.addAttribute("msg", "경기장 수정에 실패했습니다.");
			model.addAttribute("url", "/businessman/stadiumUpdate");
		}
	    return "/util/message";
	}
	
	

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
