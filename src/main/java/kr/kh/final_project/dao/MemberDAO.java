package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.MemberVO;

public interface MemberDAO {

	//List<MemberVO> selectMemberList(int me_num);
	List<MemberVO> selectMemberList(@Param("cri")Criteria cri);

	int selectTotalCount(@Param("cri")Criteria cri);
	
	MemberVO selectManager(@Param("me_num")Integer me_num);

	MemberVO selectMember(@Param("me_id")String me_id);

	boolean insertMember(@Param("member")MemberVO member);

	MemberVO selectMemberNumByNick(@Param("check")String check);

	void updateMemberSession(@Param("user")MemberVO user);

	MemberVO selectMemberBySession(String me_session_id);

}
