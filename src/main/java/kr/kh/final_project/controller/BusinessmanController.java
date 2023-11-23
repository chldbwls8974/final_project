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
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.BusinessmanService;
import kr.kh.final_project.service.MatchService;
import kr.kh.final_project.service.ScheduleService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.AvailabilityVO;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityPictureVO;
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
	BusinessmanService businessmanService;
	
	@Autowired
	MatchService matchService;
	
	//시설 목록, 페이지네이션, 검색창
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
			
			cri.setS("");
			cri.setT("all");
			
			List<FacilityVO> allList = businessmanService.getFacilityList(member, cri);
			
			if(allList.size() == 0) {
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
		public String insertfacility(Model model, FacilityVO facility, HttpSession session,MultipartFile[] file) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			List<RegionVO> MainRegion = businessmanService.getMainRegion();

			//Service에게 user, facility 정보를 주고 insertFacility 메서드로 저장
			boolean res = businessmanService.insertFacility(user, facility,file);
				if(res) {
					model.addAttribute("msg", "시설 등록이 완료되었습니다. 시설목록에서 운영시간을 입력해주세요.");
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
			FacilityVO dbFacility = businessmanService.selectFacilityByMeNum(member.getMe_num(), fa_num);
			if(dbFacility == null) {
				Message msg = new Message("businessman/facility", "권한이 없거나 삭제된 시설입니다.");
				
				model.addAttribute("msg", msg);
				return "/message";
			}
			
			BusinessmanVO business = businessmanService.getBusinessmanByMeNum(member.getMe_num());
			//시설번호로 시설 정보 가져와서 저장
			FacilityVO facility = businessmanService.getFacility(fa_num);
			List<FacilityPictureVO> files = businessmanService.getFacilityPictureList(fa_num);
			
			List<RegionVO> MainRegion = businessmanService.getMainRegion();

			if(member == null || facility == null || !member.getMe_num().equals(business.getBu_me_num())) {
				Message msg = new Message("/businessman/facility", "잘못된 접근입니다.");
				model.addAttribute("msg", msg);
				return "message";
			}
			model.addAttribute("business", business);
			model.addAttribute("facility", facility);
			model.addAttribute("files", files);
			model.addAttribute("MainRegion", MainRegion);
			return "/businessman/facilityUpdate";
		}
		//시설 정보 수정 시 지역 수정 => region1로 메서드명 변경 (facilityInsert와 중복되어서 바꿈)
		@ResponseBody
		@GetMapping("/businessman/facilityUpdate/region1")
		public Map<String, Object> region1(@RequestParam String rg_main, Model model){
			Map<String, Object> map = new HashMap<String, Object>();
			List<RegionVO> SubRegion = businessmanService.getSubRegionByMainRegion(rg_main);
			map.put("SubRegion", SubRegion);
			return map;
		}
		//시설 정보 수정
		@PostMapping("/businessman/facilityUpdate")
		public String facilityUpdate(Model model, FacilityVO facility, HttpSession session, MultipartFile[] file, int [] delNums) {
			Message msg;
			MemberVO user = (MemberVO)session.getAttribute("user");
			//회원번호로 사업자 정보 가져와서 business에 저장
			BusinessmanVO business = businessmanService.getBusinessmanByMeNum(user.getMe_num());
			
			List<RegionVO> MainRegion = businessmanService.getMainRegion();
			
			
			if(businessmanService.updateFacility(facility, business)) {
				businessmanService.updateFacilityPicture(facility,file,delNums);	
				msg = new Message("/businessman/facility?fa_num="+facility.getFa_num(), "시설 정보를 수정했습니다.");
			}else {
				msg = new Message("/businessman/facilityUpdate?fa_num="+facility.getFa_num(), "시설 정보를 수정하지 못했습니다."); 
			}
			model.addAttribute("MainRegion", MainRegion);
			model.addAttribute("msg", msg);
			return "message";
		}
		//시설 삭제 => 해당 시설의 경기장도 삭제(화면에서만 삭제)
		@GetMapping("/businessman/facilityDelete")
		public String deleteFacility(@RequestParam Integer fa_num, Model model, 
				BusinessmanVO business, HttpSession session) {
			MemberVO user = (MemberVO)session.getAttribute("user");

			boolean res = businessmanService.facilityDelete(fa_num, user, business);
			if(res) {
				model.addAttribute("msg", "시설 삭제가 완료되었습니다.");
			}else {
				model.addAttribute("msg", "시설을 삭제하지 못했습니다.");
			}
		    model.addAttribute("url", "/businessman/facility");
		    return "/util/message";
		}
		
		
		//운영시간 페이지
		@GetMapping("/businessman/operating/{fa_num}")
		public String operating(Model model, @PathVariable("fa_num")Integer fa_num, 
				HttpSession session) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			FacilityVO dbFacility = businessmanService.selectFacilityByMeNum(user.getMe_num(), fa_num);
			if(dbFacility == null) {
				Message msg = new Message("businessman/facility", "권한이 없거나 삭제된 시설입니다.");
				
				model.addAttribute("msg", msg);
				return "/message";
			}
			//시설 번호를 통해 시설 정보를 가져와서 facility에 저장
			FacilityVO facility = businessmanService.getFacility(fa_num);
			
			List<OperatingVO> operatingList = businessmanService.getOperatingListByFaNum(fa_num);
			
			if(operatingList.size() == 0) {
		        Message msg = new Message("/businessman/operatingInsert/" + fa_num , "등록된 운영시간이 없습니다. 운영시간을 등록해주세요");
				model.addAttribute("msg", msg);
				return "/message";
			}
			model.addAttribute("facility", facility);
			model.addAttribute("operatingList", operatingList);
			return "/businessman/operating";
		}
		//운영시간 등록
		@GetMapping("/businessman/operatingInsert/{fa_num}")
		public String operatingInsertGet(Model model, @PathVariable("fa_num")Integer fa_num, 
				FacilityVO facility, HttpSession session) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			FacilityVO dbFacility = businessmanService.selectFacilityByMeNum(user.getMe_num(), fa_num);
			if(dbFacility == null) {
				Message msg = new Message("businessman/facility", "권한이 없거나 삭제된 시설입니다.");
				
				model.addAttribute("msg", msg);
				return "/message";
			}
			return "/businessman/operatingInsert";
		}
		//운영시간 등록
		@PostMapping("/businessman/operatingInsert")
		public String insertOperating(Model model, FacilityVO facility, HttpSession session) {
			//facilityVO에서 운영시간 리스트를 불러와서 operatingList 변수에 저장
			List<OperatingVO> operatingList = facility.getOperatingList();
			//오픈시간과 마감시간이 같으면 false;
			int fa_num = facility.getFa_num();

			boolean res = businessmanService.insertOperating(operatingList, fa_num);
			if(res) {
					model.addAttribute("msg", "운영시간 등록이 완료되었습니다.");
					//운영시간 등록이 완료되면 등록한 시설의 운영시간 목록으로 돌아가야 함
					model.addAttribute("url", "/businessman/operating/" + fa_num);
				}else {
					model.addAttribute("msg", "운영시간을 등록하지 못했습니다.");
					model.addAttribute("url", "/businessman/operatingInsert");
				}
			return "/util/message";
		}	
		//운영시간 수정
		@GetMapping("/businessman/operatingUpdate/{fa_num}")
		public String updateOperating(Model model, @PathVariable("fa_num")Integer fa_num, HttpSession session) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			FacilityVO dbFacility = businessmanService.selectFacilityByMeNum(user.getMe_num(), fa_num);
			if(dbFacility == null) {
				Message msg = new Message("businessman/facility", "권한이 없거나 삭제된 시설입니다.");
				
				model.addAttribute("msg", msg);
				return "/message";
			}
			
			List<OperatingVO> operatingList = businessmanService.getOperatingListByFaNum(fa_num);
			boolean res = true;
			
			model.addAttribute("operatingList", operatingList);
			return "/businessman/operatingUpdate";
		}
		//운영시간 수정
		@PostMapping("/businessman/operatingUpdate")
		public String operatingUpdate(Model model, FacilityVO facility, HttpSession session) {
			//facility에서 operatingList를 불러옴
			List<OperatingVO> operatingList = facility.getOperatingList();
			int fa_num = facility.getFa_num();
			/*
			boolean res = true;
			String day = null;
			String yesterday = null;
			for(int i = 0; i < 7; i++) {
				if(i == 0) {
					if(operatingList.get(6).getOp_open() > operatingList.get(6).getOp_close() && operatingList.get(0).getOp_open() < operatingList.get(6).getOp_close()) {
						yesterday = operatingList.get(6).getOp_day();
						day = operatingList.get(0).getOp_day();
						res = false;
					}
				}else {
					if(operatingList.get(i - 1).getOp_open() > operatingList.get(i - 1).getOp_close() && operatingList.get(i).getOp_open() < operatingList.get(i - 1).getOp_close()) {
						yesterday = operatingList.get(i - 1).getOp_day();
						day = operatingList.get(i).getOp_day();
						res = false;
					}
				}
			}
			if(!res) {
				model.addAttribute("msg", "마감시간이 자정을 넘을 경우 " + day + " 요일의 오픈시간이" + yesterday + " 요일의 마감시간보다 늦어야합니다.");
				
				return "/util/message";
			}
			*/
			boolean res = businessmanService.updateOperatingList(operatingList, fa_num);
			if(res) {
				model.addAttribute("msg", "시설 운영시간 수정이 완료되었습니다.");
				model.addAttribute("url", "/businessman/operating/" + fa_num);
			}else {
				model.addAttribute("msg", "시설 운영시간 수정에 실패했습니다.");
				model.addAttribute("url", "/businessman/operatingUpdate");
			}
		    return "/util/message";
		}
			
		
		//경기장 목록, 페이지네이션, 검색창
		@GetMapping("/businessman/stadium/{fa_num}")
		public String stadium(Model model, @PathVariable("fa_num")Integer fa_num, 
				HttpSession session, Criteria cri) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			
			//시설 번호를 통해 시설 정보를 가져와서 facility에 저장
			FacilityVO facility = businessmanService.getFacility(fa_num);
			//시설 번호로 사진들 가져옴
			List<FacilityPictureVO> files = businessmanService.getFacilityPictureList(fa_num);
			
			//시설 번호를 주고 해당 시설번호에 등록된 경기장 리스트를 저장
			List<StadiumVO> stadiumList = businessmanService.getStadiumList(fa_num, cri);
			//현재 페이지 정보(검색어, 타입)에 맞는 전체 경기장 수를 가져옴
			int totalCount = businessmanService.getTotalStadiumCount(cri, fa_num);
			//페이지네이션 페이지수
			final int DISPLAY_PAGE_NUM = 3;
			
			PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
			
			cri.setS("");
			cri.setT("all");
			List<StadiumVO> allStadiumList = businessmanService.getStadiumList(fa_num, cri);
			
			if(allStadiumList.size() == 0) {
		        Message msg = new Message("/businessman/stadiumInsert/" + fa_num , "등록된 경기장이 없습니다. 경기장을 등록해주세요");
				model.addAttribute("msg", msg);
				return "/message";
			}
			FacilityVO dbFacility = businessmanService.selectFacilityByMeNum(user.getMe_num(), fa_num);
			if(dbFacility == null) {
				Message msg = new Message("businessman/facility", "권한이 없거나 삭제된 시설입니다.");
				
				model.addAttribute("msg", msg);
				return "/message";
			}
			model.addAttribute("facility", facility);
			model.addAttribute("files", files);
			model.addAttribute("stadiumList", stadiumList);
			model.addAttribute("pm", pm);
			return "/businessman/stadium";
		}
		//경기장 등록
		@GetMapping("/businessman/stadiumInsert/{fa_num}")
		public String stadiumInsertGet(Model model, @PathVariable("fa_num")Integer fa_num, 
				FacilityVO facility, HttpSession session) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			FacilityVO dbFacility = businessmanService.selectFacilityByMeNum(user.getMe_num(), fa_num);
			if(dbFacility == null) {
				Message msg = new Message("businessman/facility", "권한이 없거나 삭제된 시설입니다.");
				
				model.addAttribute("msg", msg);
				return "/message";
			}
			return "/businessman/stadiumInsert";
		}
		//경기장 등록
		@PostMapping("/businessman/stadiumInsert")
		public String insertStadium(Model model, 
				StadiumVO stadium, HttpSession session, AvailabilityVO availability) {
			//'등록'버튼을 누르면 url에 저장한 시설의 번호(fa_num)가 표기되어야 해서 'i'에 시설 번호 저장
			int i = stadium.getSt_fa_num();
			
			//Service에게 stadium 정보를 주고 메서드로 가져와서 res에 저장
			boolean res = businessmanService.insertStadium(stadium, availability);
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
		public String updateStadium(Model model, Integer st_num, HttpSession session, AvailabilityVO availability) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			StadiumVO dbStadium = businessmanService.selectStadiumByMeNum(user.getMe_num(), st_num);
			if(dbStadium == null) {
				Message msg = new Message("businessman/facility", "권한이 없거나 삭제된 경기장입니다.");
				
				model.addAttribute("msg", msg);
				return "/message";
			}
			//st_num을 통해서 경기장 정보를 가져오고 stadium에 저장(st_fa_num 정보도 포함됨)
			StadiumVO stadium= businessmanService.getStadium(st_num);
			AvailabilityVO updateAvailabilityInfo = null;
			if(stadium.getSt_available() == 1) {
				updateAvailabilityInfo = businessmanService.getAvailability(st_num);				
			}
			model.addAttribute("updateAvailabilityInfo", updateAvailabilityInfo);
			model.addAttribute("stadium", stadium);
			return "/businessman/stadiumUpdate";
		}
		//경기장 정보 수정
		@PostMapping("/businessman/stadiumUpdate")
		public String stadiumUpdate(Model model, StadiumVO stadium, FacilityVO facility, HttpSession session, 
				AvailabilityVO availability) {
			//'j'에 해당 경기장의 '시설 번호' 저장 
			int j = stadium.getSt_fa_num();
			boolean res = businessmanService.updateStadium(stadium, availability);
			if(res) {
				matchService.updateMatchByStadium(stadium, availability);
				
				model.addAttribute("msg", "경기장 수정이 완료되었습니다.");
				model.addAttribute("url", "/businessman/stadium/" + j);
			}else {
				model.addAttribute("msg", "경기장 수정에 실패했습니다.");
				model.addAttribute("url", "/businessman/stadiumUpdate");
			}
		    return "/util/message";
		}
	
	@GetMapping("/buisnessman/manage/schedule")
	public String insertSchedule(Model model, HttpSession session, int fa_num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null || !user.getMe_authority().equals("BUSINESS")) {
			Message msg = new Message("/", "사업자 권한이 필요합니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		List<FacilityVO> facilityList = scheduleBService.selectFaNumByMeNum(user.getMe_num());
		List<StadiumVO> stadiumList = scheduleBService.selectStadiumListByFaNum(fa_num);
		List<OperatingVO> operatingList = scheduleBService.selectOperatingListByFaNum(fa_num);
		List<TimeVO> timeList = scheduleBService.selectTimeList();
		model.addAttribute("fa_num", fa_num);
		model.addAttribute("facilityList", facilityList);
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
