package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService{

	@Autowired
	MemberDAO memberDao;

	@Override
	public MemberVO userById(String name) {
		
		return null;
	}
	 
	
	// 회원정보 출력 & 검색 기능
	/*
	 * @Override 
	 * public List<MemberVO> getMemberList(Criteria cri) { 
	 * if (cri == null) { 
	 * cri = new Criteria(); } 
	 * return memberDao.selectMemberList(cri); }
	 * 
	 */
}
