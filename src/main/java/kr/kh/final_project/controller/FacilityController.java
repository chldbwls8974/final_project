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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.final_project.dao.FacilityDAO;
import kr.kh.final_project.dao.OperatingDAO;
import kr.kh.final_project.dao.StadiumDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.AdminService;
import kr.kh.final_project.service.BusinessmanService;
import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityPictureVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.StadiumVO;

@Controller
public class FacilityController {
	
	@Autowired
	MemberService memberService;
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
	
	@GetMapping("/facility/list")
	public String facilityList(Model model, HttpSession session, Criteria cri) {
		List<FacilityVO> list = adminService.selectFacilityAllList(cri);
		List<RegionVO> MainRegion = memberService.getMainRegion();
		int totalCount = adminService.getFacilityListTotalCount(cri);
		final int DISPLAY_PAGE_NUM = 3;
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		
		model.addAttribute("list", list);
		model.addAttribute("MainRegion",MainRegion);
		model.addAttribute("pm", pm);
		return "/facility/list";
		
	}
	
	@ResponseBody
	@GetMapping("/facility/select")
	public Map<String, Object> facilitySelect(@RequestParam String rg_main){
		Map<String, Object> map = new HashMap<String, Object>();
		List<FacilityVO> rglist = adminService.selectFacilityListByRegion(rg_main);
		map.put("rglist", rglist);
		return map;
		
	}
	
	
	//경기장 목록
	@GetMapping("/facility/detail/{fa_num}")
	public String facilitydetail(Model model, @PathVariable("fa_num")Integer fa_num, 
			HttpSession session, Criteria cri) {
		//시설 번호를 통해 시설 정보를 가져와서 facility에 저장
		FacilityVO facility = adminService.updateFacilityByAdmin(fa_num);
		List<FacilityPictureVO> files = businessmanService.getFacilityPictureList(fa_num);
		BusinessmanVO owner = businessmanService.getBusinessmanByBuNum(facility.getFa_bu_num());
		//시설 번호를 주고 해당 시설번호에 등록된 경기장 리스트를 저장
		List<StadiumVO> stadiumList = adminService.getStadiumListByAdmin(fa_num, cri);
		//현재 페이지 정보(검색어, 타입)에 맞는 전체 경기장 수를 가져옴
		int totalCount = adminService.getTotalStadiumCountByAdmin(cri, fa_num);
		//페이지네이션 페이지수
		final int DISPLAY_PAGE_NUM = 3;
		
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		
		if(stadiumList.size() == 0) {
	        Message msg = new Message("/facility/list", "등록된 경기장이 없습니다.");
			model.addAttribute("msg", msg);
			return "/message";
		}
		model.addAttribute("facility", facility);
		model.addAttribute("files", files);
		model.addAttribute("owner", owner);
		model.addAttribute("stadiumList", stadiumList);
		model.addAttribute("pm", pm);
		return "/facility/detail";
	}

	
	
//	
//	// 차순위
//	@GetMapping("/facility/tmplist")
//	public String facilitylist(Model model, HttpSession session, Criteria cri) {
//		List<FacilityVO> list = adminService.selectFacilityAllList(cri);
//		List<StadiumVO> sublist = businessmanService.selectAllStadium();
//		
//		int totalCount = adminService.getFacilityListTotalCount(cri);
//		final int DISPLAY_PAGE_NUM = 3;
//		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
//
//		model.addAttribute("list", list);
//		model.addAttribute("sublist", sublist);
//		model.addAttribute("pm", pm);
//		return "/facility/tmplist";
//
//	}
//	//경기장 목록
//		@GetMapping("/facility/tmpdetail/{fa_num}")
//		public String facilitydetail(Model model, @PathVariable("fa_num")Integer fa_num, 
//				HttpSession session, Criteria cri) {
//			//시설 번호를 통해 시설 정보를 가져와서 facility에 저장
//			FacilityVO facility = adminService.updateFacilityByAdmin(fa_num);
//			List<FacilityPictureVO> files = businessmanService.getFacilityPictureList(fa_num);
//			
//			//시설 번호를 주고 해당 시설번호에 등록된 경기장 리스트를 저장
//			List<StadiumVO> stadiumList = adminService.getStadiumListByAdmin(fa_num, cri);
//			//현재 페이지 정보(검색어, 타입)에 맞는 전체 경기장 수를 가져옴
//			int totalCount = adminService.getTotalStadiumCountByAdmin(cri, fa_num);
//			//페이지네이션 페이지수
//			final int DISPLAY_PAGE_NUM = 3;
//			
//			PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
//			
//			if(stadiumList.size() == 0) {
//		        Message msg = new Message("/admin/facilitylist", "등록된 경기장이 없습니다.");
//				model.addAttribute("msg", msg);
//				return "/message";
//			}
//			model.addAttribute("facility", facility);
//			model.addAttribute("files", files);
//			model.addAttribute("stadiumList", stadiumList);
//			model.addAttribute("pm", pm);
//			return "/facility/tmpdetail";
//		}
	
}
