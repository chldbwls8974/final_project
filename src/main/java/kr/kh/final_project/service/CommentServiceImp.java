package kr.kh.final_project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.CommentDAO;
import kr.kh.final_project.vo.CommentVO;

@Service
public class CommentServiceImp implements CommentService{
	
	@Autowired
	CommentDAO commentDao;
	
	String uploadPath = "D:\\uploadfiles";

	
	// 댓글 등록하기
	@Override
	// 등록할 comment정보가 null이거나 me_num이 0이거나 등록 내용이 null 이면 false로 반환
	public boolean insertComment(CommentVO comment) {
		if(comment == null || 
		   comment.getCo_me_num() == 0 || 
		   comment.getCo_comments()==null) {
			return false;
	}
		return commentDao.insertComment(comment);

	}
}
