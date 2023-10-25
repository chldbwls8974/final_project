package kr.kh.final_project.dao;

import java.util.List;

import kr.kh.final_project.vo.MemberVO;

public interface MemberDAO {

	List<MemberVO> searchMemberById(String keyword);

	List<MemberVO> searchMemberByName(String keyword);

	List<MemberVO> selectMemberList();

//	boolean applyManager(@Param("member")MemberVO member);

}
