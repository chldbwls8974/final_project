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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.final_project.service.ClubService;
import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.ClubMemberVO;
import kr.kh.final_project.vo.ClubVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;

@Controller
@RequestMapping("/club")
public class ClubController {
	
	@Autowired
	ClubService clubService;
	@Autowired
	MemberService memberService;

	
	@GetMapping("/make")
	public String makeClub(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<RegionVO> MainRegion = memberService.getMainRegion();
		model.addAttribute("user",user);
		model.addAttribute("MainRegion",MainRegion);
		return "/club/make";
	}
	
	@PostMapping("/make")
	public String makeClubPost(Model model, ClubVO club, int[] favoriteTime, int[] favoriteHoliTime, int[] age,int me_num) {
		Message msg = new Message("/club/make", "클럽 생성에 실패하였습니다.");
		if(clubService.insertClub(me_num,club, age,favoriteTime,favoriteHoliTime)) {
			msg = new Message("/", "클럽 생성에 성공했습니다.");
		}
		model.addAttribute("msg", msg);
		return "message";
	}
	
	@ResponseBody
	@PostMapping("/make/check")
	public Object clubNameCheck(@RequestParam("name")String name){
		return clubService.checkClubName(name);
	}
	
	@GetMapping("/list")
	public String listClub(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<ClubVO> list = clubService.getClubList();
		model.addAttribute("user",user);
		model.addAttribute("list",list);
		return "/club/list";
	}
	@GetMapping("/mylist")
	public String myClubList(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<ClubVO> memberlist = clubService.getMyClubList(user.getMe_num(),"MEMBER");
		model.addAttribute("user",user);
		model.addAttribute("memberlist",memberlist);
		return "/club/mylist";
	}
	@GetMapping("/rookielist")
	public String rookieClubList(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<ClubVO> rookielist = clubService.getMyClubList(user.getMe_num(),"ROOKIE");
		model.addAttribute("user",user);
		model.addAttribute("rookielist",rookielist);
		return "/club/rookielist";
	}
	
	@GetMapping("/detail")
	public String detailClub(Model model, HttpSession session, Integer cl_num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ClubVO club = clubService.getClub(cl_num);
		ClubMemberVO authority = clubService.getMyAuthorityByClub(cl_num, user.getMe_num());
		model.addAttribute("user",user);
		model.addAttribute("club",club);
		model.addAttribute("authority",authority);
		return "/club/detail";
	}
	@GetMapping("/join")
	public String joinClub(Model model, HttpSession session, Integer cl_num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ClubVO club = clubService.getClub(cl_num);
		model.addAttribute("user",user);
		model.addAttribute("club",club);
		return "/club/join";
	}
	@PostMapping("/join")
	public String joinClubPost(Model model, HttpSession session, ClubMemberVO clubMember) {
		Message msg = new Message("/club/join", "클럽 신청에 실패하였습니다.");
		if(clubService.joinClub(clubMember)) {
			msg = new Message("/", "클럽 신청에 성공했습니다.");
		}
		model.addAttribute("msg", msg);
		return "message";
	}
	
	@GetMapping("/manage")
	public String manageClub(Model model, HttpSession session, Integer cl_num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ClubVO club = clubService.getClub(cl_num);
		List<ClubMemberVO> list = clubService.getClubMemberList(cl_num);
		model.addAttribute("club",club);
		model.addAttribute("list",list);
		return "/club/manage";
	}
	
	@GetMapping("/update")
	public String updateClub(Model model, HttpSession session, Integer cl_num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ClubVO club = clubService.getClub(cl_num);
		model.addAttribute("user",user);
		model.addAttribute("club",club);
		return "/club/update";
	}
	
	@PostMapping("/update")
	public String updateClubPost(Model model, ClubVO club, int[] favoriteTime, int[] favoriteHoliTime, int[] age,int me_num) {
		Message msg = new Message("/club/upate", "클럽 수정에 실패하였습니다.");
		if(clubService.updateClub(me_num,club, age,favoriteTime,favoriteHoliTime)) {
			msg = new Message("/", "클럽 수정에 성공했습니다.");
		}
		model.addAttribute("msg", msg);
		return "message";
	}

	@ResponseBody
	@PostMapping("/mbmanage")
	public Map<String, Object> region(@RequestParam String type, @RequestParam String authority, @RequestParam int cl_num, @RequestParam int me_num,  Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		// 여기해야함!!!! 
		return map;
	}
}
	

