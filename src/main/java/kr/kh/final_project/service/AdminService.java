package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.ReportVO;

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
	// 포인트 환급 관리 리스트를 검색결과로 가져오는 메서드
	List<PointHistoryVO> getRefundListBySearch(Criteria cri, String searchType1, String searchType2);
	// 포인트 환급 관리 리스트의 갯수를 가져오는 메서드
	int getRefundListBySearchCount(Criteria cri, String searchType1, String searchType2);
	//환급을 승인하는 메서드
	boolean refundApproval(PointHistoryVO ph);
	
	
	// 사업자 정보조회
	List<ManagerVO> getBusinessList2(Criteria cri);
	// 사업자 권한 바꾸기
	boolean updateBusiness2(ManagerVO manager);
	// 사업자 정보 페이지네이션( 총 사업자 수 가져오기)
	int getTotalCount5(Criteria cri);
	
	List<ExpenseVO> getPriceList();
	
	boolean updatePrice(int[] price,String date);
	//신고리스트를 가져오는 메서드
	List<ReportVO> getReportListBySearch(Criteria cri, String reportType, String searchType1, String searchType2);
	
	int getReportListBySearchCount(Criteria cri, String reportType, String searchType1, String searchType2);
	//신고를 처리 하는 메서드
	boolean reportHandle(ReportVO report);
	
	
	
	
}
