package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.MemberVO;

public interface MemberDAO {

	MemberVO selectManager(@Param("me_num")Integer me_num);

	MemberVO selectMember(@Param("me_id")String me_id);

	boolean insertMember(@Param("m")MemberVO member);

	MemberVO selectMemberNumByNick(@Param("check")String check);

	void updateMemberSession(@Param("user")MemberVO user);

	MemberVO selectMemberBySession(String me_session_id);

}
