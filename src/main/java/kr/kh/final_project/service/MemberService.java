package kr.kh.final_project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.RegionVO;

public interface MemberService {

	MemberVO getManager(Integer me_num);

	boolean signup(MemberVO member);

	MemberVO getMember(String me_id);

	boolean pointRefundApply(MemberVO user, PointHistoryVO pointHistory);

	List<RegionVO> getMainRegion();

	List<RegionVO> getSubRegionByMainRegion(String rg_main);

	MemberVO isCheck(String check);

	MemberVO login(MemberVO member);

	MemberVO getMemberBySession(String me_session_id);

	void updateMemberSession(MemberVO user);


	MemberVO userById(String name);


}