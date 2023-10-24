package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;

public interface AdminService {

	List<MemberVO> getMemberList(int me_num);
	
	List<ManagerVO> getManagerList();
	
}
