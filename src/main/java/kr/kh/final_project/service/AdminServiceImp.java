package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.BoardDAO;
import kr.kh.final_project.dao.BusinessDAO;
import kr.kh.final_project.dao.ExpenseDAO;
import kr.kh.final_project.dao.ManagerDAO;
import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.dao.PointHistoryDAO;
import kr.kh.final_project.dao.ReportDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.ReportVO;

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
	
	@Autowired
	PointHistoryDAO pointHistoryDao;

	@Autowired
	ExpenseDAO expenseDao;
	
	@Autowired
	ReportDAO reportDao;
	
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
	// 매니저신청 수락버튼 (권한 MANAGER로 바꾸기)
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
	
	//매니저권한 조회
	@Override
	public List<ManagerVO> getManagerList2(Criteria cri) {
		return managerDao.selectManagerList2(cri);
	}
	
	// 매니저권한 삭제버튼(권한 USER로 바꾸기 )
	@Override
	public boolean updateManager2(ManagerVO manager) {
		if(manager == null || manager.getMe_nickname() == null || manager.getMe_authority() == null) {
			return false;
		}
		return managerDao.updateManagerByAuthority2(manager);
	}
	// 매니저 페이지네이션
	@Override
	public int getTotalCount3(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		return managerDao.selectTotalCount2(cri);
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
	public int getTotalCount4(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		return businessDao.selectTotalCount(cri);
	}
	@Override
	public List<PointHistoryVO> getRefundListBySearch(Criteria cri, String searchType1, String searchType2) {
		if(cri == null) {
			cri = new Criteria();
		}
		return pointHistoryDao.selectPointRefundHistoryBySearch(cri, searchType1, searchType2);
	}
	@Override
	public int getRefundListBySearchCount(Criteria cri, String searchType1, String searchType2) {
		if(cri == null) {
			cri = new Criteria();
		}
		return pointHistoryDao.selectPointRefundHistoryCountBySearch(cri, searchType1, searchType2);
	}
	@Override
	public boolean refundApproval(PointHistoryVO ph) {
		if(ph == null || ph.getPh_num() == 0) {
			return false;
		}
		return pointHistoryDao.updateRefundApproval(ph);
	}	
	
	@Override
	public List<ExpenseVO> getPriceList() {
		return expenseDao.selectExpense();
	}
	@Override
	public boolean updatePrice(int[] price,String date) {
		int count = 0;
		
		for(int i:price) {
			count++;
			expenseDao.updatePrice(count,i,date);
			
		}
		return true;
	}
	
	//사업자 권한 조회하기
	@Override
	public List<ManagerVO> getBusinessList2(Criteria cri) {
		
		return businessDao.selectBusinessList2(cri);
	}
	// 사업자권한 삭제버튼(권한 USER로 바꾸기 )
	@Override
	public boolean updateBusiness2(ManagerVO manager) {
		if(manager == null || manager.getMe_nickname() == null || manager.getMe_authority() == null) {
			return false;
		}
		return businessDao.updateBusinessByAuthority2(manager);
	}
	// 사업자 페이지네이션
	@Override
	public int getTotalCount5(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		return businessDao.selectTotalCount2(cri);
	}
	@Override
	public List<ReportVO> getReportListBySearch(Criteria cri, String reportType, String searchType1,
			String searchType2) {
		if(cri == null) {
			cri = new Criteria();
		}
		return reportDao.selectReportListBySearch(cri, reportType, searchType1, searchType2);
	}
	@Override
	public int getReportListBySearchCount(Criteria cri, String reportType, String searchType1, String searchType2) {
		if(cri == null) {
			cri = new Criteria();
		}
		return reportDao.selectReportListCountBySearch(cri, reportType, searchType1, searchType2);
	}
	@Override
	public boolean boardReportHandle(ReportVO report) {
		if(report == null) {
			return false;
		}
		if(report.getRp_state().equals("0")) {
			report.setRp_state("제재");
		}else if(report.getRp_state().equals("1")) {
			report.setRp_state("확인");
		}
		
		return reportDao.updateReportState(report);
	}
	

	
}
