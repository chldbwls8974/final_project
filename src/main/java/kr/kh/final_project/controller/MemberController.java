package kr.kh.final_project.controller;

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

import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.service.RegionService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TimeVO;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	@Autowired
	RegionService regionService;
	
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
			 int[] favoriteTime
			,  int[] favoriteHoliTime
			) 
		{
		
		Message msg = new Message("/member/signup", "회원 가입에 실패했습니다.");
		
		if(memberService.signup(member, pr_rg_num,favoriteTime,favoriteHoliTime)) {
			msg = new Message("/", "회원 가입에 성공했습니다.");
		}
		model.addAttribute("msg", msg);
		return "message";
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
	
	
	
	//포인트 환급 페이지
	@GetMapping("/member/refund")
	public String pointRefund(HttpSession session) {
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
	public Map<String, Object> refundList(@RequestBody MemberVO user){
		Map<String, Object> map = new HashMap<String, Object>();
		List<PointHistoryVO> refundList = memberService.getUserRefundHistoryList(user);
		//유저 포인트 가져오는 메서드
		int dbMemberPoint = memberService.getMemberPoint(user);
		
		
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

	//마이페이지
	@GetMapping("/member/mypage")
	public String myPage(HttpSession session, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		model.addAttribute("user", user);
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
		 List<MemberVO> memberList; //회원목록 리스트 선언
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
	
	@GetMapping("/member/myedit")
	public String myProfile() {
		return "/member/myedit";
	}
	
	
	@PostMapping("/member/myedit")
	public String profileEdit(MemberVO member, MultipartFile file, HttpSession session,Model model) {
		System.out.println(member);
		MemberVO user = (MemberVO)session.getAttribute("user"); //세션에 저장된 현재 user 정보 가져옴
		System.out.println(user);
		boolean res = memberService.updateProfile(member, user, file); //새로 입력한 정보 업데이트
		if(res) { //업데이트된 사용자 정보 세션에 저장
			session.setAttribute("user", member); 
			model.addAttribute("msg", "수정을 완료했습니다.");
			model.addAttribute("url","/member/mypage");
		}else { //업데이트 실패시
			model.addAttribute("msg", "수정에 실패했습니다.");
			model.addAttribute("url","/member/myedit");
		}
		return "/member/mypage";
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
	
}
