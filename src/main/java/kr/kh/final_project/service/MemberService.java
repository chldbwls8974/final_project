package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.AccountVO;
import kr.kh.final_project.vo.BlockVO;
import kr.kh.final_project.vo.HoldingCouponVO;
import kr.kh.final_project.vo.MarkVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.PreferredRegionVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TimeVO;

public interface MemberService {

	boolean signup(MemberVO member, int[] pr_rg_num, int[] favoriteTime, int[] favoriteHoliTime);
	List<MemberVO> searchMemberById(String keyword);

	List<MemberVO> searchMemberByName(String keyword);

	List<MemberVO> getMemberList();

	MemberVO getMember(String me_id);

	List<RegionVO> getMainRegion();

	List<RegionVO> getSubRegionByMainRegion(String rg_main);

	MemberVO isCheck(String check);

	MemberVO login(MemberVO member);

	MemberVO getMemberBySession(String me_session_id);

	void updateMemberSession(MemberVO user);

	MemberVO userById(String name);
	
	//List<MemberVO> getMemberList(Criteria cri);

	Object checkId(String id);
	
	boolean sendMail(String to, String title, String contents);

	Object checkEmail(String email);

	Object checkNickName(String nickname);

	List<TimeVO> getAllTime();

	boolean pointRefundApply(MemberVO user, MemberVO tmpUser, PointHistoryVO pointHistory);

	List<PointHistoryVO> getUserRefundHistoryList(MemberVO user, Criteria cri);

	boolean cancelRefundApply(PointHistoryVO ph);

	MemberVO isCheck2(String check);
	
	int getMemberPoint(MemberVO user);
	
	int getTotalRefundCount(MemberVO user);
	
	List<HoldingCouponVO> getMemberCouponList(MemberVO user, Criteria cri);
	
	int getMemberCouponListCount(MemberVO user);
	
	boolean signupCoupon(String memberNickname, MemberVO newMember);
	
	
	//나의 상세정보 페이지에서  거주지역, 선호지역, 선호시간대 정보 받아오기
	MemberVO getMemberRegion(MemberVO user);
	
	List<PreferredRegionVO> getMemberPRegion(MemberVO member);
	
	List<Integer> getMemberPTimeWeekday(MemberVO member);
	
	List<Integer> getMemberPTimeHoliday(MemberVO dbMember);
	
	boolean emailMemberSignout(MemberVO member);
	
	MemberVO getMemberByNum(MemberVO member);
	
	List<BlockVO> getMyBlockList(MemberVO user);
	
	List<MarkVO> getMyMarkList(MemberVO user);
	
	boolean markListAddAndDelete(MarkVO mark);
	
	boolean updateProfile(MemberVO member, String fi_name);
	
	boolean blockListAddAndDelete(BlockVO block);
	// 내가차단한 회원 정보 가져오기
	List<MemberVO> getBlockMemberList(List<BlockVO> blockList);
	// 내가 즐겨찾기한 회원 정보 가져오기
	List<MemberVO> getMemberMarkList(List<MarkVO> markList);
	
	Message updatePreferRegion(int me_num, int[] pr_rg_num);
	
	Message updatePreferTime(int me_num, int[] favoriteTime, int[] favoriteHoliTime);
	
	boolean updateEmail(int me_num, String email);
	
	AccountVO getUserAccount(MemberVO user);
	
	List<RegionVO> getMyMainRegionList(int rg_num);
	

}