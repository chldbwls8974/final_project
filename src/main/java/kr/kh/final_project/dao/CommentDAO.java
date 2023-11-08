package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.CommentVO;
import kr.kh.final_project.vo.MemberVO;

public interface CommentDAO {
	// 댓글 등록하기
	boolean insertComment(@Param("comment")CommentVO comment);
	// 댓글 리스트 가져오기
	List<CommentVO> selectCommentList(@Param("bo_num")int bo_num, @Param("cri")Criteria cri, @Param("user")MemberVO user);
	// 해당 게시글의 총 댓글 수 가져오기
	int selectCommentCount(@Param("bo_num")int bo_num);

	// 댓글 존재확인
	CommentVO selectComment(@Param("co_num")int co_num);
	// 댓글삭제하기
	boolean deleteComment(@Param("co_num")int co_num);
	// 댓글 수정하기
	boolean updateComment(@Param("comment")CommentVO comment);
	
	// 답글 등록하기
	boolean insertComment2(@Param("comment")CommentVO comment);
	// 답글 리스트 가져오기
	List<CommentVO> selectCommentList2(@Param("bo_num")int bo_num, @Param("cri")Criteria cri);
	
}
