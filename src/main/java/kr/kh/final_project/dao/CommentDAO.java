package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.CommentVO;

public interface CommentDAO {
	// 댓글 등록하기
	boolean insertComment(@Param("comment")CommentVO comment);
	// 댓글 리스트 가져오기
	List<CommentVO> selectCommentList(@Param("bo_num")int bo_num, @Param("cri")Criteria cri);
	// 해당 게시글의 총 댓글 수 가져오기
	int selectCommentCount(@Param("bo_num")int bo_num);
	
	
}
