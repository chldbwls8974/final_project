package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.CommentVO;

public interface CommentDAO {

	boolean insertComment(@Param("comment")CommentVO comment);


	
}
