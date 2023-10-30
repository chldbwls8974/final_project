package kr.kh.final_project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.BoardService;
import kr.kh.final_project.util.Message;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.FileVO;
import kr.kh.final_project.vo.MemberVO;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	// 공지게시판 조회하기 & 페이지네이션
	@GetMapping("/board/notice")
	public String boardNotice(Model model, Criteria cri) {
		
		// 페이지네이션
		cri.setPerPageNum(5);
		int totalCount = boardService.getTotalCount(cri);
		final int DISPLAY_PAGE_NUM = 3;
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		// 공지게시판 조회하기
		List<BoardVO> list = boardService.getBoardList(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pm", pm);
		return"/board/notice";
	}
	
	// 게시글쓰기 조회하기
	@GetMapping("/board/insert")
	public String boardInsert() {
		return "/board/insert";
	}
	// 게시글 등록하기 (첨부파일이랑 같이)
	@PostMapping("/board/insert")
	public String boardInsert(Model model, 
							  BoardVO board, 
							  HttpSession session,
							  MultipartFile[] files) {
		// 게시글을 쓰고 있는 user에 대한 정보를 memberVO에서 가져와 user에 저장한다.
		MemberVO user = (MemberVO)session.getAttribute("user");
		// boardService한테 board와 user, files정보를 주며 저장하라고 시킴 그걸 res에 저장하기
		boolean res = boardService.insertBoard(board, user, files);
		// 만약 결과가 true이면
		if(res) {
			model.addAttribute("msg", "게시글 등록 성공!");
			model.addAttribute("url", "/board/notice");
		}else{
			model.addAttribute("msg", "게시글 등록 실패!");
			model.addAttribute("url", "/board/insert");
		}
		return "/util/message";
	}
	
	//게시글 상세조회하기
	@GetMapping("/board/detail")
	public String boardDetail(Model model,  Integer bo_num) {
		// 게시글을 가져오기 전에 서비스에게 게시글 번호를 주면서 조회수를 1증가하라고 요청한다.
		boardService.updateViews(bo_num);
		// 서비스에게 게시글 번호를 주면서 게시글을 가져오라고 시킨다.
		BoardVO board = boardService.getBoard(bo_num);
		// 등록된 첨부파일을 가져오라고 boardService한테 시키고 가져온 첨부파일을 fileList에 넣기
		List<FileVO> fileList = boardService.getFileList(bo_num);
		
		
		// 가져온 게시글을 화면에 전송해준다.
		model.addAttribute("board", board);
		model.addAttribute("fileList", fileList);
		return "/board/detail";
	}

	// 게시글 수정하기 화면 조회하기
	@GetMapping("/board/update")
	public String boardUpdate(Model model, Integer bo_num) {
		
		// 서비스에게 게시글 번호를 주면서 게시글을 가져오라고 시킴
		BoardVO board = boardService.getBoard(bo_num);
		// 가져온 게시글을 화면에 전송
		model.addAttribute("board", board);
		return "/board/update";
	}
	/*
	 * @PostMapping("/board/update") public String updatePost(Model model, BoardVO
	 * board, MultipartFile[] files, Integer[] delFiles, HttpSession session) {
	 * Message msg; MemberVO user = (MemberVO)session.getAttribute("user");
	 * if(boardService.updateBoard(board, files, delFiles,user)) { msg = new
	 * Message("/board/detail?bo_num="+board.getBo_num(), "게시글을 수정했습니다."); }else {
	 * msg = new Message("/board/update?bo_num="+board.getBo_num(),
	 * "게시글을 수정하지 못했습니다."); } model.addAttribute("msg", msg); return "message"; }
	 */
	
	//게시글 삭제하기
	@GetMapping("/board/delete")
	public String boardDelete(Model model, HttpSession session, Integer bo_num) {
		// memberVO에서 지금 로그인하고 있는 user의 정보를 가져와 user에 저장한다.
		// 작성한 자신의 글만 삭제하기 위해서
		MemberVO user = (MemberVO)session.getAttribute("user");
		// boardService한테 로그인한 user와 게시글 번호를 주면 삭제하라고 시킨 것을 res에 담는다.
		boolean res = boardService.deleteBoard(bo_num, user);
		// 만약 res가 true면 안내문구 출력
		if(res) {
			model.addAttribute("msg", "게시글을 삭제하였습니다.");
		}else {
			model.addAttribute("msg", "게시글을 삭제실패하였습니다.");
		}
		
		model.addAttribute("url", "/board/notice");
		return "/util/message";
	}
	
	
}
	

