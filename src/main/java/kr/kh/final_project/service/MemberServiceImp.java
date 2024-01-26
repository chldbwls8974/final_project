package kr.kh.final_project.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.AccountDAO;
import kr.kh.final_project.dao.BlockDAO;
import kr.kh.final_project.dao.HoldingCouponDAO;
import kr.kh.final_project.dao.MarkDAO;
import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.dao.PenaltyDAO;
import kr.kh.final_project.dao.PointHistoryDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.PreferredTimeDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.dao.TimeDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.AccountVO;
import kr.kh.final_project.vo.BlockVO;
import kr.kh.final_project.vo.HoldingCouponVO;
import kr.kh.final_project.vo.MarkVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PenaltyVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.PreferredRegionVO;
import kr.kh.final_project.vo.PreferredTimeVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TimeVO;

@Service
public class MemberServiceImp implements MemberService{

	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	RegionDAO regionDao;

	@Autowired
	PreferredRegionDAO prRegionDao;
	
	@Autowired
	PreferredTimeDAO prTimeDao;
	
	@Autowired
	TimeDAO timeDao;
	
	@Autowired
	PointHistoryDAO pointHistoryDao;
	
	@Autowired
	HoldingCouponDAO holdingCouponDao;
	
	@Autowired
	BlockDAO blockDao;
	
	@Autowired
	MarkDAO markDao;
	
	@Autowired
	AccountDAO accountDao;
	
	@Autowired
	PenaltyDAO penaltyDao;
	
	String uploadPath = "D:\\uploadfiles";
	
	String uploadProfile = "D:\\uploadProfile";
	
	@Override
	public List<MemberVO> searchMemberById(String keyword) {
		return memberDao.searchMemberById(keyword);
	}
	
	// 회원가입시 선호 시간을 선택하기 위해 모든 시간을 불러오는 메서드
	@Override
	public List<TimeVO> getAllTime() {
		return timeDao.selectTimeList();
	}

	
	// 아이디 중복체크
	@Override
	public Object checkId(String id) {
		return memberDao.selectMember(id) == null;
	}
	
	// 이메일 중복체크
	@Override
	public Object checkEmail(String email) {
		return memberDao.selectMemberByEmail(email) == null;
	}
	
	// 닉네임 중복체크
	@Override
	public Object checkNickName(String nickname) {
		return memberDao.selectMemberByNickName(nickname) == null;
	}
	
	// 추천인체크
	@Override
	public MemberVO isCheck(String check) {
		MemberVO dbMember = memberDao.selectMemberByNickName(check);
		return dbMember;
	}
	 
	
	// 회원정보 출력 & 검색 기능
	/*
	 * @Override 
	 * public List<MemberVO> getMemberList(Criteria cri) { 
	 * if (cri == null) { 
	 * cri = new Criteria(); } 
	 * return memberDao.selectMemberList(cri); }
	 * 
	 */
	
	@Override
	public boolean signup(MemberVO member, int[] pr_rg_num, int[] favoriteTime, int[] favoriteHoliTime) {
		if(member == null) {
			return false;
		}
		//아이디 중복 확인
		MemberVO dbMember = memberDao.selectMember(member.getMe_id());
		//가입하려는 아이디가 이미 가입된 경우
		if(dbMember != null) {
			return false;
		}
		
		// 아이디가 숫자로 시작하고 k로 끝나지 않으면 이메일 인증이므로 정규화 검사 및 비밀번호 암호화
		if(!member.getMe_id().matches("^\\d+.*k$")) {
			//아이디, 비번 null 체크 + 유효성 검사
			//아이디는 영문으로 시작하고, 6~10자
			String idRegex = "^[a-zA-Z][a-zA-Z0-9]{5,9}$";
			//비번은 영문,숫자,!@#$%로 이루어지고 10~20자 
			String pwRegex = "^[a-zA-Z0-9!@#$%]{10,20}$";
			
			//아이디가 유효성에 맞지 않으면
			if(!Pattern.matches(idRegex, member.getMe_id())) {
				return false;
			}
			//비번이 유효성에 맞지 않으면
			if(!Pattern.matches(pwRegex, member.getMe_pw())) {
				return false;
			}
			
			//비번 암호화 
			String encPw = passwordEncoder.encode(member.getMe_pw());
			member.setMe_pw(encPw);
		}else {
			//카카오는 성별을 female, male로 받아오기 때문에 처리해줘야함.
			if(member.getMe_gender().equals("female")) {
				member.setMe_gender("F");
			}else {
				member.setMe_gender("M");
			}
		}
		// 회원 정보 입력
		memberDao.insertMember(member);
		
		// 입력한 회원정보의 num값 가져오기
		int pr_me_num = memberDao.selectMember(member.getMe_id()).getMe_num();
		// 선호 시간 (평일)
		if(favoriteTime !=null) {
			insertPreferredTime(0,pr_me_num,favoriteTime);
		}else {
			int[] list = {0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};
			insertPreferredTime(0,pr_me_num,list);
		}
		
		// 선호 시간 (주말)
		if(favoriteHoliTime != null) {
			insertPreferredTime(1,pr_me_num,favoriteHoliTime);
		}else {
			int[] list = {0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};
			insertPreferredTime(1,pr_me_num,list);
		}
		
		// 선호 지역
		for(int i : pr_rg_num) {
			if(i!=0) {
				insertPreferredRegion(pr_me_num, pr_rg_num);
			}else {
				prRegionDao.insertPreferredRegion(pr_me_num,member.getMe_rg_num());
			}
		}
		
		return true;
	}

	// 선호 지역을 넣는 메서드
	private void insertPreferredRegion(int pr_me_num, int[] pr_rg_num) {
		for(int i : pr_rg_num) {
			if(i!=0) {
				prRegionDao.insertPreferredRegion(pr_me_num,i);
			}
		}
	}

	
	// 선호시간을 넣는 메서드
	private void insertPreferredTime(int div, int pr_me_num, int[] Time) {
		for(int i : Time) {
			// 평일이면
						if(div == 0) {
							// 선호시간은 2시간 간격이기 때문에 for문이 2개 필요함
							//월(0) ~ 금(4)까지 첫번째 시간을 넣기 위한 반복문 
							for(int day = 0 ; day < 5; day++) {
								int pt_num = (i+1) +(24*day); // 요일별 시간테이블의 숫자
								prTimeDao.insertPreferredTime(pt_num, pr_me_num);
							}
							//월(0) ~ 금(4)까지 두번째 시간을 넣기 위한 반복문 
							for(int day = 0 ; day < 5; day++) {
								int pt_num = (i+2) +(24*day); // 요일별 시간테이블의 숫자
								prTimeDao.insertPreferredTime(pt_num, pr_me_num);
							}
						}
						
						// 주말이면
						else if(div == 1) {
							// 선호시간은 2시간 간격이기 때문에 for문이 2개 필요함
							//토(5), 일(6)첫번째 시간을 넣기 위한 반복문 
							for(int day = 5 ; day < 7; day++) {
								int pt_num = (i+1) +(24*day); // 요일별 시간테이블의 숫자
								prTimeDao.insertPreferredTime(pt_num, pr_me_num);
							}
							//토(5), 일(6) 두번째 시간을 넣기 위한 반복문 
							for(int day = 5 ; day < 7; day++) {
								int pt_num = (i+2) +(24*day); // 요일별 시간테이블의 숫자
								prTimeDao.insertPreferredTime(pt_num, pr_me_num);
							}
						}
			
		}
	}
	

	@Override
	public MemberVO getMember(String me_id) {
		if(me_id == null) {
			return null;
		}
		MemberVO dbMember = memberDao.selectMember(me_id);
		return dbMember;
	}

	@Override
	public List<MemberVO> searchMemberByName(String keyword) {
		return memberDao.searchMemberByName(keyword);
	}
		
	public List<RegionVO> getMainRegion() {
		return regionDao.selectMainRegion();
	}


	@Override
	public List<RegionVO> getSubRegionByMainRegion(String rg_main) {
		return regionDao.selectSubRegion(rg_main);
	}

	


	@Override
	public MemberVO login(MemberVO member) {
		// 이메일 인증 로그인이면
		if(!member.getMe_id().matches("k$")) {
			if(member == null || member.getMe_id() == null || member.getMe_pw() == null) {
				return null;
			}
			MemberVO user = memberDao.selectMember(member.getMe_id());
			if(user == null) {
				return null;
			}
//					if(passwordEncoder.matches(member.getMe_pw(), user.getMe_pw())) {
//						return user;
//					}
			
			
					//원활한 테스트를 위해서 남겨두는 코드. 나중에 이거 삭제하고 위의 주석을 해제하면 됨
					if(member.getMe_pw().equals(user.getMe_pw())) {
						return user;
					}
			
			
		}
		// 카카오 인증 로그인이면, pw가 없으므로
		else if(member.getMe_id().matches("k$")){
			if(member == null || member.getMe_id() == null) {
				return null;
			}
			MemberVO user = memberDao.selectMember(member.getMe_id());
			if(user==null) {
				return null;
			}
			return user;
		}
		return null;
	}
	


	@Override
	public MemberVO getMemberBySession(String me_session_id) {
		return memberDao.selectMemberBySession(me_session_id);
	}


	@Override
	public void updateMemberSession(MemberVO user) {
		if(user == null || user.getMe_id() == null) {
			return;
		}
		memberDao.updateMemberSession(user);
		
	}
	
	//포인트 환급 요청 메서드
	@Override
	public boolean pointRefundApply(MemberVO user, MemberVO tmpUser, PointHistoryVO pointHistory) {
		if(user == null || tmpUser.getMe_point() == null) {
			return false;
		}
		//회원이 총 환급 신청중인 금액 + 환급 신청하려는 포인트 <= 현재 포인트
		
		
		
		//환급 후 예정 포인트를 user에 저장
		user.setMe_point(tmpUser.getMe_point());
		//유저 테이블에 포인트를 업데이트
		memberDao.updateMemberPoint(user);
		
		// 포인트내역 테이블에 추가( -로 바꿔서 기입)
		pointHistory.setPh_price(-pointHistory.getPh_price());
		return pointHistoryDao.insertPointHistory(pointHistory);
	}

	@Override
	public List<PointHistoryVO> getUserRefundHistoryList(MemberVO user, Criteria cri) {
		if(user == null) {
			return null;
		}
		if(cri == null) {
			cri = new Criteria(); 
		}
		return pointHistoryDao.selectPointRefundHistoryByUserNum(user, cri);
	}

	@Override
	public boolean cancelRefundApply(PointHistoryVO ph) {
		if(ph == null) {
			return false;
		}
		//환불신청하면서 차감되었던 포인트를 다시 유저에게 돌려줌
		PointHistoryVO pointHistory = pointHistoryDao.selectPointHistoryByNum(ph.getPh_num());
		int point = -(pointHistory.getPh_price());
		MemberVO user = memberDao.selectMemberByNum(pointHistory.getPh_me_num());
		//유저의 포인트에 환급 취소된 금액을 추가
		user.setMe_point(user.getMe_point() + point);
		//유저 테이블에 포인트를 업데이트
		memberDao.updateMemberPoint(user);
		//최종으로 환급신청중인 내역을 삭제
		return pointHistoryDao.deleteRefundPointHistory(ph);
	}
	
	@Override
	public int getMemberPoint(MemberVO user) {
		MemberVO dbMember = memberDao.selectMemberByNum(user.getMe_num());
		return dbMember.getMe_point();
	}
	
	@Override
	public int getTotalRefundCount(MemberVO user) {
		return pointHistoryDao.selectRefundCount(user);
	}
	
	@Override
	public boolean sendMail(String to, String title, String contents) {
		try {
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper messageHelper 
	            = new MimeMessageHelper(message, true, "UTF-8");

	        messageHelper.setFrom("khvkdlsjf1234@gmail.com");  // 보내는사람 생략하거나 하면 정상작동을 안함
	        messageHelper.setTo(to);     // 받는사람 이메일
	        messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	        messageHelper.setText(contents, true);  // 메일 내용

	        mailSender.send(message);
	        return true;
	    } catch(Exception e){
	        System.out.println(e);
	    }
		return false;
	}

	
	
	public List<MemberVO> getMemberList() {
		return memberDao.selectMemberList();
	}

	@Override
	public MemberVO userById(String name) {
		return null;
	}


	@Override
	public MemberVO isCheck2(String check) {
		MemberVO dbMember = memberDao.selectMemberNumByNick2(check);
		return dbMember;
	}


	// 프로필 수정
	@Override
	public boolean updateProfile(MemberVO member, String fi_name) {
		if(member == null) {
			return false;
		}
		// 회원 정보 입력
		memberDao.updateMember(member,fi_name);
		return true;
	}



	public List<HoldingCouponVO> getMemberCouponList(MemberVO user, Criteria cri) {
		if(user == null || user.getMe_num() == null) {
			return null;
		}
		List<HoldingCouponVO> hcList = holdingCouponDao.selectMemberCouponList(user, cri);
		if(hcList != null) {
			for(HoldingCouponVO tmp : hcList) {
				//추천인 번호가 null이 아닐때만 닉네임을 저장.
				if(tmp.getHp_invited_num() != null) {
					//추천인 회원번호를 이용해서 회원을 반환하는 메서드.
					MemberVO invitedUser = memberDao.selectMemberByNum(tmp.getHp_invited_num());
					//닉네임을 저장
					tmp.setHp_invited_nickname(invitedUser.getMe_nickname());
				}else {
					tmp.setHp_invited_nickname("");
				}
			}
			return hcList;
		}
		return null;
	}

	@Override
	public int getMemberCouponListCount(MemberVO user) {
		if(user == null || user.getMe_num() == null) {
			return 0;
		}
		return holdingCouponDao.selectMemberCouPonListCount(user);
	}

	@Override
	public boolean signupCoupon(String memberNickname, MemberVO newMember) {
		if(memberNickname == null || newMember == null) {
			return false;
		} 
		//닉네임으로 기존유저(추천인)정보 가져오는 메서드
		MemberVO dbMember = memberDao.selectMemberByNickName(memberNickname);
		if(dbMember == null) {
			return false;
		}
		//회원테이블에 등록되면서 기본키(me_num)가 생기므로, MemberVO 다시 가져와야 함.
		MemberVO dbNewMember = memberDao.selectMemberByNickName(newMember.getMe_nickname());
		//쿠폰 등록
		holdingCouponDao.insertSignupCouponOriginalMember(dbMember);
		holdingCouponDao.insertSignupCouponNewMember(dbNewMember);
		return true;
	}

	
	//회원 거주지역 조회
	@Override
	public MemberVO getMemberRegion(MemberVO user) {
		return memberDao.selectMemberRegion(user);
	}

	@Override
	public List<PreferredRegionVO> getMemberPRegion(MemberVO member) {
		return prRegionDao.selectPRListByMeNum(member.getMe_num());
	}

	@Override
	public List<Integer> getMemberPTimeWeekday(MemberVO member) {
		//DB에서 가져온 시간은 월~일 이므로, 평일/주말로 데이터 분리
		//24이하 = 월 ,145이상 = 일
		List<PreferredTimeVO> dbPrTimeList = prTimeDao.selectPTListByMeNum(member.getMe_num());
		List<PreferredTimeVO> prTimeWeekday = new ArrayList<PreferredTimeVO>();
		for (PreferredTimeVO tmp : dbPrTimeList) {
			if(tmp.getPt_ti_num() >= 1 && tmp.getPt_ti_num() <= 24) {
				tmp.setPt_ti_num(tmp.getPt_ti_num()-1);
				prTimeWeekday.add(tmp);
			}
		}
		
		List<Integer> weekTime = new ArrayList<Integer>(); 
		for(PreferredTimeVO i : prTimeWeekday ) {
			weekTime.add(i.getPt_ti_num());
		}
		return weekTime;
	}
	
	@Override
	public List<Integer> getMemberPTimeHoliday(MemberVO member) {
		//DB에서 가져온 시간은 월~일 이므로, 평일/주말로 데이터 분리
		//24이하 = 월 ,145이상 = 일
		List<PreferredTimeVO> dbPrTimeList = prTimeDao.selectPTListByMeNum(member.getMe_num());
		List<PreferredTimeVO> prTimeHoliday = new ArrayList<PreferredTimeVO>();
		for (PreferredTimeVO tmp : dbPrTimeList) {
			if(tmp.getPt_ti_num() >= 145) {
				tmp.setPt_ti_num((tmp.getPt_ti_num()-1) % 24);
				prTimeHoliday.add(tmp);
			}
		}
		List<Integer> holiTime = new ArrayList<Integer>(); 
		for(PreferredTimeVO i : prTimeHoliday ) {
			holiTime.add(i.getPt_ti_num());
		}
		return holiTime;
	}

	//이메일인증 회원탈퇴
	@Override
	public boolean emailMemberSignout(MemberVO member) {
		if(member == null || member.getMe_id() == null) {
				return false;
			}
			//아이디가 일치하는 회원 정보를 가져옴
			MemberVO dbMember = memberDao.selectMember(member.getMe_id());
			//회원정보가 없으면 탈퇴 불가
			if(dbMember == null) {
				return false;
			}
			//primary key는 남겨두고, 모든 고객 정보를 null처리 하기 위해 delete가 아닌 update문 사용
			memberDao.updateEmailMember(member.getMe_id());
			return true;
		}

	@Override
	public MemberVO getMemberByNum(MemberVO member) {
		if(member == null) {
			return null;
		}
		return memberDao.selectMemberByNum(member.getMe_num());
	}

	
	@Override
	public List<BlockVO> getMyBlockList(MemberVO user) {
		if(user == null) {
			return null;
		}
		return blockDao.selectBlockList(user.getMe_num());
	}

	@Override
	public List<MarkVO> getMyMarkList(MemberVO user) {
		if(user == null) {
			return null;
		}
		return markDao.selectMyMarkList(user);
	}

	@Override
	public boolean markListAddAndDelete(MarkVO mark) {
		//유저객체와 즐겨찾기 리스트 가져옴
		MemberVO user = memberDao.selectMemberByNum(mark.getMa_me_num());
		List<MarkVO> dbMarkList = markDao.selectMyMarkList(user);
		
		boolean isExist = false;
		for(MarkVO tmp : dbMarkList) {
			if(tmp.getMa_marked_num() == mark.getMa_marked_num()) {
				isExist = true;
			}
		}
		//이미 추가되어 있으면 true
		boolean res = isExist ? markDao.deleteMark(mark) : markDao.insertMark(mark);
		return res;
	}

	@Override
	public boolean blockListAddAndDelete(BlockVO block) {
		//유저객체와 블랙 리스트 가져옴
		MemberVO user = memberDao.selectMemberByNum(block.getBl_me_num());
		//블랙리스트 가져옴
		List<BlockVO> dbBlockList = blockDao.selectBlockList(user.getMe_num());
		boolean isExist = false;
		for(BlockVO tmp : dbBlockList) {
			if(tmp.getBl_blocked_num() == block.getBl_blocked_num()) {
				isExist = true;
			}
		}
		//이미 추가되어 있으면 true
		boolean res = isExist ? blockDao.deleteBlock(block) : blockDao.insertBlock(block);
		return res;
	}
	
	// 내가 차단한 회원정보 가져오기
	@Override
	public List<MemberVO> getBlockMemberList(List<BlockVO> blockList) {
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		for(BlockVO tmp : blockList) {
			MemberVO member = memberDao.selectMemberByNum(tmp.getBl_blocked_num());
			memberList.add(member);
		}
		return memberList;
	}

	@Override
	public List<MemberVO> getMemberMarkList(List<MarkVO> markList) {
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		for(MarkVO tmp : markList) {
			MemberVO member = memberDao.selectMemberByNum(tmp.getMa_marked_num());
			memberList.add(member);
		}
		return memberList;
	}


	@Override
	public Message updatePreferRegion(int me_num, int[] pr_rg_num) {
		Message msg = new Message(("/member/myprofile?me_num="+me_num), "수정 완료");
		
		prRegionDao.deletePreferredRegion(me_num);
		// 선호 지역
		for(int i : pr_rg_num) {
			if(i==0) {
				MemberVO member = memberDao.selectMemberByNum(me_num);
				prRegionDao.insertPreferredRegion(me_num, member.getMe_rg_num());
				return msg;
			}
		}
		
		insertPreferredRegion(me_num, pr_rg_num);
		return msg;
	}

	@Override
	public Message updatePreferTime(int me_num, int[] favoriteTime, int[] favoriteHoliTime) {
		Message msg = new Message(("/member/myprofile?me_num="+me_num), "수정 완료");
				
		prTimeDao.deletePreferredTime(me_num);
		// 선호 시간 (평일)
		if(favoriteTime !=null) {
			insertPreferredTime(0,me_num,favoriteTime);
		}
		
		// 선호 시간 (주말)
		if(favoriteHoliTime != null) {
			insertPreferredTime(1,me_num,favoriteHoliTime);
		}
		return msg;
	}

	@Override
	public boolean updateEmail(int me_num, String email) {
		return memberDao.updateEmail(me_num,email);
	}

	@Override
	public AccountVO getUserAccount(MemberVO user) {
		if(user == null) {
			return null;
		}
		return accountDao.selectAccount(user.getMe_num());
	}
	
	@Override
	public List<RegionVO> getMyMainRegionList(int rg_num) {
		if(rg_num == 0) {
			return null;
		}
		String rg_main = regionDao.selectRegionByRgNum(rg_num).getRg_main();
		
		List<RegionVO> list = regionDao.selectSubRegion(rg_main);
		return list;
	}

	@Override
	public PenaltyVO getMemberPenalty(MemberVO member, String str) {
		if(member == null) {
			return null;
		}
		return penaltyDao.selectPenaltyByMemberNumAndType(member.getMe_num(), str);
	}

	@Override
	public int getMemberPointHistoryCount(MemberVO user, Criteria cri) {
		if(user == null) {
			return 0;
		}
		if(cri.getS().equals("")) {
			cri.setS("all");
		}
		return pointHistoryDao.selectMemberPointHistoryCount(user, cri);
	}

	@Override
	public List<PointHistoryVO> getMemberPointHistory(MemberVO user, Criteria cri) {
		if(user == null) {
			return null;
		}
		if(cri.getS().equals("")) {
			cri.setS("all");
		}
		
		return pointHistoryDao.selectMemberPointHistory(user, cri);
	}

	
}



