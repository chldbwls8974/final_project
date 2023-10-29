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

		//회원번호 정보로 시설 정보를 가져오는 메서드를 비즈니스서비스에게 가져와서 fa_num 변수에 저장
		int fa_num = businessmanService.selectFaNumByMeNum(member.getMe_num());

		//user의 등록된 시설이 0이면
		if(fa_num == 0) {
			//등록된 시설이 없다는 메세지가 뜨면서 시설 등록 페이지로 이동하게 됨
	        Message msg = new Message("/businessman/facilityInsert", "등록된 시설이 없습니다. 시설을 등록해주세요");
			model.addAttribute("msg", msg);
			return "/message";
		}
		//서비스에게 시설 리스트 가져오라고 시킴
		List<FacilityVO> list = businessmanService.getFacilityList();

		//가져온 리스트를 화면에 전송
		model.addAttribute("list", list);
		return "/businessman/facility";
	}
		
	@GetMapping("/businessman/facilityInsert")
	public String facilityInsert(Model model, HttpSession session) {
		//로그인한 회원 정보를 가져오고, 권한이 사업자일 경우에만 사업자가 등록한 시설 정보를 알 수 있음
		//멤버와 사업자를 연결하기 위해 user 정보를 가져옴 (session은 로그인한 정보와 interceptor에 있는 정보만 가져오는 역할)
		MemberVO user = (MemberVO)session.getAttribute("user");
		 
		//user의 me_num을 가져와서 business에 저장 -> BusinessmanVO의 bu_num으로 facility 정보도 확인 가능
		BusinessmanVO business = businessmanService.getBusinessmanByNum(user.getMe_num());

		//서비스에게 MainRegion메서드를 가져와서 MainRegion에 저장
		List<RegionVO> MainRegion = businessmanService.getMainRegion();

		//business에 저장된 user의 me_num을 화면에 보여줌
		model.addAttribute("business", business);
		model.addAttribute("MainRegion",MainRegion);
		return "/businessman/facilityInsert";
	}

	@ResponseBody
	@GetMapping("/businessman/facilityInsert/region")
	public Map<String, Object> region(@RequestParam String rg_main,  Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> SubRegion = businessmanService.getSubRegionByMainRegion(rg_main);
		map.put("SubRegion", SubRegion);
		return map;
	}
	
	@PostMapping("/businessman/facilityInsert")
	public String insertfacility(Model model, FacilityVO facility, HttpSession session) {
		//System.out.println(facility);
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		int fa_num = businessmanService.selectFaNumByMeNum(member.getMe_num());

		//Service에게 user, facility 정보를 주고 insertFacility 메서드로 저장
		boolean res = businessmanService.insertFacility(member, facility, fa_num);
			if(res) {
				model.addAttribute("msg", "시설 등록이 완료되었습니다.");
				model.addAttribute("url", "/businessman/facility");
			}else {
				model.addAttribute("msg", "시설을 등록하지 못했습니다.");
				model.addAttribute("url", "/businessman/facilityInsert");
			}
		return "/util/message";
	}
	
	@GetMapping("/businessman/stadium")
	public String stadium(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");

		int fa_num = businessmanService.selectFaNumByMeNum(member.getMe_num());
		
		List<StadiumVO> stadiumList = businessmanService.getStadiumList();

		model.addAttribute("stadiumList", stadiumList);
		return "/businessman/stadium";
	}
	
	@GetMapping("/businessman/stadiumInsert")
	public String stadiumInsert(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		 
		//user의 me_num을 가져와서 business에 저장 -> BusinessmanVO의 bu_num으로 facility 정보도 확인 가능
		BusinessmanVO business = businessmanService.getBusinessmanByNum(user.getMe_num());

		//business에 저장된 user의 me_num을 화면에 보여줌
		model.addAttribute("business", business);
		return "/businessman/stadiumInsert";
	}

	
	@GetMapping("/businessman/manage/schedule")
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
		return "/businessman/schedule";
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
