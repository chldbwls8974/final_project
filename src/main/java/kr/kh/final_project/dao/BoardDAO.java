package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.FileVO;
import kr.kh.final_project.vo.ManagerVO;
import kr.kh.final_project.vo.MemberVO;

public interface BoardDAO {

	//매니저 신청 게시글등록
	boolean insertManager(@Param("board")BoardVO board);
	
	//첨부파일 등록
	void insertFile(@Param("file") FileVO fileVo);

	//사업자 신청 게시글등록	
	boolean insertBusinessman(@Param("board")BoardVO board);

	// 게시판글 리스트 가져오기
	List<BoardVO> selectBoardList(@Param("cri")Criteria cri);
	// 게시판글 총 갯수 가져오기
	int selectTotalCount(@Param("cri")Criteria cri);
	// 게시글 등록하기
	boolean insertBoard(@Param("board")BoardVO board);
	// 게시글 첨부파일
	//void insertFileByNotice(@Param("file") FileVO fileVo);

	// 게시글 상세내용 불러오기
	BoardVO selectBoard(@Param("bo_num")Integer bo_num);
	// 게시글 상세내용 첨부파일 불러오기
	List<FileVO> selectFileList(@Param("bo_num")Integer bo_num);
	// 게시글 조회수 올리기
	void updateBoardViews(@Param("bo_num")Integer bo_num);
	// 게시글 삭제하기
	boolean deleteBoard(@Param("bo_num")Integer bo_num);
	// 게시글 파일삭제하기
	void deleteFile(@Param("fi_num")int fi_num);
	// 게시글 삭제할 때 댓글도 같이 삭제하기
	//boolean deleteCommentsByBoard(@Param("bo_num")Integer bo_num);
	
	
	// 공지게시글 수정하기
	//boolean updateBoard(@Param("board")BoardVO board);
	// 공지게시글 상세페이지 첨부파일 가져오기
	//FileVO selectFile(@Param("fi_num")Integer num);
	// 게시글 수정하기
	boolean updateBoard(@Param("board")BoardVO board);
	// 게시글 상세페이지 첨부파일 가져오기
	FileVO selectFile(@Param("fi_num")int fi_num);
	
	// 게시글 댓글 수 업데이트하기
	void updateBoardComment(@Param("bo_num")int co_bo_num);
	// 답글 댓글 수 업데이트하기
	void updateBoardComment2(@Param("bo_num")int co_bo_num);
	
	// 자유게시판 리스트 가져오기 (+공지글)
	List<BoardVO> selectBoardFreeList(@Param("cri")Criteria cri);
	// 자유게시판 총 갯수 가져오기 (+공지글)
	int selectFreeTotalCount(@Param("cri")Criteria cri);
	// 자유게시판 등록하기
	boolean insertBoard2(@Param("board")BoardVO board);

	// 개인매치 리스트 가져오기 ( +공지글 )
	List<BoardVO> selectBoardIndividualList(@Param("cri")Criteria cri, @Param("board")BoardVO board);
	// 개인매치 리스트 총 갯수 가져오기 ( +공지글 )
	int selectIndividualTotalCount(@Param("cri")Criteria cri, @Param("board")BoardVO board);
	// 개인매치 게시판 등록하기
	boolean insertBoard3(@Param("board")BoardVO board);
	
	// 클럽매치 리스트 가져오기 ( +공지글 )
	List<BoardVO> selectBoardClubList(@Param("cri")Criteria cri,  @Param("board")BoardVO board);
	// 클럽매치 리스트 총 갯수 가져오기 ( +공지글 )
	int selectClubTotalCount(@Param("cri")Criteria cri, @Param("board")BoardVO board);
	// 클럽매치 게시판 등록하기
	boolean insertBoard4(@Param("board")BoardVO board);
	
	// 문의게시판 리스트 가져오기
	List<BoardVO> selectBoardInquiryList(@Param("cri")Criteria cri, @Param("user")MemberVO user);
	// 문의게시판 총 갯수 가져오기
	int selectInquiryTotalCount(@Param("cri")Criteria cri, @Param("user")MemberVO user);
	// 문의게시판 등록하기
	boolean insertBoard5(@Param("board")BoardVO board);

	// 지역필터 리스트 가져오기
	List<BoardVO> selectBoardRegionList(@Param("bo_num")int bo_num,@Param("cri") Criteria cri);
	// 지역게시판 총 갯수 가져오기
	int selectBoardRegionTotalCount(@Param("bo_num")int bo_rg_num);
	
	
	// 매니저신청 게시글 가져오기
	ManagerVO selectBoardManager(@Param("manager")ManagerVO manager, @Param("user")ManagerVO user);
	// 매니저신청 게시글 삭제하기
	boolean deleteBoardManager(@Param("manager")ManagerVO manager, @Param("user")ManagerVO user);
	
	

	
	
	
	
	

	
	
	


}
