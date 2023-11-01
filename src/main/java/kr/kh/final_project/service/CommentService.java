package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.CommentVO;

public interface CommentService {
	
	// 댓글등록하기
	boolean insertComment(CommentVO comment);
	// 등록된 댓글 리스트 가져오기
	List<CommentVO> getCommentList(int bo_num, Criteria cri);
	// 해당 게시글의 총 댓글 수 가져오기
	int getTotalCount(int bo_num);

}
