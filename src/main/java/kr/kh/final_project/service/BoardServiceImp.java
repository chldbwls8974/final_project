package kr.kh.final_project.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.dao.BoardDAO;
import kr.kh.final_project.dao.CommentDAO;
import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.util.UploadFileUtils;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.CommentVO;
import kr.kh.final_project.vo.FileVO;
import kr.kh.final_project.vo.MemberVO;

@Service
public class BoardServiceImp implements BoardService{
	
	@Autowired
	BoardDAO boardDao;
	
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	CommentDAO commentDao;
	
	
	String uploadPath = "D:\\uploadfiles";

	//매니저 신청
	@Override
	public boolean insertManagerApplication(BoardVO board, MemberVO user, MultipartFile[] files) {
		if(user == null || user.getMe_num() == null) {
			return false;
		}
		//세션의 회원번호를 가져와서 게시글 객체에 set함
		board.setBo_me_num(user.getMe_num());
		
		//게시글 등록을 성공하면 첨부파일 등록
		boolean res = boardDao.insertManager(board);
		if(!res) {
			return false;
		}
		//첨부파일을 서버에 업로드 하고, DB에 저장
		uploadFiles(files, board.getBo_num());
		return true;
	}
	
	//사업자 신청
	@Override
	public boolean insertBusinessmanApplication(BoardVO board, MemberVO user, MultipartFile[] files) {
		if(user == null || user.getMe_num() == null) {
			return false;
		}
		//세션의 회원번호를 가져와서 게시글 객체에 set함
		board.setBo_me_num(user.getMe_num());
		
		//게시글 등록을 성공하면 첨부파일 등록
		//DAO를 이용하여 insertBusinessman(사업자 신청 '게시글' 등록) 메서드를 불러옴
		boolean res = boardDao.insertBusinessman(board);
		if(!res) {
			return false;
		}
		uploadFiles(files, board.getBo_num());
		return true;
	}	

	//첨부파일을 업로드
	private void uploadFiles(MultipartFile[] files, int bo_num) {
		//파일이 없거나 파일 배열 길이가 0이면 return
		if(files == null || files.length == 0) {
			return;
		}
		if(bo_num <= 0) {
			return;
		}
		for(MultipartFile file : files) {
			if(file == null || file.getOriginalFilename().length() == 0) {
				continue;
			}
			try {
				String fi_ori_name = file.getOriginalFilename();
				String fi_name = UploadFileUtils.uploadFile(uploadPath, fi_ori_name, file.getBytes());
				FileVO fileVo = new FileVO(bo_num, fi_name, fi_ori_name);
				//업로드한 경로를 이용하여 다오에게 첨부파일 정보를 주면서 DB에 추가하라고 요청
				boardDao.insertFile(fileVo);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}	
	}
	
	//게시판글 리스트 가져오기
	@Override
	public List<BoardVO> getBoardList(Criteria cri) {
		return boardDao.selectBoardList(cri);
	}
	//게시판글 총 갯수 가져오기
	@Override
	public int getTotalCount(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		return boardDao.selectTotalCount(cri);
	}
	// 게시글 등록하기
	@Override
	public boolean insertBoard(BoardVO board, MemberVO user, MultipartFile[] files) {
		if(board == null || 
		   board.getBo_title() == null||
		   board.getBo_title().trim().length() == 0 ||
		   board.getBo_contents() == null) {
			return false;
		}
		// 작성자가 없으면 안됨, 로그인을 해야 등록할 수 있음
		if(user == null || user.getMe_id() == null) {
			return false;
		}
		// 게시글 작성자를 로그인한 회원 아이디로 수정해야한다.
		// memberVO에서 꺼내온 me_num을 boardVO bo_me_num을 넣어준다.
		board.setBo_me_num(user.getMe_num());
		// 다오한테 boardVO를 주면서 게시글을 등록하라하고 그걸 res에 넣는다.
		// 게시글을 DB에 저장하기
		boolean res = boardDao.insertBoard(board);
		// 결과가 false이면 false로 반환
		if(!res) {
			return false;
		}
		// 첨부파일 추가하기
		uploadFiles(files, board.getBo_num());
		return true;
	}
		
	
	// 작성된 게시글 가져오기 (게시글 상세보기)
	@Override
	public BoardVO getBoard(Integer bo_num) {
		// 매개변수 체크하기
		// 게시글 번호가 null이면 null로 return한다.
		if(bo_num == null) {
			return null;
		}
		// boardDao한테 게시글 번호를 주면서 게시글을 가져오라고 시킨다.
		BoardVO board = boardDao.selectBoard(bo_num);
		// 가져오면 반환
		return board;
	}
	// 게시글 조회수 올리기
	@Override
	public void updateViews(Integer bo_num) {
		// 매개변수 체크하기
		if(bo_num == null) {
			return;
		}
		// boardDao한테 게시글 번호를 주면서 조회수를 1증가해달라고 한다.
		boardDao.updateBoardViews(bo_num);
	}
	// 등록된 게시글 첨부파일 가져오기
	@Override
	public List<FileVO> getFileList(Integer bo_num) {
		if(bo_num == null) {
			return null;
		}
		return boardDao.selectFileList(bo_num);
	}
	
	
	//게시글 삭제하기
	@Override
	public boolean deleteBoard(Integer bo_num, MemberVO user) {
		if(user == null || user.getMe_id() == null) {
			return false;
		}
		if(bo_num == null) {
			return false;
		}
		// 게시글 번호를 부면서 삭제할 게시글 가져와서 board에다 저장
		BoardVO board = boardDao.selectBoard(bo_num);
		if(board == null || !(board.getBo_me_num() == user.getMe_num())) {
			return false;
		}
		// 첨부파일 삭제하기
		// 게시글의 모든 첨부파일들을 가져온다.
		List<FileVO> fileList = boardDao.selectFileList(bo_num);
		
		// 게시물 & 게시물에 달린 댓글들을 삭제한다.
		//List<CommentVO> commentsDelete = commentDao.deleteCommentsByBoard(bo_num);
		
		// 파일 지우기
		deleteFiles(fileList);
		
		return boardDao.deleteBoard(bo_num);
	}
		
	// 파일 삭제하기
	private void deleteFiles(List<FileVO> fileList) {
		if(fileList == null | fileList.size() == 0) {
			return;
		}
		for(FileVO file : fileList) {
			if(file == null) {
				continue;
			}
			UploadFileUtils.deleteFile(uploadPath, file.getFi_name());
			boardDao.deleteFile(file.getFi_num());
		}
	}
	// 게시글 수정하기
	@Override
	public boolean update(BoardVO board, MemberVO user,MultipartFile[] files, int[] delNums) {
		if(user == null || user.getMe_id() == null) {
			return false;
		}
		if(board == null || board.getBo_title() == null || board.getBo_title().length() == 0) {
			return false;
		}
		BoardVO dbBoard = boardDao.selectBoard(board.getBo_num());
		if(dbBoard == null || !(dbBoard.getBo_me_num() == user.getMe_num())) {
			return false;
		}
		//추가된 첨부파일 업로드 및 DB 추가
		uploadFiles(files, board.getBo_num());
		//삭제된 첨부파일 삭제 및 DB 제거
		deleteFiles2(delNums);
		boolean res = boardDao.updateBoard(board);
		return res;
	}
	private void deleteFiles2(int[] delNums) {
		if(delNums == null || delNums.length == 0) {
			return ;
		}
		List<FileVO> fileList = new ArrayList<FileVO>();
		for(int fi_num : delNums) {
			FileVO fileVo = boardDao.selectFile(fi_num);
			fileList.add(fileVo);
		}
		deleteFiles(fileList);
	}

// ===================================================================================
	
	//자유게시판 가져오기 (+공지글)
	@Override
	public List<BoardVO> getBoardFreeList(Criteria cri) {
		return boardDao.selectBoardFreeList(cri);
	}
	// 자유게시판 총갯수 가져오기
	@Override
	public int getFreeTotalCount(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		return boardDao.selectFreeTotalCount(cri);
	}
	// 자유게시판 등록하기
	@Override
	public boolean insertBoard2(BoardVO board, MemberVO user, MultipartFile[] files) {
		if(board == null || 
				   board.getBo_title() == null||
				   board.getBo_title().trim().length() == 0 ||
				   board.getBo_contents() == null) {
					return false;
				}
				// 작성자가 없으면 안됨, 로그인을 해야 등록할 수 있음
				if(user == null || user.getMe_id() == null) {
					return false;
				}
				// 게시글 작성자를 로그인한 회원 아이디로 수정해야한다.
				// memberVO에서 꺼내온 me_num을 boardVO bo_me_num을 넣어준다.
				board.setBo_me_num(user.getMe_num());
				// 다오한테 boardVO를 주면서 게시글을 등록하라하고 그걸 res에 넣는다.
				// 게시글을 DB에 저장하기
				boolean res = boardDao.insertBoard2(board);
				
				// 결과가 false이면 false로 반환
				if(!res) {
					return false;
				}
				// 첨부파일 추가하기
				uploadFiles(files, board.getBo_num());
				
				return true;
	}
// ===================================================================================
	
		// 개인매치 게시판 리스트 가져오기
		@Override
		public List<BoardVO> getBoardIndividualList(Criteria cri, BoardVO board) {
			return boardDao.selectBoardIndividualList(cri, board);
		}
		// 개인매치 게시글 총 갯수 가져오기
		@Override
		public int getIndividualTotalCount(Criteria cri, BoardVO board) {
			if(cri == null) {
				cri = new Criteria();
			}
			return boardDao.selectIndividualTotalCount(cri, board);
		}
		// 자유게시판 등록하기
		@Override
		public boolean insertBoard3(BoardVO board, MemberVO user, MultipartFile[] files) {
			if(board == null || 
			   board.getBo_title() == null||
			   board.getBo_title().trim().length() == 0 ||
			   board.getBo_contents() == null) {
				return false;
			}
			// 작성자가 없으면 안됨, 로그인을 해야 등록할 수 있음
			if(user == null || user.getMe_id() == null) {
				return false;
			}
			if(board.getBo_rg_num() == 0) {
				return false;
			}
			// 게시글 작성자를 로그인한 회원 아이디로 수정해야한다.
			// memberVO에서 꺼내온 me_num을 boardVO bo_me_num을 넣어준다.
			board.setBo_me_num(user.getMe_num());
			// 다오한테 boardVO를 주면서 게시글을 등록하라하고 그걸 res에 넣는다.
			// 게시글을 DB에 저장하기
			boolean res = boardDao.insertBoard3(board);
			
			// 결과가 false이면 false로 반환
			if(!res) {
				return false;
			}
			// 첨부파일 추가하기
			uploadFiles(files, board.getBo_num());
			
			return true;
		}
		
// ===================================================================================
	
		// 클럽매치 게시판 리스트 가져오기
		@Override
		public List<BoardVO> getBoardClubList(Criteria cri, BoardVO board) {
			return boardDao.selectBoardClubList(cri, board);
		}
		// 클럽매치 게시글 총 갯수 가져오기
		@Override
		public int getClubTotalCount(Criteria cri, BoardVO board) {
			if(cri == null) {
				cri = new Criteria();
			}
			return boardDao.selectClubTotalCount(cri, board);
		}
		// 클럽게시판 등록하기
		@Override
		public boolean insertBoard4(BoardVO board, MemberVO user, MultipartFile[] files) {
			if(board == null || 
			   board.getBo_title() == null||
			   board.getBo_title().trim().length() == 0 ||
			   board.getBo_contents() == null) {
				return false;
			}
			// 작성자가 없으면 안됨, 로그인을 해야 등록할 수 있음
			if(user == null || user.getMe_id() == null) {
				return false;
			}
			if(board.getBo_rg_num() == 0) {
				return false;
			}
			// 게시글 작성자를 로그인한 회원 아이디로 수정해야한다.
			// memberVO에서 꺼내온 me_num을 boardVO bo_me_num을 넣어준다.
			board.setBo_me_num(user.getMe_num());
			// 다오한테 boardVO를 주면서 게시글을 등록하라하고 그걸 res에 넣는다.
			// 게시글을 DB에 저장하기
			boolean res = boardDao.insertBoard4(board);
			
			// 결과가 false이면 false로 반환
			if(!res) {
				return false;
			}
			// 첨부파일 추가하기
			uploadFiles(files, board.getBo_num());
			
			return true;
		}
		
// ===================================================================================
		
	//문의게시판 가져오기
	@Override
	public List<BoardVO> getBoardInquiryList(Criteria cri, MemberVO user) {
		return boardDao.selectBoardInquiryList(cri, user);
	}
	// 문의게시판 총갯수 가져오기
	@Override
	public int getInquiryTotalCount(Criteria cri, MemberVO user) {
		if(cri == null) {
			cri = new Criteria();
		}
		return boardDao.selectInquiryTotalCount(cri, user);
	}
	// 문의게시판 등록하기
	@Override
	public boolean insertBoard5(BoardVO board, MemberVO user, MultipartFile[] files) {
		if(board == null || 
				   board.getBo_title() == null||
				   board.getBo_title().trim().length() == 0 ||
				   board.getBo_contents() == null) {
					return false;
				}
				// 작성자가 없으면 안됨, 로그인을 해야 등록할 수 있음
				if(user == null || user.getMe_id() == null) {
					return false;
				}
				// 게시글 작성자를 로그인한 회원 아이디로 수정해야한다.
				// memberVO에서 꺼내온 me_num을 boardVO bo_me_num을 넣어준다.
				board.setBo_me_num(user.getMe_num());
				// 다오한테 boardVO를 주면서 게시글을 등록하라하고 그걸 res에 넣는다.
				// 게시글을 DB에 저장하기
				boolean res = boardDao.insertBoard5(board);
				
				// 결과가 false이면 false로 반환
				if(!res) {
					return false;
				}
				// 첨부파일 추가하기
				uploadFiles(files, board.getBo_num());
				
				return true;
	}

	// ===================================================================================
	
	// 지역필터 적용 조회하기
	@Override
	public List<BoardVO> getBoardRegionList(int bo_rg_num, Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		return boardDao.selectBoardRegionList(bo_rg_num, cri);
	}

	@Override
	public int getRegionTotalCount(int bo_rg_num) {
		
		return boardDao.selectBoardRegionTotalCount(bo_rg_num);
	}



	
}
