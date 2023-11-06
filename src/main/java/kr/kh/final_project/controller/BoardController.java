package kr.kh.final_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.BoardService;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.CommentVO;
import kr.kh.final_project.vo.FileVO;
import kr.kh.final_project.vo.MemberVO;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	// 공지게시판 조회하기 & 페이지네이션 (1)
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
		System.out.println(board);
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
	/*
	 * // 상세페이지 댓글 프로필사진 가져오기
	 * 
	 * @RequestMapping("/board/detail") public String boardComment(Model model,
	 * MemberVO member) {
	 * 
	 * List<MemberVO> list = boardService.getUser(member);
	 * 
	 * model.addAttribute("list", list); return "/board/detail"; }
	 */

	// 게시글 수정하기 화면 조회하기
	@GetMapping("/board/update")
	public String boardUpdate(Model model, Integer bo_num) {
		// 서비스에게 게시글 번호를 주면서 게시글을 가져오라고 시킴
		BoardVO board = boardService.getBoard(bo_num);
		List<FileVO> fileList = boardService.getFileList(bo_num);
		
		// 가져온 게시글을 화면에 전송
		model.addAttribute("board", board);
		model.addAttribute("fileList", fileList);
		return "/board/update";
	}
	// 게시글 수정하기
	@PostMapping("/board/update")
	public String boardUpdatePost(Model model, BoardVO board, HttpSession session,MultipartFile[] files, int [] delNums ) {
		// 로그인한 회원정보를 user에 저장
		MemberVO user = (MemberVO)session.getAttribute("user");
		// 게시글 정보, 로그인한 사용자정보, 새로 업로드된 파일, 삭제할 파일 정보 res에 저장
		boolean res = boardService.update(board, user, files, delNums);
		if(res) {
			model.addAttribute("msg", "게시글을 수정했습니다.");
		}else {
			model.addAttribute("msg", "게시글을 수정하지 못했습니다.");
		}
		model.addAttribute("url", "/board/detail?bo_num="+board.getBo_num());
		return "/util/message";
	}
	
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

	// ===================================================================================
	
	// 자유게시판 조회하기 (2)
	@GetMapping("/board/free")
	public String boardFree(Model model, Criteria cri) {
		// 페이지네이션
		cri.setPerPageNum(10);
		int totalCount = boardService.getFreeTotalCount(cri);
		final int DISPLAY_PAGE_NUM = 3;
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		// 자유게시판 조회하기
		List<BoardVO> list = boardService.getBoardFreeList(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pm", pm);
		return "/board/free";
	}
	// 게시글쓰기 조회하기
	@GetMapping("/board/insert2")
	public String boardInsert2() {
		return "/board/insert2";
	}
	// 게시글 등록하기 (첨부파일이랑 같이)
	@PostMapping("/board/insert2")
	public String boardInsert2(Model model, 
							  BoardVO board, 
							  HttpSession session,
							  MultipartFile[] files) {
		// 게시글을 쓰고 있는 user에 대한 정보를 memberVO에서 가져와 user에 저장한다.
		MemberVO user = (MemberVO)session.getAttribute("user");
		// boardService한테 board와 user, files정보를 주며 저장하라고 시킴 그걸 res에 저장하기
		boolean res = boardService.insertBoard2(board, user, files);
		// 만약 결과가 true이면
		if(res) {
			model.addAttribute("msg", "게시글 등록 성공!");
			model.addAttribute("url", "/board/free");
		}else{
			model.addAttribute("msg", "게시글 등록 실패!");
			model.addAttribute("url", "/board/insert2");
		}
		return "/util/message";
	}
	// ===================================================================================
	
	// 개인매치 게시판 조회하기 (3)
	@GetMapping("/board/individual")
	public String boardIndividual (Model model, Criteria cri, BoardVO board ) {
		// 페이지네이션
		cri.setPerPageNum(10);
		int totalCount = boardService.getIndividualTotalCount(cri, board);
		final int DISPLAY_PAGE_NUM = 3;
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		// 자유게시판 조회하기 (매개변수 board추가)
		List<BoardVO> list = boardService.getBoardIndividualList(cri, board);
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pm", pm);
		return "/board/individual";
	}
	// 게시글쓰기 조회하기
		@GetMapping("/board/insert3")
		public String boardInsert3() {
			return "/board/insert3";
		}
		// 게시글 등록하기 (첨부파일이랑 같이) (3)
		@PostMapping("/board/insert3")
		public String boardInsert3(Model model, 
								  BoardVO board, 
								  HttpSession session,
								  MultipartFile[] files) {
			// 게시글을 쓰고 있는 user에 대한 정보를 memberVO에서 가져와 user에 저장한다.
			MemberVO user = (MemberVO)session.getAttribute("user");
			// boardService한테 board와 user, files정보를 주며 저장하라고 시킴 그걸 res에 저장하기
			boolean res = boardService.insertBoard3(board, user, files);
			// 만약 결과가 true이면
			if(res) {
				model.addAttribute("msg", "게시글 등록 성공!");
				model.addAttribute("url", "/board/individual");
			}else{
				model.addAttribute("msg", "게시글 등록 실패!");
				model.addAttribute("url", "/board/insert3");
			}
			return "/util/message";
		}
// ===================================================================================

		
	// 클럽매치 게시판 조회하기 (4)
	@GetMapping("/board/club")
	public String boardClub (Model model, Criteria cri, BoardVO board) {
		// 페이지네이션
		cri.setPerPageNum(10);
		int totalCount = boardService.getClubTotalCount(cri, board);
		final int DISPLAY_PAGE_NUM = 3;
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		// 자유게시판 조회하기
		List<BoardVO> list = boardService.getBoardClubList(cri, board);
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pm", pm);
		return "/board/club";
	}
	// 게시글쓰기 조회하기
		@GetMapping("/board/insert4")
		public String boardInsert4() {
			return "/board/insert4";
		}
		// 게시글 등록하기 (첨부파일이랑 같이) (3)
		@PostMapping("/board/insert4")
		public String boardInsert4(Model model, 
								  BoardVO board, 
								  HttpSession session,
								  MultipartFile[] files) {
			// 게시글을 쓰고 있는 user에 대한 정보를 memberVO에서 가져와 user에 저장한다.
			MemberVO user = (MemberVO)session.getAttribute("user");
			// boardService한테 board와 user, files정보를 주며 저장하라고 시킴 그걸 res에 저장하기
			boolean res = boardService.insertBoard4(board, user, files);
			// 만약 결과가 true이면
			if(res) {
				model.addAttribute("msg", "게시글 등록 성공!");
				model.addAttribute("url", "/board/club");
			}else{
				model.addAttribute("msg", "게시글 등록 실패!");
				model.addAttribute("url", "/board/insert4");
			}
			return "/util/message";
		}
		
		
// ===================================================================================	
		
		
	// 문의게시판 조회하기 (5)
	@GetMapping("/board/inquiry")
	public String boardInquiry(Model model, Criteria cri) {
		// 페이지네이션
		cri.setPerPageNum(5);
		int totalCount = boardService.getInquiryTotalCount(cri);
		final int DISPLAY_PAGE_NUM = 3;
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		// 문의게시판 조회하기
		List<BoardVO> list = boardService.getBoardInquiryList(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pm", pm);
		
		return "/board/inquiry";
	}
	// 게시글쓰기 조회하기
		@GetMapping("/board/insert5")
		public String boardInsert5() {
			return "/board/insert5";
		}
	// 게시글 등록하기 (첨부파일이랑 같이)
	@PostMapping("/board/insert5")
	public String boardInsert5(Model model, 
							  BoardVO board, 
							  HttpSession session,
							  MultipartFile[] files) {
		// 게시글을 쓰고 있는 user에 대한 정보를 memberVO에서 가져와 user에 저장한다.
		MemberVO user = (MemberVO)session.getAttribute("user");
		// boardService한테 board와 user, files정보를 주며 저장하라고 시킴 그걸 res에 저장하기
		boolean res = boardService.insertBoard5(board, user, files);
		// 만약 결과가 true이면
		if(res) {
			model.addAttribute("msg", "게시글 등록 성공!");
			model.addAttribute("url", "/board/inquiry");
		}else{
			model.addAttribute("msg", "게시글 등록 실패!");
			model.addAttribute("url", "/board/insert5");
		}
		return "/util/message";
	}

	
//===================================================================================	
	
// 필터 적용하기 (조회하기)
@ResponseBody
@PostMapping("/board/list")
public Map<String, Object> list(@RequestBody Criteria cri, int bo_rg_num){
	Map<String, Object> map = new HashMap<String, Object>();
	// 페이지당 항목수 10개로 잡음
	cri.setPerPageNum(10);
	List<BoardVO> list = boardService.getBoardRegionList(bo_rg_num, cri);
	// 이 게시글의 총 게시글 갯수를 가져와라
	int totalCount = boardService.getRegionTotalCount(bo_rg_num);
	PageMaker pm = new PageMaker(3, cri, totalCount);
	map.put("list", list);
	map.put("pm", pm);
	return map;
	}
}
