package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;

public interface AdminService {
	
	// 회원정보 조회
	List<MemberVO> getMemberList(int me_num);
	//회원정보 페이지네이션
	int getTotalCount(Criteria cri);
	// 매니저신청 정보조회
	List<ManagerVO> getManagerList();
	
	
}
