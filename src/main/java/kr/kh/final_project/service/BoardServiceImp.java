package kr.kh.final_project.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.dao.BoardDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.util.UploadFileUtils;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.FileVO;
import kr.kh.final_project.vo.MemberVO;

@Service
public class BoardServiceImp implements BoardService{
	
	@Autowired
	BoardDAO boardDao;
	
	String uploadPath = "D:\\uploadfiles";


	@Override
	public boolean insertMapplication(BoardVO board, MemberVO user, MultipartFile[] files) {
		//user 혹은 회원번호 객체가 null일 경우 false로 반환
		if(user == null || user.getMe_num() == null) {
			return false;
		}
		//세션의 회원번호를 가져와서 게시글 객체에 set함
		board.setBo_me_num(user.getMe_num());
		
		//게시글 등록을 성공하면 첨부파일 등록
		//DAO를 이용하여 insertManager(매니저 신청 '게시글' 등록) 메서드를 불러옴
		boolean res = boardDao.insertManager(board);
		if(!res) {
			return false;
		}
		//첨부파일을 서버에 업로드 하고, DB에 저장
		uploadFiles(files, board.getBo_num());
		return true;
	}

	@Override
	public boolean insertBapplication(BoardVO board, MemberVO user, MultipartFile[] files) {
		//user 혹은 회원번호 객체가 null일 경우 false로 반환
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
		//첨부파일을 서버에 업로드 하고, DB에 저장
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
	//공지게시판글 총 갯수 가져오기
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
		// 작성자가 없으면 안됨
		if(user == null) {
			return false;
		}
		// 게시글 작성자를 로그인한 회원 아이디로 수정해야한다.
		// memberVO에서 꺼내온 me_num을 boardVO bo_me_num을 넣어준다.
		board.setBo_me_num(user.getMe_num());
		// 게시글을 DB에 저장하기
		boolean res = boardDao.insertBoard(board);
		
		if(!res) {
			return false;
		}
		// 첨부파일 등록하기
		if(files == null || files.length == 0) {
			return true;
		}
		// 내가 올린 파일들을 file에 저장
		for(MultipartFile file : files) {
			// 업로드한 파일이 없어도 계속진행
			if(file == null || file.getOriginalFilename().length() == 0) {
				continue;
			}
			try {
				//원래 파일명
				String fi_ori_name = file.getOriginalFilename();
				// 서버에 업로드 후 업로드된 경로와 uuid가 포함된 파일명
				String fi_name = UploadFileUtils.uploadFile(uploadPath, fi_ori_name, file.getBytes());
				//파일 객체
				//FileVO fileVo = new FileVO(board.getBo_num(), fi_name, fi_ori_name);
				//업로드한 경로를 이용하여 다오에게 첨부파일 정보를 주면서 DB에 추가하라고 요청
				//boardDao.insertFile(fileVo);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

}
