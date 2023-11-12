package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.CommentVO;
import kr.kh.final_project.vo.MemberVO;

public interface CommentService {
	
	// 댓글등록하기
	boolean insertComment(CommentVO comment);
	// 등록된 댓글 리스트 가져오기
	List<CommentVO> getCommentList(int bo_num, Criteria cri, MemberVO user);
	// 해당 게시글의 총 댓글 수 가져오기
	int getTotalCount(int bo_num);
	// 댓글 삭제하기
	boolean deleteComment(CommentVO comment, MemberVO user);
	// 댓글 수정하기
	boolean updateComment(CommentVO comment, MemberVO user);
	
	// 답글 등록하기
	boolean insertComment2(CommentVO comment);
	// 등록된 답글 리스트 가져오기
	List<CommentVO> getCommentList2(int bo_num, Criteria cri);

	

}
