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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.AdminService;
import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;

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
		
		//현재 페이지 정보를 주면서 memberService한테 회원 리스트를 가져오라고 하고 list에 담는다.
		List<MemberVO> list = adminService.getMemberList(cri);
		
		//페이지네이션
		//현재 페이지 정보(검색어, 타입)에 맞는 전체 게시글 수(TotalCount)를 가져온다.
		int totalCount = adminService.getTotalCount(cri);
		//페이지네이션 페이지수
		final int DISPLAY_PAGE_NUM = 3;
		// DISPLAY_PAGE_NUM,cri,totalCount의 정보를 가지고 pageMaker를 만들어 pm으로 넣음
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		
		
		
		// 가져온 회원정보를 리스트에 담에 화면에 전송한다.
		// "list" : 내가 화면에서 사용할 이름 / list : 화면에서 보여지는 값
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pm", pm);
		return "/admin/member";
	}
	
	//매니저 신청 조회 하기
		@GetMapping("/admin/manager")
		public String adminMananger(Model model) {
			List<ManagerVO> list = adminService.getManagerList();
			
			//화면에 전송
			model.addAttribute("list", list);
			return "/admin/manager";
		} 
	
	// 매니저 신청 수락버튼 (회원정보 수정)
		@ResponseBody
		@PostMapping("/admin/manager")
		public Map<String, Object>updateManager(@RequestBody ManagerVO manager){
			// 결과 데이터를 넣기 위한 map을 만듬
			Map<String, Object> map = new HashMap<String, Object>();
			//ManagerVO user = (ManagerVO)session.getAttribute("user");
			boolean res = adminService.updateManager(manager);
			map.put("res", res);
			return map;
		}
		
}
