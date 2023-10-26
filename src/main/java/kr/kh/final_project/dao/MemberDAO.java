package kr.kh.final_project.dao;

import java.util.List;

import kr.kh.final_project.vo.MemberVO;

public interface MemberDAO {

	List<MemberVO> searchMemberById(String keyword);

	List<MemberVO> searchMemberByName(String keyword);

	List<MemberVO> selectMemberList();
	
	MemberVO selectMember(@Param("me_id")String me_id);

	boolean insertMember(@Param("member")MemberVO member);

	MemberVO selectMemberNumByNick(@Param("check")String check);

	void updateMemberSession(@Param("user")MemberVO user);

	MemberVO selectMemberBySession(String me_session_id);

}
