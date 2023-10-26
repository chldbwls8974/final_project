package kr.kh.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.BoardService;
import kr.kh.final_project.vo.BoardVO;

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
	
	//게시글쓰기 조회하기, 글쓰기 등록하기
	@GetMapping("/board/insert")
	public String boardInsert(Model model) {
		
		return "/board/insert";
	}
}
	

