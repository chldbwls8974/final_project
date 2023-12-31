package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.BoardDAO;
import kr.kh.final_project.dao.CommentDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.CommentVO;
import kr.kh.final_project.vo.MemberVO;

@Service
public class CommentServiceImp implements CommentService{
	
	@Autowired
	CommentDAO commentDao;
	
	@Autowired
	BoardDAO boardDao;	
	
	String uploadPath = "D:\\uploadfiles";

	
	// 댓글 등록하기 & 댓글수 적용하기
	@Override
	// 등록할 comment정보가 null이거나 me_num이 0이거나 등록 내용이 null 이면 false로 반환
	public boolean insertComment(CommentVO comment) {
		if(comment == null || 
		   comment.getCo_me_num() == 0 || 
		   comment.getCo_comments()==null) {
			return false;
	}
		// 댓글 등록을 res에 저장
		boolean res = commentDao.insertComment(comment);
		
		if(!res) {
			return false;
		}
		// 게시글의 댓글수를 수정한다.
		boardDao.updateBoardComment(comment.getCo_bo_num());
	
		return true;

	}
	// 등록된 댓글 목록 가져오기 (댓글 조회하기)
	@Override
	public List<CommentVO> getCommentList(int bo_num, Criteria cri, MemberVO user) {
		if(cri == null) {
			cri = new Criteria();
		}
		return commentDao.selectCommentList(bo_num, cri, user);
	}
	// 댓글 페이지네이션 (해당 게시글의 총 댓글 수 가져오기)
	@Override
	public int getTotalCount(int bo_num) {
		return commentDao.selectCommentCount(bo_num);
	}
	// 댓글 삭제하기
	@Override
	public boolean deleteComment(CommentVO comment, MemberVO user) {
		if(user == null || user.getMe_num() == 0) {
			return false;
		}
		if(comment == null || comment.getCo_num() == 0) {
			return false;
		}
		//comment객체는 댓글번호 정보밖에 없으므로 db에서 comment객체 찾아옴
		CommentVO dbComment = commentDao.selectComment(comment.getCo_num());
		if(dbComment == null ||  dbComment.getCo_me_num()!=(user.getMe_num())) {
			return false;
		}
		//지우려고 하는 댓글이 co_num = co_ori_num 일 때 (==대댓글이 아닐 때)
		if(dbComment.getCo_num() == dbComment.getCo_ori_num()) {
			//대댓글 리스트를 가져오는 메서드 (co_ori_num이 같은 댓글)
			List<CommentVO> commentList = commentDao.selectCommentCommentList(dbComment.getCo_ori_num());
			for(CommentVO tmp : commentList) {
				//원본 댓글이 삭제되면 대댓글도 같이 삭제
				commentDao.deleteComment(tmp.getCo_num());
			}
		}else {
			commentDao.deleteComment(dbComment.getCo_num());
		}
		//댓글객체의 게시판번호로 댓글테이블에서 갯수를 조회하여 게시글테이블에 업데이트하는 쿼리
		boardDao.updateBoardComment(dbComment.getCo_bo_num());	
		return true;
	}
	// 댓글 수정하기
	@Override
	public boolean updateComment(CommentVO comment, MemberVO user) {
		if(user == null || user.getMe_num() == null) {
			return false;
		}
		if(comment == null || comment.getCo_num() == 0 || 
				comment.getCo_comments() == null ||
				comment.getCo_comments().trim().length() == 0) {
			return false;
		}
		//댓글 존재 확인 및 작성자 확인 
		CommentVO dbComment = commentDao.selectComment(comment.getCo_num());
		if(dbComment == null || dbComment.getCo_me_num() != (user.getMe_num())) {
			return false;
		}
		return commentDao.updateComment(comment);
	}
	
	// 답글 등록하기
	@Override
	public boolean insertComment2(CommentVO comment) {
		if(comment == null || 
				   comment.getCo_me_num() == 0 || 
				   comment.getCo_comments()==null) {
					return false;
			}
				// 댓글 등록을 res에 저장
				boolean res = commentDao.insertComment2(comment);
				
				if(!res) {
					return false;
				}
				// 게시글의 댓글수를 수정한다.
				boardDao.updateBoardComment2(comment.getCo_bo_num());
			
				return true;
			}
	
	// 등록된 답글 목록 가져오기 (답글 조회하기)
	@Override
	public List<CommentVO> getCommentList2(int bo_num, Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		return commentDao.selectCommentList2(bo_num, cri);
	}

}
