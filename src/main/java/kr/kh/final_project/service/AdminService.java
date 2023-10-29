package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;

public interface AdminService {
	
	// 회원정보 조회
	//List<MemberVO> getMemberList(int me_num);
	// 회원정보 조회
	List<MemberVO> getMemberList(Criteria cri);
	//회원정보 페이지네이션
	int getTotalCount(Criteria cri);
	
	// 매니저신청 정보조회
	List<ManagerVO> getManagerList(Criteria cri);
	// 매니저신청 수락 버튼(권한 바꾸기)
	boolean updateManager(ManagerVO manager);
	// 매니저 정보 페이지네이션 (총 매니저신청 수 가져오기)
	int getTotalCount2(Criteria cri);
	
	// 매니저권한 조회
	List<ManagerVO> getManagerList2(Criteria cri);
	// 매니저 권한 바꾸기
	boolean updateManager2(ManagerVO manager);
	// 매니저 정보 페이지네이션 (총 매니저 수 가져오기)
	int getTotalCount3(Criteria cri);
	
	// 사업자신청 정보조회
	List<ManagerVO> getBusinessList(Criteria cri);
	// 사업자신청 수락 버튼(권한 바꾸기)
	boolean updateBusiness(ManagerVO manager);
	// 사업자 정보 페이지네이션 (총 사업자신청 수 가져오기)
	int getTotalCount4(Criteria cri);
	
	// 사업자 정보조회
	List<ManagerVO> getBusinessList2(Criteria cri);
	// 사업자 권한 바꾸기
	boolean updateBusiness2(ManagerVO manager);
	// 사업자 정보 페이지네이션( 총 사업자 수 가져오기)
	int getTotalCount5(Criteria cri);
	
}
