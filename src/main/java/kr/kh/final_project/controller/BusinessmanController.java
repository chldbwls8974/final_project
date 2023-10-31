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
	
	@GetMapping("/businessman/facility")
	public String facility(Model model, HttpSession session) {
		//로그인한 유저 정보를 가져와서 member에 저장
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		//서비스에게 user 정보를 주고 시설 리스트 가져오라고 시킴
		List<FacilityVO> list = businessmanService.getFacilityList(member);

		//시설이 0이면
		if(list.size() == 0) {
			//등록된 시설이 없다는 메세지가 뜨면서 시설 등록 페이지로 이동하게 됨
	        Message msg = new Message("/businessman/facilityInsert", "등록된 시설이 없습니다. 시설을 등록해주세요");
			model.addAttribute("msg", msg);
			return "/message";
		}
		//가져온 리스트를 화면에 전송
		model.addAttribute("list", list);
		return "/businessman/facility";
	}
		
	@GetMapping("/businessman/facilityInsert")
	public String facilityInsert(Model model, FacilityVO facility, HttpSession session) {
		//로그인한 회원 정보를 가져오고, 권한이 사업자일 경우에만 사업자가 등록한 시설 정보를 알 수 있음
		//멤버와 사업자를 연결하기 위해 user 정보를 가져옴 (session은 로그인한 정보와 interceptor에 있는 정보만 가져오는 역할)
		MemberVO member = (MemberVO)session.getAttribute("user");
		//System.out.println(member);
		
		//user의 me_num을 가져와서 business에 저장 -> BusinessmanVO의 bu_num으로 facility 정보도 확인 가능
		BusinessmanVO business = businessmanService.getBusinessmanByNum(member.getMe_num());
		
		//서비스에게 MainRegion메서드를 가져와서 MainRegion에 저장
		List<RegionVO> MainRegion = businessmanService.getMainRegion();

		//business에 저장된 user의 me_num을 화면에 보여줌
		model.addAttribute("business", business);
		model.addAttribute("MainRegion",MainRegion);
		return "/businessman/facilityInsert";
	}
	
	@ResponseBody
	@GetMapping("/businessman/facilityInsert/region")
	public Map<String, Object> region(@RequestParam String rg_main, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> SubRegion = businessmanService.getSubRegionByMainRegion(rg_main);
		map.put("SubRegion", SubRegion);
		return map;
	}
	
	@PostMapping("/businessman/facilityInsert")
	public String insertfacility(Model model, FacilityVO facility, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//System.out.println(member);

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
		model.addAttribute("MainRegion",MainRegion);
		return "/util/message";
	}
	
	@GetMapping("/businessman/facilityUpdate")
	public String updateFacility(Model model, Integer fa_num, 
			HttpSession session) {
		//System.out.println(fa_num);
		MemberVO member = (MemberVO)session.getAttribute("user");
		//System.out.println(member);
		BusinessmanVO business = businessmanService.getBusinessmanByNum(member.getMe_num());

		FacilityVO facility = businessmanService.getFacility(fa_num);
		//System.out.println(fa_num);
		
		List<RegionVO> MainRegion = businessmanService.getMainRegion();

		if(member == null || facility == null || !member.getMe_num().equals(business.getBu_me_num())) {
			Message msg = new Message("/businessman/facility", "잘못된 접근입니다.");
			model.addAttribute("msg", msg);
			return "message";
		}
		model.addAttribute("business", business);
		model.addAttribute("facility", facility);
		model.addAttribute("MainRegion",MainRegion);
		return "/businessman/facilityUpdate";
	}
	
	@ResponseBody
	@GetMapping("/businessman/facilityUpdate/region1")
	//region1로 메서드명 변경 (facilityInsert와 중복되어서 바꿈)
	public Map<String, Object> region1(@RequestParam String rg_main, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> SubRegion = businessmanService.getSubRegionByMainRegion(rg_main);
		map.put("SubRegion", SubRegion);
		return map;
	}
	
	@PostMapping("/businessman/facilityUpdate")
	public String facilityUpdate(Model model, FacilityVO facility, HttpSession session) {
		System.out.println(facility);
		Message msg;
		MemberVO user = (MemberVO)session.getAttribute("user");
		BusinessmanVO business = businessmanService.getBusinessmanByNum(user.getMe_num());
		//System.out.println(business);
		
		List<RegionVO> MainRegion = businessmanService.getMainRegion();
		
		if(businessmanService.updateFacility(facility, business)) {
			msg = new Message("/businessman/facility?fa_num="+facility.getFa_num(), "시설 정보를 수정했습니다.");
		}else {
			msg = new Message("/businessman/facilityUpdate?fa_num="+facility.getFa_num(), "시설 정보를 수정하지 못했습니다."); 
		}
		model.addAttribute("MainRegion",MainRegion);
		model.addAttribute("msg", msg);
		return "message";
	}
	
	//==============================================================//
	
	@GetMapping("/businessman/stadium/{fa_num}")
	public String stadium(Model model, @PathVariable("fa_num")Integer fa_num, 
			HttpSession session) {
		//System.out.println(fa_num);
		
		//시설 번호를 통해 시설 정보를 가져와서 facility에 저장
		FacilityVO facility = businessmanService.getFacility(fa_num);
		//System.out.println(facility);
		
		//시설 번호를 주고 해당 시설번호에 등록된 경기장 리스트를 저장
		List<StadiumVO> stadiumList = businessmanService.getStadiumList(fa_num);
		
		//시설이 0이면
		if(stadiumList.size() == 0) {
			//등록된 경기장이 없다는 메세지가 뜨면서 경기장 등록 페이지로 이동하게 됨
	        Message msg = new Message("/businessman/stadiumInsert", "등록된 경기장이 없습니다. 경기장을 등록해주세요");
			model.addAttribute("msg", msg);
			return "/message";
		}
		model.addAttribute("facility", facility);
		model.addAttribute("stadiumList", stadiumList);
		return "/businessman/stadium";
	}
	
	@GetMapping("/businessman/stadiumInsert/{fa_num}")
	public String stadiumInsertGet(Model model, @PathVariable("fa_num")Integer fa_num, 
			FacilityVO facility, HttpSession session) {
		//System.out.println(fa_num);
		return "/businessman/stadiumInsert";
	}

	@PostMapping("/businessman/stadiumInsert/{fa_num}")
	public String insertStadium(Model model, StadiumVO stadium, 
			 HttpSession session) {
		//stadiumInsert.jsp에 이미 st_fa_num이 넘겨져 있기 때문에 fa_num불러오는 것 생략 가능
		//System.out.println(stadium);
		
		//경기장 등록 시 해당 fa_num에 등록을 했기 때문에 '등록'버튼을 누르면 url에 fa_num
		//이 표기되어야 해서 'i'에 시설 번호를 저장
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
	
	@GetMapping("/businessman/stadiumUpdate")
	public String updateStadium(Model model, Integer st_num, HttpSession session) {
		//st_num을 통해서 경기장 정보를 가져오고 stadium에 저장(st_fa_num 정보도 포함됨)
		StadiumVO stadium= businessmanService.getStadium(st_num);
		//System.out.println(stadium);
		
		model.addAttribute("stadium", stadium);
		return "/businessman/stadiumUpdate";
	}
	
	@PostMapping("/businessman/stadiumUpdate")
	public String stadiumUpdate(Model model, StadiumVO stadium, FacilityVO facility, HttpSession session) {
		System.out.println(stadium);
		Message msg;

		int i = stadium.getSt_fa_num();
	
		if(businessmanService.updateStadium(stadium, facility)) {
			msg = new Message("/businessman/stadium/" + i, "경기장 정보를 수정했습니다.");
		}else {
			msg = new Message("/businessman/stadiumUpdate?st_num="+stadium.getSt_num(), "경기장 정보를 수정하지 못했습니다."); 
		}
		model.addAttribute("msg", msg);
		return "message";
	}
	
	//====================================================================//

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
