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
import kr.kh.final_project.vo.BoardVO;
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
	// 게시글 등록하기 
	@PostMapping("/board/insert")
	public String boardInsert(Model model, 
							  BoardVO board, 
							  HttpSession session,
							  MultipartFile[] files) {
		// 게시글을 쓰고 있는 user에 대한 정보를 memberVO에서 가져와 user에 저장한다.
		MemberVO user = (MemberVO)session.getAttribute("user");
		// boardService한테 board와 user, fileList정보를 주며 저장하라고 시킴 그걸 res에 저장하기
		boolean res = boardService.insertBoard(board, user, files);
		// 만약 결과가 true이면
		System.out.println(board);
		if(res) {
			model.addAttribute("msg", "게시글 등록 성공!");
			model.addAttribute("url", "/board/list");
		}else{
			model.addAttribute("msg", "게시글 등록 실패!");
			model.addAttribute("url", "/board/insert");
		}
		return "/util/message";
	}
}
	

