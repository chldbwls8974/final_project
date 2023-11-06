package kr.kh.final_project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.FileVO;
import kr.kh.final_project.vo.MemberVO;

public interface BoardService {

	//매니저 신청
	boolean insertManagerApplication(BoardVO board, MemberVO user, MultipartFile[] files);
	
	//사업자 신청
	boolean insertBusinessmanApplication(BoardVO board, MemberVO user, MultipartFile[] files);
	
	// 공지게시판 가져오기
	List<BoardVO> getBoardList(Criteria cri);
	// 공지게시판 총 갯수 가져오기
	int getTotalCount(Criteria cri);
	
	// 게시글 등록하기
	boolean insertBoard(BoardVO board, MemberVO user, MultipartFile[] files);
	// 게시글 조회수올리기
	void updateViews(Integer bo_num);
	
	// 작성된 게시글 가져오기 (상세글 가져오기)
	BoardVO getBoard(Integer bo_num);
	// 게시글 상세보기에 첨부된 첨부파일 가져오기
	List<FileVO> getFileList(Integer bo_num);
	// 게시글 수정하기
	//boolean updateBoard(BoardVO board, MultipartFile[] files, Integer[] delFiles, MemberVO user);
	// 게시글 삭제하기
	boolean deleteBoard(Integer bo_num, MemberVO user);
	// 게시글 수정하기
	boolean update(BoardVO board, MemberVO user, MultipartFile[] files, int[] delNums);
	
	// 자유게시판 리스트 가져오기 ( +공지게시판과 같이 )
	List<BoardVO> getBoardFreeList(Criteria cri);
	// 자유게시판 총 갯수 가져오기( +공지게시판과 같이)
	int getFreeTotalCount(Criteria cri);
	// 자유게시판 등록하기
	boolean insertBoard2(BoardVO board, MemberVO user, MultipartFile[] files);

	// 개인매치 게시판 리스트 가져오기 ( + 공지게시판과 같이 )
	List<BoardVO> getBoardIndividualList(Criteria cri, BoardVO board);
	// 개인매치 게시판 총 갯수 가져오기 ( + 공지게시판과 같이 )
	int getIndividualTotalCount(Criteria cri, BoardVO board);
	// 개인매치 게시판 등록하기
	boolean insertBoard3(BoardVO board, MemberVO user, MultipartFile[] files);
	
	// 클럽매치 게시판 리스트 가져오기 ( +공지게시판과 같이 )
	List<BoardVO> getBoardClubList(Criteria cri, BoardVO board);
	// 클럽매치 게시판 총 갯수 가져오기 ( +공지게시판과 같이 )
	int getClubTotalCount(Criteria cri, BoardVO board);
	// 클럽매치 게시판 등록하기
	boolean insertBoard4(BoardVO board, MemberVO user, MultipartFile[] files);
	
	// 문의게시판 리스트 가져오기
	List<BoardVO> getBoardInquiryList(Criteria cri);
	// 문의게시판 총 갯수 가져오기
	int getInquiryTotalCount(Criteria cri);
	// 문의게시판 등록하기
	boolean insertBoard5(BoardVO board, MemberVO user, MultipartFile[] files);


	// 지역필터 조회하기
	List<BoardVO> getBoardRegionList(int bo_rg_num, Criteria cri);
	// 지역 필터 게시글 총 갯수 가져오기
	int getRegionTotalCount(int bo_rg_num);
	
	
	


}
