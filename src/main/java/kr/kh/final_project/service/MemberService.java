package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.MemberVO;

public interface MemberService {

	List<MemberVO> searchMemberById(String keyword);

	List<MemberVO> searchMemberByName(String keyword);

	List<MemberVO> getMemberList();


	
}
