package kr.kh.final_project.service;

import kr.kh.final_project.vo.MemberVO;

public interface MemberService {

	MemberVO getManager(Integer me_num);

	boolean signup(MemberVO member);

	MemberVO getMember(String me_id);

	MemberVO userById(String name);


}