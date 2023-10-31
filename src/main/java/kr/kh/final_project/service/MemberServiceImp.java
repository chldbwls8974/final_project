package kr.kh.final_project.service;

import java.util.List;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.pagination.Criteria;
import java.util.regex.Pattern;


import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.dao.PointHistoryDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.PreferredTimeDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.dao.TimeDAO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
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
	PointHistoryDAO pointHistoryDao;

	
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
		
		// 회원 정보 입력
		memberDao.insertMember(member);
		
		// 입력한 회원정보의 num값 가져오기
		int pr_me_num = memberDao.selectMember(member.getMe_id()).getMe_num();
		// 선호 시간 (평일)
		if(favoriteTime !=null) {
			insertPrefferedTime(0,pr_me_num,favoriteTime);
		}
		
		// 선호 시간 (주말)
		if(favoriteHoliTime != null) {
			insertPrefferedTime(1,pr_me_num,favoriteHoliTime);
		}
		
		// 선호 지역
		insertPrefferedRegion(pr_me_num, pr_rg_num);
		
		return true;
	}
	
	
	// 선호 지역을 넣는 메서드
	private void insertPrefferedRegion(int pr_me_num, int[] pr_rg_num) {
		for(int i : pr_rg_num) {
			if(i!=0) {
				prRegionDao.insertPreferredRegion(pr_me_num,i);
			}
		}
	}

	
	// 선호시간을 넣는 메서드
	private void insertPrefferedTime(int div, int pr_me_num, int[] Time) {
		int len = Time.length;
		
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
		if(member == null || member.getMe_id() == null || member.getMe_pw() == null) {
			return null;
		}
		MemberVO user = memberDao.selectMember(member.getMe_id());
		if(user == null) {
			return null;
		}
//		if(passwordEncoder.matches(member.getMe_pw(), user.getMe_pw())) {
//			return user;
//		}
		
		//원활한 테스트를 위해서 남겨두는 코드. 나중에 이거 삭제하고 위의 주석을 해제하면 됨
		if(member.getMe_pw().equals(user.getMe_pw())) {
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
	public List<PointHistoryVO> getUserRefundHistoryList(MemberVO user) {
		if(user == null) {
			return null;
		}
		return pointHistoryDao.selectPointRefundHistoryByUserNum(user);
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
	public boolean updateProfile(MemberVO member, MemberVO user, MultipartFile file) {
		if(user == null || user.getMe_id() == null) {
			return false;
		}
		return memberDao.updateMemberProfile(user);
	}

	@Override
	public MemberVO isCheck2(String check) {
		MemberVO dbMember = memberDao.selectMemberNumByNick2(check);
		return dbMember;
	}



//	@Override
//	public boolean applyManager(MemberVO member, MemberVO user, MultipartFile[] files) {
//		if(user == null || user.getMe_id() == null) {
//			return false;
//		}
//		member.setMe_id(user.getMe_id());
//		if(!memberDao.applyManager(member)) {
//			return false;
//		}
//		//첨부파일을 업로드
//		if(files == null || files.length == 0) {
//			return true;
//		}
//		//첨부파일을 서버에 업로드 하고, DB에 저장
//		uploadFileAndInsert(files, member.getMe_id());
//		return memberDao.applyManager(member);
//	}

	}



