package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.FileVO;

public interface BoardDAO {

	boolean insertManager(@Param("board")BoardVO board);

	void insertFile(@Param("file") FileVO fileVo);

	boolean insertBusinessman(@Param("board")BoardVO board);



}
