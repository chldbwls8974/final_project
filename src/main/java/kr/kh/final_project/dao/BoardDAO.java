package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.FileVO;

public interface BoardDAO {

	boolean insertManager(@Param("board")BoardVO board);

	void insertFile(@Param("file") FileVO fileVo);

	boolean insertBusinessman(@Param("board")BoardVO board);

	// 공지게시판글 리스트 가져오기
	List<BoardVO> selectBoardList(@Param("cri")Criteria cri);
	// 공지게시판글 총 갯수 가져오기
	int selectTotalCount(@Param("cri")Criteria cri);
	// 게시글 등록하기
	boolean insertBoard(@Param("board")BoardVO board);


}
