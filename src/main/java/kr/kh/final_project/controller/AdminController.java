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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import kr.kh.final_project.dao.FacilityDAO;
import kr.kh.final_project.dao.OperatingDAO;
import kr.kh.final_project.dao.StadiumDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.AdminService;
import kr.kh.final_project.service.BusinessmanService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.OperatingVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.ReportVO;
import kr.kh.final_project.vo.StadiumVO;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	FacilityDAO facilityDao;

	@Autowired
	StadiumDAO stadiumDao;
	
	@Autowired
	OperatingDAO operatingDao;
	
	@Autowired
	BusinessmanService businessmanService;
	
	// 회원정보 출력하기 ,페이지네이션 기능구현
	@GetMapping("/admin/member")
	public String adminMember(Model model, Criteria cri) {
		//회원정보를 가져오라고 서비스에게 시킨다.
		//가져온 리스트 정보는 list에 담는다.
		//int me_num = 1;
		//List<MemberVO> list = adminService.getMemberList(me_num);
		//페이지네이션
		// perPageNum : 한페이지에서 보여줄 컨텐츠 개수
		cri.setPerPageNum(10);
		//현재 페이지 정보(검색어, 타입)에 맞는 전체 게시글 수(TotalCount)를 가져온다.
		int totalCount = adminService.getTotalCount(cri);
		//페이지네이션 페이지수
		final int DISPLAY_PAGE_NUM = 3;
		// DISPLAY_PAGE_NUM,cri,totalCount의 정보를 가지고 pageMaker를 만들어 pm으로 넣음
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		
		//현재 페이지 정보를 주면서 memberService한테 회원 리스트를 가져오라고 하고 list에 담는다.
		List<MemberVO> list = adminService.getMemberList(cri);
		
		
		// 가져온 회원정보를 리스트에 담에 화면에 전송한다.
		// "list" : 내가 화면에서 사용할 이름 / list : 화면에서 보여지는 값
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pm", pm);
		return "/admin/member";
	}
	
	//매니저 신청 조회 하기
		@GetMapping("/admin/manager")
		public String adminMananger(Model model, Criteria cri) {
			//페이지네이션
			// 밑에 있는 cri의 영향을 받으려면 getManagerList를 cri.setPerPageNum보다 아래에 있어야함
			cri.setPerPageNum(5);
			//현재 페이지 정보(검색어, 타입)에 맞는 전체 게시글 수(TotalCount)를 가져온다.
			int totalCount2 = adminService.getTotalCount2(cri);
			//페이지네이션 페이지수
			final int DISPLAY_PAGE_NUM = 3;
			// DISPLAY_PAGE_NUM,cri,totalCount의 정보를 가지고 pageMaker를 만들어 pm으로 넣음
			PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount2);
			
			List<ManagerVO> list = adminService.getManagerList(cri);
			//화면에 전송
			model.addAttribute("list", list);
			model.addAttribute("cri", cri);
			model.addAttribute("pm", pm);
			return "/admin/manager";
		} 	
	
		// 매니저 신청 수락버튼 (회원정보 수정)
		@ResponseBody
		@PostMapping("/admin/manager")
		public Map<String, Object>updateManager(@RequestBody ManagerVO manager, Criteria cri){
			// 결과 데이터를 넣기 위한 map을 만듬
			Map<String, Object> map = new HashMap<String, Object>();
			//ManagerVO user = (ManagerVO)session.getAttribute("user");
			
			boolean res = adminService.updateManager(manager);
			if(res) {
				List<ManagerVO> list = adminService.getManagerList(cri);
				map.put("list", list);
			}
			map.put("res", res);
			return map;
		}
		
		//매니저권한 조회 하기 (2)
		@GetMapping("/admin/manager2")
		public String adminMananger2(Model model, Criteria cri) {
			//페이지네이션
			// 밑에 있는 cri의 영향을 받으려면 getManagerList를 cri.setPerPageNum보다 아래에 있어야함
			cri.setPerPageNum(5);
			//현재 페이지 정보(검색어, 타입)에 맞는 전체 게시글 수(TotalCount)를 가져온다.
			int totalCount3 = adminService.getTotalCount3(cri);
			//페이지네이션 페이지수
			final int DISPLAY_PAGE_NUM = 3;
			// DISPLAY_PAGE_NUM,cri,totalCount의 정보를 가지고 pageMaker를 만들어 pm으로 넣음
			PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount3);
			
			List<ManagerVO> list = adminService.getManagerList2(cri);
			//화면에 전송
			model.addAttribute("list", list);
			model.addAttribute("cri", cri);
			model.addAttribute("pm", pm);
			return "/admin/manager2";
		} 
		
	// 매니저권한 취소버튼 (회원정보 수정) (2)
		@ResponseBody
		@PostMapping("/admin/manager2")
		public Map<String, Object>updateManager2(
				@RequestBody ManagerVO manager, 
				Criteria cri){
			System.out.println(manager);
			// 결과 데이터를 넣기 위한 map을 만듬
			Map<String, Object> map = new HashMap<String, Object>();
			//ManagerVO user = (ManagerVO)session.getAttribute("user");
			boolean res = adminService.updateManager2(manager);
			
			if(res) {
				List<ManagerVO> list = adminService.getManagerList2(cri);
				map.put("list", list);
			}
			map.put("res", res);
			return map;
		}

	// 사업자 신청 조회하기, 페이지네이션 기능구현
	@GetMapping("/admin/business")
	public String adminBusiness(Model model, Criteria cri) {
		//페이지네이션
		// 밑에 있는 cri의 영향을 받으려면 getBusinessList를 cri.setPerPageNum보다 아래에 있어야함
		// perPageNum : 한페이지에서 보여줄 컨텐츠 갯수 5개씩 보여주겠다 선언
		cri.setPerPageNum(5);
		//현재 페이지 정보(검색어, 타입)에 맞는 전체 게시글 수(TotalCount)를 가져온다.
		int totalCount4 = adminService.getTotalCount4(cri);
		//페이지네이션 페이지수
		final int DISPLAY_PAGE_NUM = 3;
		// DISPLAY_PAGE_NUM,cri,totalCount의 정보를 가지고 pageMaker를 만들어 pm으로 넣음
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount4);
		// 사업자신청을 조회하는 list를 cri.setPerPageNum의 영향을 받고 가지고 가져온다.
		List<ManagerVO> list = adminService.getBusinessList(cri);
	
		// 화면에 출력하기
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pm", pm);
		return ("/admin/business");
	}
	// 사업자 신청 수락버튼 (회원정보 수정)
	@ResponseBody
	@PostMapping("/admin/business")
	public Map<String, Object>updateBusiness(@RequestBody ManagerVO manager, Criteria cri){
		// 결과 데이터를 넣기 위한 map을 만듬
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = adminService.updateBusiness(manager);
		if(res) {
			List<ManagerVO> list = adminService.getBusinessList(cri);
			map.put("list", list);
		}
		map.put("res", res);
		return map;
	}
	
	@GetMapping("/admin/price")
	public String priceUpdate(Model model) {
		List<ExpenseVO> list = adminService.getPriceList();
		model.addAttribute("list",list);
		return "/admin/price";
	}
	
	@PostMapping("/admin/price")
	public String priceUpdatePost(Model model, int[] price,String date, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		Message msg = new Message("/admin/price", "가격 수정에 실패하였습니다.");
		if(adminService.updatePrice(price,date)) {
			// 공지 등록
			adminService.noteregistration(price,date,user);
			msg = new Message("", "가격 수정에 성공하였습니다.");
		}
		model.addAttribute("msg", msg);
		return "message";
	}
	// 사업자 조회하기, 페이지네이션 기능구현 (2)
		@GetMapping("/admin/business2")
		public String adminBusiness2(Model model, Criteria cri) {
			//페이지네이션
			// 밑에 있는 cri의 영향을 받으려면 getBusinessList를 cri.setPerPageNum보다 아래에 있어야함
			// perPageNum : 한페이지에서 보여줄 컨텐츠 갯수 5개씩 보여주겠다 선언
			cri.setPerPageNum(5);
			//현재 페이지 정보(검색어, 타입)에 맞는 전체 게시글 수(TotalCount)를 가져온다.
			int totalCount5 = adminService.getTotalCount5(cri);
			//페이지네이션 페이지수
			final int DISPLAY_PAGE_NUM = 3;
			// DISPLAY_PAGE_NUM,cri,totalCount의 정보를 가지고 pageMaker를 만들어 pm으로 넣음
			PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount5);
			// 사업자신청을 조회하는 list를 cri.setPerPageNum의 영향을 받고 가지고 가져온다.
			List<ManagerVO> list = adminService.getBusinessList2(cri);
		
			// 화면에 출력하기
			model.addAttribute("list", list);
			model.addAttribute("cri", cri);
			model.addAttribute("pm", pm);
			return ("/admin/business2");
		}
		// 사업자 권한 수정 (회원정보 수정)(2)
		@ResponseBody
		@PostMapping("/admin/business2")
		public Map<String, Object>updateBusiness2(@RequestBody ManagerVO manager, Criteria cri){
			// 결과 데이터를 넣기 위한 map을 만듬
			Map<String, Object> map = new HashMap<String, Object>();
			
			boolean res = adminService.updateBusiness2(manager);
			System.out.println(manager);
			if(res) {
				List<ManagerVO> list = adminService.getBusinessList2(cri);
				map.put("list", list);
			}
			map.put("res", res);
			return map;
		}
		// 사업자등록 조회 (3)
		@GetMapping("/admin/business3")
		public String adminBusiness3(Model model, Criteria cri) {
			// 페이지네이션
			cri.setPerPageNum(5);
			int totalCount = adminService.getTotalCountByBusiness(cri);
			final int DISPLAY_PAGE_NUM = 3;
			PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
			// 사업자 조회하기
			List<BusinessmanVO> list = adminService.getBusinessListByInsert(cri);
			
			// 사업자 출력
			model.addAttribute("list", list);
			model.addAttribute("pm", pm);
			return ("/admin/business3");
		}
		// 사업자등록하기 (3)
		@GetMapping("/admin/insert")
		public String adminInsert() {
			return "/admin/insert";
		}
		// 사업자 등록하기(3)
		@PostMapping("/admin/insert")
		public String adminInsert(Model model, BusinessmanVO businessman, HttpSession session) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			boolean res = adminService.insertBusiness(businessman, user);
			if(res) {
				model.addAttribute("msg", "사업자 등록 성공");
				model.addAttribute("url", "/admin/business3");
			}else {
				model.addAttribute("msg", " 사업자 등록 실패");
				model.addAttribute("url", "/admin/insert");
			}
			return"/util/message";
		}
		// 사업자수정하기 화면 조회하기 (3)
		@GetMapping("/admin/update")
		public String adminUpdate(Model model, Integer bu_num) {
			// 서비스한테 사업자 리스트 가져오라고 시킴
			BusinessmanVO business = adminService.getBusinessList3(bu_num);
			
			model.addAttribute("business", business);
			return "/admin/update";
		}
		// 사업자 수정하기(3)
		@PostMapping("/admin/update")
		public String adminUpdate(Model model, BusinessmanVO businessman) {
			boolean res = adminService.update(businessman);
			
			if(res) {
				model.addAttribute("msg","사업자 정보를 수정했습니다.");
				model.addAttribute("url","/admin/business3");
			}else {
				model.addAttribute("msg", "사업자 정보수정 실패");
				model.addAttribute("url","/admin/update?bu_num="+businessman.getBu_num());
			}
			return "/util/message";
		}
		// 사업자 삭제하기 (3)
		@GetMapping("/admin/delete")
		public String adminDelete(Model model,Integer bu_num) {
			boolean res = adminService.deleteBusiness(bu_num);
			
			if(res) {
				model.addAttribute("msg", "사업자를 삭제하였습니다.");
				model.addAttribute("url", "/admin/business3");
			}else {
				model.addAttribute("msg", "삭제 실패하였습니다.");
				model.addAttribute("url", "/admin/business3");
			}
			return "/util/message";
		}
	
	@GetMapping("/admin/refund")
	public String refundManagement(Model model) {
		return ("/admin/refund");
	}
	
	@ResponseBody
	@PostMapping("/admin/refund/search")
	public Map<String, Object> refundManagementSearch(@RequestBody ObjectNode saveObj) throws JsonProcessingException {
		Map<String, Object> map = new HashMap<String, Object>();
		// json데이터를 객체로 만들기 위해서 ObjectMapper 이용
		ObjectMapper mapper = new ObjectMapper();   
		Criteria cri = mapper.treeToValue(saveObj.get("cri"), Criteria.class);
	    String searchType1 = saveObj.get("searchType1").asText();
	    String searchType2 = saveObj.get("searchType2").asText();
	    //검색에 맞는 리스트 가져오는 메서드
	    List<PointHistoryVO> refundList = adminService.getRefundListBySearch(cri, searchType1, searchType2);
	    //totalCount 구하는 메서드
	    int totalCount = adminService.getRefundListBySearchCount(cri, searchType1, searchType2);

	    //보여줄 페이지 수 = 3
	    PageMaker pm = new PageMaker(3, cri, totalCount);
	    map.put("refundList", refundList);
	    map.put("pm", pm);
		return map;
	}
	
	//신고 관리 페이지
	@GetMapping("/admin/boardReport")
	public String boardReportManagement(Model model) {
		return ("/admin/boardReport");
	}
	@GetMapping("/admin/matchReport")
	public String matchReportManagement(Model model) {
		return ("/admin/matchReport");
	}
	//검색 조건에 맞는 신고리스트를 반환하는 메서드
	@ResponseBody
	@PostMapping("/admin/report/search")
	public Map<String, Object> boardReportManagementSearch(@RequestBody ObjectNode saveObj) throws JsonProcessingException {
		Map<String, Object> map = new HashMap<String, Object>();
		// json데이터를 객체로 만들기 위해서 ObjectMapper 이용
		ObjectMapper mapper = new ObjectMapper();   
		Criteria cri = mapper.treeToValue(saveObj.get("cri"), Criteria.class);
	    String searchType1 = saveObj.get("searchType1").asText();
	    String searchType2 = saveObj.get("searchType2").asText();
	    String reportType = saveObj.get("reportType").asText();
	    //검색에 맞는 리스트 가져오는 메서드
	    List<ReportVO> reportList = adminService.getReportListBySearch(cri, reportType, searchType1, searchType2);
	    //totalCount 구하는 메서드
	    int totalCount = adminService.getReportListBySearchCount(cri, reportType, searchType1, searchType2);
	    //보여줄 페이지 수 = 3
	    PageMaker pm = new PageMaker(3, cri, totalCount);
	    map.put("reportList", reportList);
	    map.put("pm", pm);
		return map;
	}
	
	//화면에서 받아온 값으로 신고를 확인, 제재 상태로 변경하는 메서드
	@ResponseBody
	@PostMapping("/admin/report/handle")
	public Map<String, Object> reportHandle(@RequestBody ReportVO report) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = adminService.reportHandle(report);
		map.put("res", res);
		return map;
	}
	
	
	
		
	@ResponseBody
	@PostMapping("/admin/refund/approval")
	public Map<String, Object> refundApproval(@RequestBody PointHistoryVO ph){
		Map<String, Object> map = new HashMap<String, Object>();
		//포인트 환급신청의 상태를 완료로 변경함
		boolean res = adminService.refundApproval(ph);
		map.put("res", res);
		return map;
	}
	
	
	//시설 목록
	@GetMapping("/admin/facilitylist")
	public String facilityList(Model model, HttpSession session, Criteria cri) {
		List<FacilityVO> list = adminService.selectFacilityAllList(cri);
		
		int totalCount = adminService.getFacilityListTotalCount(cri);
		final int DISPLAY_PAGE_NUM = 3;
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);

		model.addAttribute("list", list);
		model.addAttribute("pm", pm);
		return "/admin/facilitylist";
	}
	//시설 정보 수정
	@GetMapping("/admin/facilitylistUpdate")
	public String updateFacilityList(Model model, Integer fa_num, 
			HttpSession session) {
		//시설번호로 시설 정보 가져와서 저장
		FacilityVO facility = adminService.updateFacilityByAdmin(fa_num);
		
		List<RegionVO> MainRegion = adminService.getMainRegion();

		if(facility == null) {
			Message msg = new Message("/admin/facilitylist", "잘못된 접근입니다.");
			model.addAttribute("msg", msg);
			return "message";
		}
		model.addAttribute("facility", facility);
		model.addAttribute("MainRegion", MainRegion);
		return "/admin/facilitylistUpdate";
	}
	//시설 정보 수정 시 지역 수정
	@ResponseBody
	@GetMapping("/admin/facilitylistUpdate/region1")
	public Map<String, Object> region1(@RequestParam String rg_main, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> SubRegion = adminService.getSubRegionByMainRegion(rg_main);
		map.put("SubRegion", SubRegion);
		return map;
	}
	//시설 정보 수정
	@PostMapping("/admin/facilitylistUpdate")
	public String facilityUpdate(Model model, FacilityVO facility, HttpSession session) {
		Message msg;
		
		List<RegionVO> MainRegion = adminService.getMainRegion();
		
		if(facilityDao.updateFacility(facility)) {
			msg = new Message("/admin/facilitylist?fa_num="+facility.getFa_num(), "시설 정보를 수정했습니다.");
		}else {
			msg = new Message("/admin/facilitylistUpdate?fa_num="+facility.getFa_num(), "시설 정보를 수정하지 못했습니다."); 
		}
		model.addAttribute("MainRegion", MainRegion);
		model.addAttribute("msg", msg);
		return "message";
	}
	
	
	//운영시간 페이지
	@GetMapping("/admin/operatinglist/{fa_num}")
	public String operating(Model model, @PathVariable("fa_num")Integer fa_num, 
			HttpSession session) {
		//시설 번호를 통해 시설 정보를 가져와서 facility에 저장
		FacilityVO facility = facilityDao.selectFacility(fa_num);
		
		List<OperatingVO> operatingList = operatingDao.selectOperatingListByFaNum(fa_num);
		
		if(operatingList.size() == 0) {
	        Message msg = new Message("/admin/facilitylist", "등록된 운영시간이 없습니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		model.addAttribute("facility", facility);
		model.addAttribute("operatingList", operatingList);
		return "/admin/operatinglist";
	}
	//운영시간 수정
	@GetMapping("/admin/operatinglistUpdate/{fa_num}")
	public String updateOperating(Model model, @PathVariable("fa_num")Integer fa_num, HttpSession session) {
		List<OperatingVO> operatingList = operatingDao.selectOperatingListByFaNum(fa_num);		
		model.addAttribute("operatingList", operatingList);
		return "/admin/operatinglistUpdate";
	}
	//운영시간 수정
	@PostMapping("/admin/operatinglistUpdate")
	public String operatingUpdate(Model model, FacilityVO facility, HttpSession session) {
		//facility에서 operatingList를 불러옴
		List<OperatingVO> operatingList = facility.getOperatingList();
		int fa_num = facility.getFa_num();

		boolean res = businessmanService.updateOperatingList(operatingList, fa_num);
		if(res) {
			model.addAttribute("msg", "시설 운영시간 수정이 완료되었습니다.");
			model.addAttribute("url", "/admin/operatinglist/" + fa_num);
		}else {
			model.addAttribute("msg", "시설 운영시간 수정에 실패했습니다.");
			model.addAttribute("url", "/admin/operatinglistUpdate");
		}
	    return "/util/message";
	}
	
	
	//경기장 목록
	@GetMapping("/admin/stadiumlist/{fa_num}")
	public String stadium(Model model, @PathVariable("fa_num")Integer fa_num, 
			HttpSession session, Criteria cri) {
		//시설 번호를 통해 시설 정보를 가져와서 facility에 저장
		FacilityVO facility = adminService.updateFacilityByAdmin(fa_num);
		
		//시설 번호를 주고 해당 시설번호에 등록된 경기장 리스트를 저장
		List<StadiumVO> stadiumList = adminService.getStadiumListByAdmin(fa_num, cri);
		//현재 페이지 정보(검색어, 타입)에 맞는 전체 경기장 수를 가져옴
		int totalCount = adminService.getTotalStadiumCountByAdmin(cri, fa_num);
		//페이지네이션 페이지수
		final int DISPLAY_PAGE_NUM = 3;
		
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		
		if(stadiumList.size() == 0) {
	        Message msg = new Message("/admin/facilitylist", "등록된 경기장이 없습니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		model.addAttribute("facility", facility);
		model.addAttribute("stadiumList", stadiumList);
		model.addAttribute("pm", pm);
		return "/admin/stadiumlist";
	}
	//경기장 정보 수정
	@GetMapping("/admin/stadiumlistUpdate")
	public String updateStadium(Model model, Integer st_num, HttpSession session) {
		StadiumVO stadium= stadiumDao.selectStadium(st_num);
		
		model.addAttribute("stadium", stadium);
		return "/admin/stadiumlistUpdate";
	}
	//경기장 정보 수정
	@PostMapping("/admin/stadiumlistUpdate")
	public String stadiumUpdate(Model model, StadiumVO stadium, FacilityVO facility, HttpSession session) {
		int j = stadium.getSt_fa_num();

		boolean res = stadiumDao.updateStadium(stadium);
		if(res) {
			model.addAttribute("msg", "경기장 수정이 완료되었습니다.");
			model.addAttribute("url", "/admin/stadiumlist/" + j);
		}else {
			model.addAttribute("msg", "경기장 수정에 실패했습니다.");
			model.addAttribute("url", "/admin/stadiumlistUpdate");
		}
	    return "/util/message";
	}
}
