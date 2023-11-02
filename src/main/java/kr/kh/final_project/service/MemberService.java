package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.pagination.Criteria;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
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

	List<PointHistoryVO> getUserRefundHistoryList(MemberVO user);

	boolean cancelRefundApply(PointHistoryVO ph);

	MemberVO isCheck2(String check);
	
	boolean updateProfile(MemberVO user, MultipartFile profileImage);
}
