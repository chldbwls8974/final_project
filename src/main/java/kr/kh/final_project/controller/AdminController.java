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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.AdminService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.ReportVO;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;

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
		public Map<String, Object>updateManager2(@RequestBody ManagerVO manager, 
															Criteria cri
															){
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
	// 상업자 신청 수락버튼 (회원정보 수정)
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
	public String priceUpdatePost(Model model, int[] price,String date) {
		Message msg = new Message("/admin/price", "가격 수정에 실패하였습니다.");
		if(adminService.updatePrice(price,date)) {
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
			if(res) {
				List<ManagerVO> list = adminService.getBusinessList2(cri);
				map.put("list", list);
			}
			map.put("res", res);
			return map;
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
		System.out.println(report);
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
	
}
