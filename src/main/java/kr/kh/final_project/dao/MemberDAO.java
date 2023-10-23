package kr.kh.final_project.dao;

import java.util.List;

import kr.kh.final_project.vo.MemberVO;

public interface MemberDAO {
	
	List<MemberVO> selectMemberList(int me_num);
}
