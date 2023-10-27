package kr.kh.final_project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.MemberVO;

public interface BoardService {

	boolean insertMapplication(BoardVO board, MemberVO user, MultipartFile[] files);

	boolean insertBapplication(BoardVO board, MemberVO user, MultipartFile[] files);
	
	// 공지게시판 가져오기
	List<BoardVO> getBoardList(Criteria cri);
	// 공지게시판 총 갯수 가져오기
	int getTotalCount(Criteria cri);
	
	// 게시글 등록하기
	boolean insertBoard(BoardVO board, MemberVO user, MultipartFile[] files);

}
