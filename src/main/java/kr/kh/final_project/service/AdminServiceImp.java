package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.BoardDAO;
import kr.kh.final_project.dao.BusinessDAO;
import kr.kh.final_project.dao.ManagerDAO;
import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;

@Service
public class AdminServiceImp implements AdminService{

	@Autowired
	MemberDAO memberDao;

	@Autowired
	BoardDAO boardDao;

	@Autowired
	ManagerDAO managerDao;
	
	@Autowired
	BusinessDAO businessDao;
	
	// 회원정보 조회
	//@Override
	//public List<MemberVO> getMemberList(int me_num) {
		//return memberDao.selectMemberList(me_num); 
	//}
	// 회원정보 조회
		@Override
		public List<MemberVO> getMemberList(Criteria cri) {
			
			return memberDao.selectMemberListBySearch(cri); 
		}
	// 회원 페이지네이션
	@Override
	public int getTotalCount(Criteria cri) {
		// cri가 null일 때 기본 Criteria의 객체를 생성한다.
		if(cri == null) {
			cri = new Criteria();
		}//memberDao한테 cri를 사용하여 데이터베이스에서 검색해야 하는 총 데이터 항목수를 가져오라고
		return memberDao.selectTotalCount(cri);
	}
	
	
	// 매니저신청 조회
	@Override
	public List<ManagerVO> getManagerList(Criteria cri) {
		return managerDao.selectManagerList(cri);
	}
	// 매니저신청 수락버튼 (권한 바꾸기)
	@Override
	public boolean updateManager(ManagerVO manager) {
		if(manager == null || manager.getMe_nickname() == null || manager.getMe_authority() == null) {
			return false;
		}
		return managerDao.updateManagerByAuthority(manager);
	}
	// 매니저신청 페이지네이션
	@Override
	public int getTotalCount2(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		return managerDao.selectTotalCount(cri);
	}
	
	
	// 사업자신청 조회하기
	@Override
	public List<ManagerVO> getBusinessList(Criteria cri) {
		
		return businessDao.selectBusinessList(cri);
	}
	// 사업자신청 수락버튼 (권한 바꾸기)
	@Override
	public boolean updateBusiness(ManagerVO manager) {
		if(manager == null || manager.getMe_nickname() == null || manager.getMe_authority() == null) {
			return false;
		}
		return businessDao.updateBusinessByAuthority(manager);
	}
	// 사업자신청 페이지네이션
	@Override
	public int getTotalCount3(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		return businessDao.selectTotalCount(cri);
	}
	

	
}
