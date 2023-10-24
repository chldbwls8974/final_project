package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.MemberVO;

public interface MemberService {

	MemberVO userById(String name);
	
	//List<MemberVO> getMemberList(Criteria cri);
}
