package kr.kh.final_project.service;

import java.util.regex.Pattern;

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
	
	@Override
	public boolean signup(MemberVO member) {
		if(member == null) {
			return false;
		}
		
		//아이디 중복 확인
		MemberVO dbMember = memberDao.selectMember(member.getMe_id());
		//가입하려는 아이디가 이미 가입된 경우
		if(dbMember != null) {
			return false;
		}
		//아이디, 비번 null 체크 + 유효성 검사
		//아이디는 영문으로 시작하고, 6~15자
		String idRegex = "^[a-zA-Z][a-zA-Z0-9]{6,10}$";
		//비번은 영문,숫자,!@#$%로 이루어지고 6~15자 
		String pwRegex = "^[a-zA-Z0-9!@#$%]{10,20}$";
		
		//아이디가 유효성에 맞지 않으면
		if(!Pattern.matches(idRegex, member.getMe_id())) {
			return false;
		}
		//비번이 유효성에 맞지 않으면
		if(!Pattern.matches(pwRegex, member.getMe_pw())) {
			return false;
		}
		
		//비번 암호화 
		//String encPw = passwordEncoder.encode(member.getMe_pw());
		//member.setMe_pw(encPw);
		//회원가입
		return memberDao.insertMember(member);
	}
	
	@Override
	public MemberVO getMember(String me_id) {
		if(me_id == null) {
			return null;
		}
		MemberVO dbMember = memberDao.selectMember(me_id);
		return dbMember;
	}
	
	@Override
	public MemberVO getManager(Integer me_num) {
		if(me_num == null) {
			return null;
		}
		return memberDao.selectManager(me_num);
	}

}
