package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService{

	@Autowired
	MemberDAO memberDao;

	@Override
	public MemberVO userById(String name) {
		
		return null;
	}

	// 회원정보 출력
	@Override
	public List<MemberVO> getMemberList(int me_num) {
		// 현재 페이지 정보를 가지고 memberDao에게 회원정보리스트를 가져오라고 시킨다.
		return memberDao.selectMemberList(me_num);
	}
}
