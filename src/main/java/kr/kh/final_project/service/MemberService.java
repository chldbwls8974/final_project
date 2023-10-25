package kr.kh.final_project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;

public interface MemberService {

	MemberVO userById(String name);

	boolean applyManager(MemberVO member, MemberVO user, MultipartFile[] files);

	boolean signup(MemberVO member);

	MemberVO getMember(String me_id);

	List<RegionVO> getMainRegion();

	List<RegionVO> getSubRegionByMainRegion(String rg_main);

	MemberVO isCheck(String check);

	MemberVO login(MemberVO member);

	MemberVO getMemberBySession(String me_session_id);

	void updateMemberSession(MemberVO user);



}
