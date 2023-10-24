package kr.kh.final_project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService{

	@Autowired
	private MemberDAO memberDao;


}
