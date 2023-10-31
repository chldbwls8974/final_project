package kr.kh.final_project.service;

import kr.kh.final_project.vo.CommentVO;

public interface CommentService {
	
	// 댓글등록하기
	boolean insertComment(CommentVO comment);

}
