package kr.kh.final_project.service;

import java.util.List;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.dao.PointHistoryDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.RegionVO;

@Service
public class MemberServiceImp implements MemberService{
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	RegionDAO regionDao;

	@Autowired
	PointHistoryDAO pointHistoryDao;
	
	@Override
	public MemberVO userById(String name) {
		
		return null;
	}
	
	@Override
	public boolean signup(MemberVO member) {
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
		//String encPw = passwordEncoder.encode(member.getMe_pw());
		//member.setMe_pw(encPw);
		//회원가입
		return memberDao.insertMember(member);
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
	public MemberVO isCheck(String check) {
		MemberVO dbMember = memberDao.selectMemberNumByNick(check);
		return dbMember;
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





	





}
