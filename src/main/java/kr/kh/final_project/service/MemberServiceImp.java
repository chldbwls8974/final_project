package kr.kh.final_project.service;

import java.util.List;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.PreferredTimeDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.dao.TimeDAO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TimeVO;

@Service
public class MemberServiceImp implements MemberService{
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	RegionDAO regionDao;

	@Autowired
	PreferredRegionDAO prRegionDao;
	
	@Autowired
	PreferredTimeDAO prTimeDao;
	
	@Autowired
	TimeDAO timeDao;

	@Override
	public MemberVO userById(String name) {
		
		return null;
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
		String idRegex = "^[a-zA-Z][a-zA-Z0-9]{6,10}$";
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
		insertPrefferedTime(0,pr_me_num,favoriteTime);
		
		// 선호 시간 (주말)
		insertPrefferedTime(1,pr_me_num,favoriteHoliTime);
		
		// 선호 지역
		insertPrefferedRegion(pr_me_num, pr_rg_num);
		
		return true;
	}
	
	
	// 선호 지역을 넣는 메서드
	private void insertPrefferedRegion(int pr_me_num, int[] pr_rg_num) {
		int pr1 = 0;
		int pr2 = 0;
		int pr3 = 0;
		
		if(pr_rg_num[0]==0) { return;}
		
		if(pr_rg_num.length > 0) {
			pr1 = pr_rg_num[0];
			prRegionDao.insertPreferredRegion(pr_me_num,pr1);
		}
		if(pr_rg_num.length > 1) {
			pr2 = pr_rg_num[1];
			prRegionDao.insertPreferredRegion(pr_me_num,pr2);
		}
		if(pr_rg_num.length > 2) {
			pr3 = pr_rg_num[2];
			prRegionDao.insertPreferredRegion(pr_me_num,pr3);
		}
	}

	
	// 선호시간을 넣는 메서드
	private void insertPrefferedTime(int div, int pr_me_num, int[] Time) {
		int len = Time.length;
		
		if(len==0) {
			return;
		}
		
		for(int i = 0 ; i <len ; i++) {
			int t = Time[i];
			
			// 평일이면
			if(div == 0) {
				// 선호시간은 2시간 간격이기 때문에 for문이 2개 필요함
				//월(0) ~ 금(4)까지 첫번째 시간을 넣기 위한 반복문 
				for(int day = 0 ; day < 5; day++) {
					int pt_num = (t+1) +(24*day); // 요일별 시간테이블의 숫자
					prTimeDao.insertPreferredTime(pt_num, pr_me_num);
				}
				//월(0) ~ 금(4)까지 두번째 시간을 넣기 위한 반복문 
				for(int day = 0 ; day < 5; day++) {
					int pt_num = (t+2) +(24*day); // 요일별 시간테이블의 숫자
					prTimeDao.insertPreferredTime(pt_num, pr_me_num);
				}
			}
			
			// 주말이면
			else if(div == 1) {
				// 선호시간은 2시간 간격이기 때문에 for문이 2개 필요함
				//토(5), 일(6)첫번째 시간을 넣기 위한 반복문 
				for(int day = 5 ; day < 7; day++) {
					int pt_num = (t+1) +(24*day); // 요일별 시간테이블의 숫자
					prTimeDao.insertPreferredTime(pt_num, pr_me_num);
				}
				//토(5), 일(6) 두번째 시간을 넣기 위한 반복문 
				for(int day = 5 ; day < 7; day++) {
					int pt_num = (t+2) +(24*day); // 요일별 시간테이블의 숫자
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

	@Override
	public boolean pointRefundApply(MemberVO user, PointHistoryVO pointHistory) {
		return false;
	}

	@Override
	public boolean sendMail(String to, String title, String contents) {
		try {
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper messageHelper 
	            = new MimeMessageHelper(message, true, "UTF-8");

	        messageHelper.setFrom("stajun@naver.com");  // 보내는사람 생략하거나 하면 정상작동을 안함
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

	
	





}
