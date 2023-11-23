package kr.kh.final_project.controller;

import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.dao.PreferredAgeDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.service.ClubService;
import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.util.UploadFileUtils;
import kr.kh.final_project.vo.ClubMemberVO;
import kr.kh.final_project.vo.ClubVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PreferredAgeVO;
import kr.kh.final_project.vo.RegionVO;

@Controller
@RequestMapping("/club")
public class ClubController {
	
	@Autowired
	ClubService clubService;
	@Autowired
	MemberService memberService;
	@Autowired
	RegionDAO regionDao;
	@Autowired
	PreferredAgeDAO preferredAgeDao;
	
	String uploadPath = "D:\\uploadprofile\\club";

	
	@GetMapping("/make")
	public String makeClub(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<RegionVO> MainRegion = memberService.getMainRegion();
		model.addAttribute("user",user);
		model.addAttribute("MainRegion",MainRegion);
		return "/club/make";
	}
	
	@PostMapping("/make")
	public String makeClubPost(Model model, MultipartFile img, ClubVO club, int[] favoriteTime, int[] favoriteHoliTime, int[] age,int me_num) {
		Message msg = new Message("/club/make", "클럽 생성에 실패하였습니다.");
		
		try {
			String fi_ori_name = img.getOriginalFilename();
			String fi_name;
			if(fi_ori_name != null && !fi_ori_name.isEmpty()) {
				fi_name = UploadFileUtils.updateImg(uploadPath, fi_ori_name, img.getBytes());
				
			}else{
				fi_name = "/default.jpg";
			}
			if (clubService.insertClub(me_num, fi_name, club, age, favoriteTime, favoriteHoliTime)) {
				msg = new Message("/club/list", "클럽 생성에 성공했습니다.");
			}
			model.addAttribute("msg", msg);

		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "message";
	}
	
	@ResponseBody
	@PostMapping("/make/check")
	public Object clubNameCheck(@RequestParam("name")String name){
		return clubService.checkClubName(name);
	}
	
	@GetMapping("/list")
	public String listClub(Model model, HttpSession session) {
		
		List<RegionVO> regionList = memberService.getMainRegion();
		
		List<ClubVO> list = clubService.getClubList();
		model.addAttribute("list",list);
		model.addAttribute("regionList",regionList);
		return "/club/list";
	}
	
	@ResponseBody
	@PostMapping("/search")
	 public Map<String, Object>clubSearch(@RequestParam String searchType, @RequestParam String keyword, Model model) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 
		 List<ClubVO> list = clubService.getClubListBySearch(searchType,keyword);
		 
		map.put("list", list);
		return map;
	}
	
	@GetMapping("/mylist")
	public String myClubList(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<ClubVO> memberlist = clubService.getMyClubList(user.getMe_num(),"MEMBER");
		List<ClubVO> rookielist = clubService.getMyClubList(user.getMe_num(),"ROOKIE");
		List<ClubVO> leaderlist = clubService.getMyClubList(user.getMe_num(),"LEADER");
		
		model.addAttribute("user",user);
		model.addAttribute("memberlist",memberlist);
		model.addAttribute("rookielist",rookielist);
		model.addAttribute("leaderlist",leaderlist);
		return "/club/mylist";
	}
	
	@GetMapping("/detail")
	public String detailClub(Model model, HttpSession session, Integer cl_num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ClubVO club = clubService.getClub(cl_num);
		ClubMemberVO authority = clubService.getMyAuthorityByClub(cl_num, user.getMe_num());
		List<ClubMemberVO> clubmemberlist = clubService.getClubMemberList(cl_num);
		List<Integer> age = preferredAgeDao.selectPreAgeListByClNum(cl_num);
		model.addAttribute("user",user);
		model.addAttribute("club",club);
		model.addAttribute("clubmemberlist",clubmemberlist);
		model.addAttribute("age",age);
		model.addAttribute("authority",authority);
		return "/club/detail";
	}
	@PostMapping("/join")
	public String joinClubPost(Model model, HttpSession session, ClubMemberVO clubMember) {
		Message msg = new Message("/club/detail?cl_num="+clubMember.getCm_cl_num(), "클럽 신청에 실패하였습니다.");
		if(clubService.joinClub(clubMember)) {
			msg = new Message("/club/detail?cl_num="+clubMember.getCm_cl_num(), "클럽 신청에 성공했습니다.");
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
		RegionVO region = regionDao.selectRegionByRgNum(club.getCl_rg_num());
		List<RegionVO> MainRegion = memberService.getMainRegion();
		List<RegionVO> subRg = regionDao.selectSubRegion(region.getRg_main());
		List<Integer> weekTime = clubService.getClubTimeList(0,cl_num);
		List<Integer> holiTime = clubService.getClubTimeList(1,cl_num);
		List<Integer> ageList = clubService.getClubAgeList(cl_num);
		model.addAttribute("MainRegion",MainRegion);
		model.addAttribute("user",user);
		model.addAttribute("club",club);
		model.addAttribute("subRg",subRg);
		model.addAttribute("region",region);
		model.addAttribute("weekTime",weekTime);
		model.addAttribute("holiTime",holiTime);
		model.addAttribute("ageList",ageList);
		return "/club/update";
	}
	
	@PostMapping("/update")
	public String updateClubPost(Model model, MultipartFile img, ClubVO club, int[] favoriteTime, int[] favoriteHoliTime, int[] age,int me_num, String test) {
		Message msg = new Message("/club/update", "클럽 수정에 실패하였습니다.");
		

		try {
			String fi_ori_name = img.getOriginalFilename();
			String fi_name;
			if(fi_ori_name != null && !fi_ori_name.isEmpty()) {
				fi_name = UploadFileUtils.updateImg(uploadPath, fi_ori_name, img.getBytes());
			}else{
				fi_name = test;
			}
			if(clubService.updateClub(me_num,club, fi_name,  age,favoriteTime,favoriteHoliTime)) {
				msg = new Message("/club/list", "클럽 수정에 성공했습니다.");
			}
			model.addAttribute("msg", msg);

		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "message";
	}

	@ResponseBody
	@PostMapping("/mbmanage")
	public Map<String, Object> region(HttpSession session, @RequestParam String type, @RequestParam int cl_num, @RequestParam int me_num,  Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		clubService.memberManage(type, cl_num, me_num, user);
		return map;
	}
}
	

