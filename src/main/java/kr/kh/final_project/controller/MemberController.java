package kr.kh.final_project.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.AdminService;
import kr.kh.final_project.service.BlockService;
import kr.kh.final_project.service.ClubService;
import kr.kh.final_project.service.MatchService;
import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.service.RegionService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.util.UploadFileUtils;
import kr.kh.final_project.vo.BlockVO;
import kr.kh.final_project.vo.ClubVO;
import kr.kh.final_project.vo.EntryVO;
import kr.kh.final_project.vo.HoldingCouponVO;
import kr.kh.final_project.vo.MarkVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PenaltyVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.PreferredRegionVO;
import kr.kh.final_project.vo.QuarterVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.ReportVO;
import kr.kh.final_project.vo.TimeVO;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	@Autowired
	MatchService matchService;
	@Autowired
	RegionService regionService;
	@Autowired
	ClubService clubService;
	@Autowired
	BlockService blockService;
	@Autowired
	AdminService adminService;
	@Autowired
	RegionDAO regionDao;
	
	String uploadPath = "D:\\uploadprofile\\member";

	@GetMapping("/member/signup")
	public String signup(Model model) {
		List<RegionVO> MainRegion = memberService.getMainRegion();
		List<TimeVO> time = memberService.getAllTime();
		model.addAttribute("MainRegion",MainRegion);
		model.addAttribute("time",time);
		return "/member/signup";
	}
	
	@ResponseBody
	@GetMapping("/member/signup/region")
	public Map<String, Object> region(@RequestParam String rg_main,  Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> SubRegion = memberService.getSubRegionByMainRegion(rg_main);
		map.put("SubRegion", SubRegion);
		return map;
	}
	
	// 추천인 닉네임 입력 시, 입력한 닉네임의 회원이 존재하는지 확인
	@ResponseBody
	@GetMapping("/member/signup/check")
	public Map<String, Object> check(@RequestParam String check,  Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO checked = memberService.isCheck(check);
		map.put("checked",checked);
		return map;
	}
	
	//인증번호 전송
	@ResponseBody
	@GetMapping("/member/signup/checkmail")
	public boolean checkmail(@RequestParam String to,@RequestParam String randomCode, Model model){
		//Map<String, Object> map = new HashMap<String, Object>();
		String title= "인증번호 메일 테스트";
		String contents = 
				"홈페이지를 방문해주셔서 감사합니다." + 	//html 형식으로 작성 ! 
                "<br><br>" + 
			    "인증 번호는 " + randomCode + "입니다." + 
			    "<br>" + 
			    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
		return memberService.sendMail(to, title, contents);
	}
	
	// 아이디 중복 체크
	@ResponseBody
	@PostMapping("/member/check/id")
	public Object idCheck(@RequestParam("id")String id){
		return memberService.checkId(id);
	}
	
	// 이메일 중복 체크
	@ResponseBody
	@PostMapping("/member/check/email")
	public Object emailCheck(@RequestParam("email")String email){
		return memberService.checkEmail(email);
	}
	
	// 닉네임 중복 체크
	@ResponseBody
	@PostMapping("/member/check/nickname")
	public Object nickNameCheck(@RequestParam("nickname")String nickname){
		return memberService.checkNickName(nickname);
	}
	
	
	@PostMapping("/member/signup")
	public String signupPost(MemberVO member, Model model, int[] pr_rg_num,
			int[] favoriteTime, int[] favoriteHoliTime, 
			@RequestParam("recommed_check") String inviteMember){
		//inviteMember = 추천인 닉네임	 
		Message msg = new Message("/member/signup", "회원 가입에 실패했습니다.");
		if(memberService.signup(member, pr_rg_num,favoriteTime,favoriteHoliTime)) {
			msg = new Message("/", "회원 가입에 성공했습니다.");
			//초대한 기존회원, 신규 회원에게 쿠폰 지급하는 메서드 (추천인 입력받았을 때만 실행)
			if(inviteMember != null) {
				if(memberService.signupCoupon(inviteMember, member)) {
				}
			}
		}
		model.addAttribute("msg", msg);
		return "message";
	}
	
	
	@GetMapping(value="/member/signout")
	public String emailMemberSignout(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		model.addAttribute("member", member);
		return "/member/signout";
	}
	@PostMapping(value="/member/signout")
	public String emailMemberSignoutPost(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		member.setMe_session_limit(null);
		boolean res = memberService.emailMemberSignout(member);
		if(res) {
			model.addAttribute("msg", "회원 탈퇴가 완료되었습니다.");
			model.addAttribute("url", "/");
			session.removeAttribute("user");
		}else {
			model.addAttribute("msg", "회원 탈퇴에 실패했습니다.");
			model.addAttribute("url", "/member/signout");
		}
		model.addAttribute("member", member);
		return "/util/message";
	}
	
	
	@GetMapping(value="/member/login")
	public String memberLogin() {
		return "/member/login";
	}
	
	@PostMapping(value="/member/login")
	public String memberLoginPost(MemberVO member, Model model) {
		Message msg = new Message("/member/login", "로그인에 실패했습니다.");
		//DB에서 로그인 정보를 이용하여 가져온 회원정보. 자동로그인 여부가 없음
		MemberVO user = memberService.login(member); 
		if(user != null) {
			msg = new Message("", "로그인에 성공했습니다.");
			//화면에서 선택/미선택한 자동로그인 여부를 user에 저장해서 인터셉터에게 전달 
			user.setAutoLogin(member.isAutoLogin());
		}
		model.addAttribute("user", user);
		model.addAttribute("msg", msg);
		return "message";
	}
	
	@GetMapping("/member/logout")
	public String memberLogout(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO)session.getAttribute("user");
		user.setMe_session_limit(null);
		memberService.updateMemberSession(user);
		Message msg = new Message("/", null);
		if(user != null) {
			session.removeAttribute("user");
			msg.setMsg("로그아웃에 성공했습니다.");
		}
		model.addAttribute("msg", msg);
		return "message";
	}
	
	
	//포인트 내역 페이지
	@GetMapping("/member/pointHistory")
	public String pointHistory(HttpSession session, Model model, Criteria cri) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		cri.setPerPageNum(5);
		int totalCount = memberService.getMemberPointHistoryCount(user, cri);
		final int DISPLAY_PAGE_NUM = 3;
		
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
//		
		List<PointHistoryVO> list = memberService.getMemberPointHistory(user, cri);
		
		System.out.println(totalCount);
		System.out.println(list);
		System.out.println(cri);
		model.addAttribute("pm", pm);
		model.addAttribute("list", list);
		return "/member/pointHistory";
	}
	
	//포인트 환급 페이지
	@GetMapping("/member/refund")
	public String pointRefund(HttpSession session,  Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(memberService.getUserAccount(user) == null) {
			Message msg = new Message("/account/insert", "계좌 등록이 필요한 서비스입니다. \\n환급 계좌 등록 페이지로 이동합니다.");
			model.addAttribute("msg", msg);
			return "message";
		}
		return "/member/refund";
	}
	
	@PostMapping("/member/refund")
	public String pointRefundPost(Model model, HttpSession session, PointHistoryVO pointHistory, MemberVO tmpUser) {
		String msg, url;
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원 테이블에 포인트 수정, 포인트이력 테이블에 데이터 추가
		if(memberService.pointRefundApply(user,tmpUser, pointHistory)) {
			msg = "환급 신청이 성공하였습니다.";
			url = "/member/refund";
		}else {
			msg = "환급 신청이 실패하였습니다.";
			url = "/"; 
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		return "/util/message";
	}
	
	@ResponseBody
	@PostMapping("/member/refund/list")
	public Map<String, Object> refundList(HttpSession session, @RequestBody Criteria cri){
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<PointHistoryVO> refundList = memberService.getUserRefundHistoryList(user, cri);
		//유저 포인트 가져오는 메서드
		int dbMemberPoint = memberService.getMemberPoint(user);
		int totalCount = memberService.getTotalRefundCount(user);
		PageMaker pm = new PageMaker(3, cri, totalCount);
		
		map.put("pm", pm);
		map.put("dbMemberPoint", dbMemberPoint);
		map.put("refundList", refundList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/member/refund/delete")
	public Map<String, Object> refundDelete(@RequestBody PointHistoryVO ph){
		boolean res = memberService.cancelRefundApply(ph);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", res);
		return map;
	}
	//유저포인트 ajax로 보내주기 (실시간 업데이트를 위해서)
	@ResponseBody
	@PostMapping("/member/information")
	public Map<String, Object> memberInformation(@RequestBody MemberVO user){
		Map<String, Object> map = new HashMap<String, Object>();
		//db의 유저정보 가져옴
		user = memberService.getMemberByNum(user);
		map.put("user", user);
		return map;
	}
	
	//마이페이지
	@GetMapping("/member/mypage")
	public String myPage(HttpSession session, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		MemberVO dbMember = memberService.getMemberByNum(user);
		List<ClubVO> list = clubService.getMyClubList(user.getMe_num(),"MEMBER");
		List<ClubVO> memberlist = clubService.getMyClubList(user.getMe_num(),"MEMBER");
		List<ClubVO> rookielist = clubService.getMyClubList(user.getMe_num(),"ROOKIE");
		List<ClubVO> leaderlist = clubService.getMyClubList(user.getMe_num(),"LEADER");
		
		model.addAttribute("user",user);
		model.addAttribute("memberlist",memberlist);
		model.addAttribute("rookielist",rookielist);
		model.addAttribute("leaderlist",leaderlist);
		model.addAttribute("user", dbMember);
		model.addAttribute("list",list);
		return "/member/mypage";
	}

	//마이페이지 - 회원조회
	@GetMapping("/member/search")
	public String searchMembers(Model model) {
		List<MemberVO> memberList = memberService.getMemberList(); //서비스에게 멤버리스트 요청
		model.addAttribute("memberList", memberList);
		return "/member/search";
	}
	
	@ResponseBody
	@PostMapping("/member/searchfilter")
	 public Map<String, Object>searchMembers(@RequestParam String searchType, @RequestParam String keyword, Model model) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 List<MemberVO> memberList = null; //회원목록 리스트 선언
		 boolean res = false; //검색 결과 변수 초기화
		 
		if("id".equals(searchType)) { //아이디로 검색하면 그 값을 memberList에 저장
			memberList = memberService.searchMemberById(keyword);
		}else { //이름으로 검색하면 그 값을 memberList에 저장
			memberList = memberService.searchMemberByName(keyword);
		} //검색결과가 있으면 res를 true로
		if(memberList != null) {
			res = true;
		}
		map.put("memberList",memberList);//map에 저장 후 jsp로 전달
		map.put("res",res);//jsp로 전달
		return map;
	}
	// 차단회원 검색기능
	@ResponseBody
	@PostMapping("/member/searchfilterByBlocked")
	 public Map<String, Object>searchMembersByBlocked(HttpSession session, @RequestParam String searchType, @RequestParam String keyword, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		 Map<String, Object> map = new HashMap<String, Object>();
		 List<MemberVO> dbMemberList; //회원목록 리스트 선언
		 boolean res = false; //검색 결과 변수 초기화
		 
		if("id".equals(searchType)) { //아이디로 검색하면 그 값을 memberList에 저장
			dbMemberList = memberService.searchMemberById(keyword);
		}else { //이름으로 검색하면 그 값을 memberList에 저장
			dbMemberList = memberService.searchMemberByName(keyword);
		} //검색결과가 있으면 res를 true로
		if(dbMemberList != null) {
			res = true;
		}
		//dbMemberList = 검색에 맞는 회원리스트
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		List<BlockVO> blockList = blockService.getBlockList(user.getMe_num());
		for(MemberVO member : dbMemberList) {
			for(BlockVO block : blockList) {
				if(member.getMe_num()==block.getBl_blocked_num()) {
					memberList.add(member);
				}
			}
		}
		
		map.put("memberList", memberList);//map에 저장 후 jsp로 전달
		map.put("res", res);//jsp로 전달
		return map;
	}
	// 즐겨찾기회원 검색기능
		@ResponseBody
		@PostMapping("/member/searchfilterByFriend")
		 public Map<String, Object>searchfilterByFriend(HttpSession session, @RequestParam String searchType, @RequestParam String keyword, Model model) {
			MemberVO user = (MemberVO) session.getAttribute("user");
			 Map<String, Object> map = new HashMap<String, Object>();
			 List<MemberVO> dbMemberList; //회원목록 리스트 선언
			 boolean res = false; //검색 결과 변수 초기화
			 
			if("id".equals(searchType)) { //아이디로 검색하면 그 값을 memberList에 저장
				dbMemberList = memberService.searchMemberById(keyword);
			}else { //이름으로 검색하면 그 값을 memberList에 저장
				dbMemberList = memberService.searchMemberByName(keyword);
			} //검색결과가 있으면 res를 true로
			if(dbMemberList != null) {
				res = true;
			}
			//dbMemberList = 검색에 맞는 회원리스트
			List<MemberVO> memberList = new ArrayList<MemberVO>();
			List<MarkVO> markList = memberService.getMyMarkList(user);
			for(MemberVO member : dbMemberList) {
				for(MarkVO mark : markList) {
					if(member.getMe_num()==mark.getMa_marked_num()) {
						memberList.add(member);
					}
				}
			}
			
			map.put("memberList", memberList);//map에 저장 후 jsp로 전달
			map.put("res", res);//jsp로 전달
			return map;
		}
	
	@GetMapping("/member/myedit")
	public String myProfile(Model model,HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<RegionVO> MainRegion = memberService.getMainRegion();
		
		//회원 가져오기
		MemberVO dbMember = memberService.getMemberByNum(user);
		//회원의 거주지역 가져오기
		MemberVO memberRegion = memberService.getMemberRegion(dbMember);
		List<RegionVO> subRg = regionDao.selectSubRegion(memberRegion.getRg_main());
				
		model.addAttribute("user",dbMember);
		model.addAttribute("MainRegion",MainRegion);
		model.addAttribute("subRg",subRg);
		model.addAttribute("memberRegion",memberRegion);
		return "/member/myedit";
	}
	
	
	@PostMapping("/member/myedit")
	public String profileEdit(MemberVO member, MultipartFile img, HttpSession session, Model model, String test) {
		Message msg = new Message("/", null);
		try {
			String fi_ori_name = img.getOriginalFilename();
			String fi_name;
			if(fi_ori_name != null && !fi_ori_name.isEmpty()) {
				fi_name = UploadFileUtils.updateImg(uploadPath, fi_ori_name, img.getBytes());
				
			}else{
				fi_name = test;
			}
			
			boolean res = memberService.updateProfile(member, fi_name); //새로 입력한 정보 업데이트
			if(res) { //업데이트된 사용자 정보 세션에 저장
				session.setAttribute("user", member); 
				msg = new Message("/member/mypage", "수정에 성공했습니다.");
				model.addAttribute("msg",msg);
			}else { //업데이트 실패시
				msg = new Message("/", "수정에 실패했습니다");
				model.addAttribute("msg",msg);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return "message";
	}
	
	
	// 닉네임 입력 시, 입력한 닉네임의 회원이 존재하는지 확인
	@ResponseBody
	@GetMapping("/member/myedit/check")
	public Map<String, Object> profilecheck(@RequestParam String check,  Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO checked = memberService.isCheck2(check);
		map.put("checked",checked);
		return map;
	}
	
	//회원 보유 쿠폰 조회
	@GetMapping("/member/myCoupon")
	public String myCoupon(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		model.addAttribute("user",user );
		return "/member/myCoupon";
	}
	//회원 보유 쿠폰 리스트
	@ResponseBody
	@PostMapping("/member/myCoupon")
	public Map<String, Object> myCouponList(@RequestBody Criteria cri, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		List<HoldingCouponVO> hcList = memberService.getMemberCouponList(user, cri);
		int totalCount = memberService.getMemberCouponListCount(user);
		PageMaker pm = new PageMaker(3, cri, totalCount);
		
		map.put("pm", pm);
		map.put("hcList", hcList);
		return map;
	}
	//마이페이지-소속 클럽 페이지 조회
	@GetMapping("/member/clublist")
	public String myClub() {
		return "/member/clublist";
	}
	
	//마이페이지-신청 경기 페이지 조회
	@GetMapping("/member/mymatch")
	public String mymatch(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//서비스에게 매치리스트 요청
		List<MatchVO> matchList = matchService.getMyMatchListByMeNum(user.getMe_num()); 
		model.addAttribute("matchList", matchList);
		return "/member/mymatch";
	}
	
	//마이페이지- 내 프로필 상세조회
	@GetMapping("/member/myprofile")
	public String myprofile(Model model, MemberVO member, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원 가져오기
		MemberVO dbMember = memberService.getMemberByNum(member);
		//회원의 거주지역 가져오기
		MemberVO memberRegion = memberService.getMemberRegion(dbMember);
		
		
		//회원의 선호지역, 선호시간대 가져오기
		List<PreferredRegionVO> memberPRegion = memberService.getMemberPRegion(dbMember);
		List<RegionVO> subRg = regionDao.selectUserRegion();
//		List<Integer> subRg = new ArrayList<Integer>();
//		for(PreferredRegionVO i :memberPRegion ) {
//			subRg.add(regionDao.selectSubRegion(i.getRg_main()));
//		}
		
		List<Integer> holiTime = memberService.getMemberPTimeHoliday(dbMember);
		List<Integer> weekTime = memberService.getMemberPTimeWeekday(dbMember);
		// 선호 지역, 시간 수정 시 필요
		List<RegionVO> MainRegion = memberService.getMainRegion();
		List<TimeVO> time = memberService.getAllTime();
		
		
		model.addAttribute("MainRegion",MainRegion);
		model.addAttribute("time",time);
		model.addAttribute("member",dbMember );
		model.addAttribute("memberRegion", memberRegion );
		model.addAttribute("memberPRegion", memberPRegion );
		model.addAttribute("subRg", subRg );
		model.addAttribute("holiTime", holiTime );
		model.addAttribute("weekTime", weekTime );
		model.addAttribute("user", user );
		return "/member/myprofile";
	}
	//차단목록, 즐겨찾기 목록 가져오는 메서드
	@ResponseBody
	@PostMapping("/member/myBlockAndMarkList")
	public Map<String, Object> myBlockAndMarkList(@RequestBody MemberVO user){
		Map<String, Object> map = new HashMap<String, Object>();
		//유저의 차단목록, 즐겨찾기목록 가져옴
		List<BlockVO> blockList = memberService.getMyBlockList(user);
		List<MarkVO> markList = memberService.getMyMarkList(user);
		map.put("blockList", blockList);
		map.put("markList", markList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/member/markList/process")
	public Map<String, Object> markListAddAndDelete(@RequestBody MarkVO mark){
		Map<String, Object> map = new HashMap<String, Object>();
		//즐겨찾기 등록또는 삭제
		memberService.markListAddAndDelete(mark);
		
		return map;
	}
	@ResponseBody
	@PostMapping("/member/blockList/process")
	public Map<String, Object> blockListAddAndDelete(@RequestBody BlockVO block){
		Map<String, Object> map = new HashMap<String, Object>();
		//차단 등록 또는 삭제
		memberService.blockListAddAndDelete(block);
		
		return map;
	}
		
	//마이페이지-즐찾 및 차단조회 페이지
	@GetMapping("/member/friendlist")
	public String friendlist(Model model, Criteria cri, HttpSession session) {
		// 로그인한 사람의 즐겨찾기 목록을 가져오기 위해 지금 로그인한 사람을 user에 저장
		MemberVO user = (MemberVO)session.getAttribute("user");
		//즐찾된 사람 리스트 조회하기.
		List<MarkVO> markList = memberService.getMyMarkList(user);
		//즐겨찾기 리스트 들고왔음
		//즐겨찾기 리스트에 있는 사람들이랑 똑같은 멤버리스트 들고옴
		List<MemberVO> memberListByMark = memberService.getMemberMarkList(markList);
		model.addAttribute("memberListByMark", memberListByMark);
		
		return "/member/friendlist";
	}
	@GetMapping("/member/blocklist")
	public String blocklist(Model model, Criteria cri, HttpSession session) {
		// 로그인한 사람의 차단 목록을 가져오기 위해 지금 로그인한 사람을 user에 저장
		MemberVO user = (MemberVO)session.getAttribute("user");
		//차단된 사람 리스트 조회하기.
		List<BlockVO> blockList = blockService.getBlockList(user.getMe_num());
		//블랙리스트 들고왔음
		//블랙리스트에 있는 사람들이랑 똑같은 멤버리스트 들고옴
		List<MemberVO> memberListByBlock = memberService.getBlockMemberList(blockList);
		model.addAttribute("memberListByBlock", memberListByBlock);
		
		return "/member/blocklist";
	}
	
	@GetMapping("/payment/main")
	public String payment(Model model) {
		return "/payment/main";
	}
	
	@PostMapping("/member/update/region")
	public String updateRegion(Model model,int me_num, int[] pr_rg_num) {
		Message msg = memberService.updatePreferRegion(me_num, pr_rg_num);
		model.addAttribute("msg", msg);
		return "message";
	}
	@PostMapping("/member/update/time")
	public String updateTime(Model model,int me_num, int[] favoriteTime, int[] favoriteHoliTime) {
		Message msg = memberService.updatePreferTime(me_num, favoriteTime,favoriteHoliTime);
		model.addAttribute("msg", msg);
		return "message";
	}
	
	@ResponseBody
	@PostMapping("/member/update/email")
	public Map<String, Object> updateEmail(@RequestParam int me_num, @RequestParam String email){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = false;
		if(memberService.updateEmail(me_num, email)) {
			res = true;
		}
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@GetMapping("/member/update/region2")
	public Map<String, Object> region1(@RequestParam String rg_main, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		List<RegionVO> SubRegion = memberService.getSubRegionByMainRegion(rg_main);
		map.put("SubRegion", SubRegion);
		return map;
	}
	
	@GetMapping("/util/ban")
	public String ban(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO member = memberService.getMemberByNum(user);
		//정지일
		String str = "커뮤니티";
		PenaltyVO boardPenalty = memberService.getMemberPenalty(member, str);
		str = "경기";
		PenaltyVO matchPenalty = memberService.getMemberPenalty(member, str);
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
		
		if(boardPenalty.getPn_end() != null) {
			String BoardBanEndDate = simpleDateFormat.format(boardPenalty.getPn_end());
			model.addAttribute("BoardBanEndDate", BoardBanEndDate);
		}
		if(matchPenalty.getPn_end() != null) {
			String MatchBanEndDate = simpleDateFormat.format(matchPenalty.getPn_end());
			model.addAttribute("MatchBanEndDate", MatchBanEndDate);
		}
		model.addAttribute("member", member);
		return "/util/ban";
	}
	
	//유저가 게시글 신고 했을 때
		@PostMapping("/member/boardReport/insert")
		public String boardReportInsert(Model model, ReportVO report) {
			//신고추가
			//중복신고 못하게 해야함 (같은 사람이 같은 게시글에 신고 x bo_num, me_num)
			Message msg = adminService.boardReportInsert(report);
			model.addAttribute("msg", msg);
			return "message";
		}
		//유저가 매치 신고 했을 때
		@ResponseBody
		@PostMapping("/member/matchReport/insert")
		public Map<String, Object> matchReportInsert(Model model, @RequestBody ReportVO report, HttpSession session) {
			Map<String, Object> map = new HashMap<String, Object>();
			MemberVO user = (MemberVO)session.getAttribute("user");
			report.setRp_me_num(user.getMe_num());

			String msg = adminService.matchReportInsert(report);
			
			map.put("msg", msg);
			return map;
		}
		
		@GetMapping("/member/record")
		public String memberMyRecord(Model model, HttpSession session) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			List<MatchVO> matchList = matchService.selectMyRecored(user.getMe_num());
			int win = 0;
			int draw = 0;
			int lose = 0;
			for(MatchVO match : matchList) {
				if(match.getWin() != 0) {
					win += match.getWin();
				}if(match.getDraw() != 0) {
					draw += match.getDraw();
				}if(match.getLose() != 0) {
					lose += match.getLose();
				}
			}
			model.addAttribute("win", win);
			model.addAttribute("draw", draw);
			model.addAttribute("lose", lose);
			model.addAttribute("matchList", matchList);
			return "/member/record";
		}

		@ResponseBody
		@PostMapping("/match/quarter/list")
		public Map<String, Object> selectQuarterList(@RequestParam("mt_num")int mt_num, @RequestParam("te_num")int te_num){
			Map<String, Object> map = new HashMap<String, Object>();
			List<QuarterVO> dbQuarterList = matchService.selectQuarterListByMtNum(mt_num);
			List<QuarterVO> quarterList = new ArrayList<QuarterVO>();
			
			for(QuarterVO quarter : dbQuarterList) {
				if(quarter.getQu_te_num1() == te_num) {
					quarterList.add(quarter);
				}else if(quarter.getQu_te_num2() == te_num) {
					QuarterVO tmp = new QuarterVO();
					tmp.setQu_te_num1(quarter.getQu_te_num1());
					tmp.setQu_goal1(quarter.getQu_goal1());
					tmp.setTeam1(quarter.getTeam1());
					quarter.setQu_te_num1(quarter.getQu_te_num2());
					quarter.setQu_goal1(quarter.getQu_goal2());
					quarter.setTeam1(quarter.getTeam2());
					quarter.setQu_te_num2(tmp.getQu_te_num1());
					quarter.setQu_goal2(tmp.getQu_goal1());
					quarter.setTeam2(tmp.getTeam1());
					quarterList.add(quarter);
				}
			}
			map.put("quarterList", quarterList);
			return map;
		}
		@ResponseBody
		@PostMapping("/print/report/match")
		public Map<String, Object> printReportMatch(@RequestParam("mt_num")int mt_num, HttpSession session){
			Map<String, Object> map = new HashMap<String, Object>();
			MemberVO user = (MemberVO)session.getAttribute("user");
			MemberVO manager = matchService.selectManagerByMtNum(mt_num);
			MemberVO business = matchService.selecBusinessByMtNum(mt_num);
			List<EntryVO> entryList = matchService.selectEntryByMtNum(mt_num);
			
			map.put("me_num", user.getMe_num());
			map.put("manager", manager);
			map.put("business", business);
			map.put("entryList", entryList);
			return map;
		}
}
