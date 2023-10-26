package kr.kh.final_project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.RegionVO;

public interface MemberService {

	boolean signup(MemberVO member);

	MemberVO getMember(String me_id);

	List<RegionVO> getMainRegion();

	List<RegionVO> getSubRegionByMainRegion(String rg_main);

	MemberVO isCheck(String check);

	MemberVO login(MemberVO member);

	MemberVO getMemberBySession(String me_session_id);

	void updateMemberSession(MemberVO user);


	MemberVO userById(String name);

	boolean pointRefundApply(MemberVO user, MemberVO tmpUser, PointHistoryVO pointHistory);

	int refundAblePoint(MemberVO user);

	List<PointHistoryVO> getUserRefundHistoryList(MemberVO user);

	boolean cancelRefundApply(PointHistoryVO ph);


}