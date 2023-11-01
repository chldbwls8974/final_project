package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.CommentDAO;
import kr.kh.final_project.pagination.Criteria;
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
	// 등록된 댓글 목록 가져오기 (댓글 조회하기)
	@Override
	public List<CommentVO> getCommentList(int bo_num, Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		return commentDao.selectCommentList(bo_num, cri);
	}
	// 댓글 페이지네이션 (해당 게시글의 총 댓글 수 가져오기)
	@Override
	public int getTotalCount(int bo_num) {
		return commentDao.selectCommentCount(bo_num);
	}
}
