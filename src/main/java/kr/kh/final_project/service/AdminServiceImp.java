package kr.kh.final_project.service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.BoardDAO;
import kr.kh.final_project.dao.BusinessDAO;
import kr.kh.final_project.dao.ExpenseDAO;
import kr.kh.final_project.dao.ManagerDAO;
import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.dao.PenaltyDAO;
import kr.kh.final_project.dao.PointHistoryDAO;
import kr.kh.final_project.dao.ReportDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PenaltyVO;
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
	
	@Autowired
	PenaltyDAO penaltyDao;
	
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
		// managerDao한테 매니저신청한 게시글을 지우라고 시킨다.
		boolean boardListDeleted = managerDao.deleteBoardManagerList(manager);
		// managerDao한테 매니저 권한을 User로 바꾸라고 시킨다.
		boolean authorityUpdated =  managerDao.updateManagerByAuthority2(manager);
		
		return boardListDeleted && authorityUpdated;
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
		
		// managerDao한테 사업자신청한 게시글을 지우라고 시킨다.
		boolean boardListDeletedByBusiness = businessDao.deleteBoardBusinessList(manager);
		// managerDao한테 사업자 권한을 User로 바꾸라고 시킨다.
		boolean authorityUpdatedByBusiness =  businessDao.updateBusinessByAuthority2(manager);
		
		return boardListDeletedByBusiness && authorityUpdatedByBusiness;
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
	public boolean reportHandle(ReportVO report) {
		if(report == null) {
			return false;
		}
		if(report.getRp_state().equals("0")) {
			//제재처리 메소드
			if(penaltyToMember(report)) {
				report.setRp_state("제재");
			}
		}else if(report.getRp_state().equals("1")) {
			report.setRp_state("확인");
		}else {
			report.setRp_state("미확인");
		}
		
		return reportDao.updateReportState(report);
	}
	//제재처리 메서드
	public boolean penaltyToMember(ReportVO report) {
		//rp_num으로 report객체를 가져오는 메서드
		ReportVO dbReport = reportDao.selectReportBynum(report);
		int me_num = dbReport.getRp_me_num2();
		//패널티 테이블에 있는지 확인
		List<PenaltyVO> pnList = penaltyDao.selectPenaltyByMemberNum(me_num);
		// 패널티 테이블에 없으면 생성
		if(pnList.size() == 0) {
			String pn_type = "경기";
			penaltyDao.insertNewPenalty(me_num, pn_type);
			pn_type = "커뮤니티";
			penaltyDao.insertNewPenalty(me_num, pn_type);
		}
		
		//신고의 종류(경기 / 커뮤니티)
		String rc_name = dbReport.getRc_name();
		// 해당하는 타입(경기/커뮤니티)의 패널티 객체를 가져오는 메서드
		PenaltyVO penalty = penaltyDao.selectPenaltyByMemberNumAndType(me_num, rc_name);
		int penaltyCount = penalty.getPn_warning();
		//rc_num은 신고 카테고리번호    //(1/ 6/ 7/ 8)은 경고없이 영구정지 처리
		int rc_num = dbReport.getRp_rc_num();
		if(rc_num == 1 || rc_num == 6 || rc_num == 7 || rc_num == 8) {
			penaltyCount += 8;
		}else {
			penaltyCount ++;
		}
		//경고 횟수를 증가
		penalty.setPn_warning(penaltyCount);
		//패널티를 업데이트 하는 메서드
		if(!penaltyDao.updatePenalty(penalty)) {
			return false;
		}
		//업데이트 한 penalty 다시 가져옴
		penalty = penaltyDao.selectPenaltyByMemberNumAndType(me_num, rc_name);
		//제재 후 경고 갯수
		penaltyCount = penalty.getPn_warning();
		LocalDateTime pn_end = LocalDateTime.now();
		
		//경고 횟수에 따라서 정지횟수, 정지일, 유저의 상태를 정지로 변경
		if(penaltyCount == 2 || penaltyCount == 4 || penaltyCount == 6 || penaltyCount >= 8) {
			if(penaltyCount == 2) {
				penalty.setPn_stop(1);
				pn_end = LocalDateTime.now().plusDays(7);
			}else if(penaltyCount == 4) {
				penalty.setPn_stop(2);
				pn_end = LocalDateTime.now().plusDays(14);
			}else if(penaltyCount == 6) {
				penalty.setPn_stop(3);
				pn_end = LocalDateTime.now().plusDays(28);
			}else if(penaltyCount >= 8) {
				penalty.setPn_stop(4);
				pn_end = LocalDateTime.now().plusYears(100);
			}
			//LocalDateTime을 Date로 형변환
			Date date = Date.from(pn_end.atZone(ZoneId.systemDefault()).toInstant());
			penalty.setPn_end(date);
			penaltyDao.updatePenalty(penalty);
			boolean res = rc_name.equals("커뮤니티") ? memberDao.updateUserBoardBanState(me_num, 1) : memberDao.updateUserMatchBanState(me_num, 1);
		}
		
		return true;
	}
	
	@Override
	public Message boardReportInsert(ReportVO report) {
		Message msg = new Message(("/board/detail?bo_num=" + report.getRp_bo_num()), "이미 신고한 게시글입니다.");
		
		//중복검사 (신고자 회원번호, 게시글 번호로 등록된 신고가 없다면 등록)
		if(reportDao.selectReportByMeNumAndBoNum(report) == null) {
			msg.setMsg(reportDao.insertBoardReport(report) ? "신고 완료." : "신고 실패.");
		}
		return msg;
	}
	
	@Override
	public Message matchReportInsert(ReportVO report) {
		Message msg = new Message(("admin/tmp?mt_num=" + report.getRp_mt_num()), "이미 신고한 회원입니다.");
		
		//중복검사 (신고자 회원번호, 게시글 번호로 등록된 신고가 없다면 등록)
		if(reportDao.selectReportByMeNumAndMtNum(report) == null) {
			msg.setMsg(reportDao.insertBoardReport(report) ? "신고 완료." : "신고 실패.");
		}
		return msg;
	}
	
	// 가격 변경 시, 공지 등록
	@Override
	public void noteregistration(int[] price, String date, MemberVO user) {
		String title = "이용 가격 변경 안내";
		String contents = 
				"안녕하세요. footing 입니다." + 	//html 형식으로 작성 ! 
                "<br><br>" + 
			    "이용 고객분들께 더 나은 서비스를 제공하고자" + date + "부터 이용 가격을 올리게 되었습니다" + 
			    "<br><br>" + 
			    "평일 개인 : " + price[0] + "원<br>"+
			    "주말 개인 : " + price[1] + "원<br>"+
			    "평일 클럽 : " + price[2] + "원<br>"+
			    "주말 클럽 : " + price[3] + "원<br>"+
			    "<br>"+"더 나은 footing이 될 수 있도록 노력하겠습니다." +
			    "<br>" + "감사합니다.";
		BoardVO board = new BoardVO();
		board.setBo_bt_num(1);
		board.setBo_me_num(user.getMe_num());
		board.setBo_title(title);
		board.setBo_contents(contents);
		boardDao.insertBoard(board);
	}
	
}
