package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService{

	@Autowired
	private MemberDAO memberDao;

	
	@Override
	public List<MemberVO> searchMemberById(String keyword) {
		return memberDao.searchMemberById(keyword);
	}

	@Override
	public List<MemberVO> searchMemberByName(String keyword) {
		return memberDao.searchMemberByName(keyword);
	}

	@Override
	public List<MemberVO> getMemberList() {
		return memberDao.selectMemberList();
	}




//	@Override
//	public boolean applyManager(MemberVO member, MemberVO user, MultipartFile[] files) {
//		if(user == null || user.getMe_id() == null) {
//			return false;
//		}
//		member.setMe_id(user.getMe_id());
//		if(!memberDao.applyManager(member)) {
//			return false;
//		}
//		//첨부파일을 업로드
//		if(files == null || files.length == 0) {
//			return true;
//		}
//		//첨부파일을 서버에 업로드 하고, DB에 저장
//		uploadFileAndInsert(files, member.getMe_id());
//		return memberDao.applyManager(member);
//	}



}
