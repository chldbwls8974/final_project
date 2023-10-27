package kr.kh.final_project.service;

import java.util.List;


import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.PreferredRegionVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TimeVO;

public interface MemberService {

	boolean signup(MemberVO member, int[] pr_rg_num, int[] favoriteTime, int[] favoriteHoliTime);

	MemberVO getMember(String me_id);

	boolean pointRefundApply(MemberVO user, PointHistoryVO pointHistory);

	List<RegionVO> getMainRegion();

	List<RegionVO> getSubRegionByMainRegion(String rg_main);

	MemberVO isCheck(String check);

	MemberVO login(MemberVO member);

	MemberVO getMemberBySession(String me_session_id);

	void updateMemberSession(MemberVO user);

	MemberVO userById(String name);

	Object checkId(String id);
	
	boolean sendMail(String to, String title, String contents);

	Object checkEmail(String email);

	Object checkNickName(String nickname);

	List<TimeVO> getAllTime();


}