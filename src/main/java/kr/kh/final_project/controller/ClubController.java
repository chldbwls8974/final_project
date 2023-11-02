package kr.kh.final_project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kh.final_project.service.ClubService;
import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.util.Message;
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
}
	

