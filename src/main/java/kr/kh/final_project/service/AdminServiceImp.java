package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.BoardDAO;
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
	
	// 회원정보 조회
	@Override
	public List<MemberVO> getMemberList(int me_num) {
		return memberDao.selectMemberList(me_num); 
	}
	// 회원 페이지네이션
	@Override
	public int getTotalCount(Criteria cri) {
		
		return 1;
	}
	// 매니저신청 조회
	@Override
	public List<ManagerVO> getManagerList() {
		return managerDao.selectManagerList();
	}
	

	
}
