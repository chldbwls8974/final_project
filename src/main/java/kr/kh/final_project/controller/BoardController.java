package kr.kh.final_project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.BlockService;
import kr.kh.final_project.service.BoardService;
import kr.kh.final_project.vo.BlockVO;
import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.FileVO;
import kr.kh.final_project.vo.MemberVO;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	BlockService blockService;
	
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
			model.addAttribute("msg", "게시글을 삭제 실패하였습니다.");
		}
		// 사용자가 이전에 보고 있던 페이지로 리다이렉트
		// user정보를 가져왔던거 처럼 preBoard로 이전에 있던 위치를 session으로 가져온다.
		String preBoard = (String)session.getAttribute("preBoard");
		// 이전에 위치가 null이 아니거나 이전위치가 empty가 아닐 때를 redirectUrl에 저장하기
		String redirectUrl = (preBoard != null && !preBoard.isEmpty()? "/board/"+preBoard : "/");
		
		model.addAttribute("url", redirectUrl);
		return "/util/message";
	}

	// ===================================================================================
	
	// 자유게시판 조회하기 (2)
	@GetMapping("/board/free")
	public String boardFree(Model model, Criteria cri, HttpSession session) {
		// 페이지네이션
		cri.setPerPageNum(10);
		int totalCount = boardService.getFreeTotalCount(cri);
		final int DISPLAY_PAGE_NUM = 3;
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		
		//현재 로그인한 사용자 정보 가져오기
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		// 현재 로그인한 사람이 null이 아니라면
		if( user != null ) {
			// 차단 목록 list로 가져오기 (여러명일 수 있으므로 list로 가져온다.)
			List<BlockVO> blockList = blockService.getBlockList(user.getMe_num());
			
			List<Integer>blockedUserIds = new ArrayList<Integer>();
			
			for(BlockVO block : blockList) {
				blockedUserIds.add(block.getBl_blocked_num());
			}	
			// 자유게시판 리스트를 가져오라고 boardService에게 시킨다.
			List<BoardVO> list = boardService.getBoardFreeList(cri);
			
			// 차단된 사용자의 게시글을 필터링해준다.
			List<BoardVO> filteredList = new ArrayList<BoardVO>();
			for(BoardVO board : list) {
				if(!blockedUserIds.contains(board.getBo_me_num())) {
					filteredList.add(board);
				}
			}
			model.addAttribute("list" , filteredList);// 필터링된 게시글 리스트를 모델에 추가
		}else {
			// 로그인 되지 않은 경우 모든 게시글을 표시해준다.
			// 자유게시판 조회하기
			List<BoardVO>list = boardService.getBoardFreeList(cri);
			model.addAttribute("list", list); // 모든 게시글을 모델에 추가
		}
		model.addAttribute("cri", cri); // 페이지 정보를 모델에 추가
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
	public String boardIndividual (Model model, Criteria cri, BoardVO board, HttpSession session ) {
		// 페이지네이션
		cri.setPerPageNum(10);
		int totalCount = boardService.getIndividualTotalCount(cri, board);
		final int DISPLAY_PAGE_NUM = 3;
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		
		// 현재 로그인한 사용자 정보를 가져온다.
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		// 현재 로그인한 사람이 null이 아니라면 
		if( user != null ) {
			// 차단 목록을 list로 가져오라고 blockService한테 시킨다. (여러명일 수 있으므로 list로 가져온다.)
			List<BlockVO> blockList = blockService.getBlockList(user.getMe_num());
			// 차단된 아이디 들을 list로 만들어준다. me_num은 정수이므로 Integer로 list를 만든다.
			List<Integer>blockedUserIds = new ArrayList<Integer>();
			
			// blockList의 각항목을 순회 하면서 blockVO의 객체(block)에서 bl_blocked_num값(차단된 me_num)을
			// 가져와서 blockedUserIds리스트에 추가해준다.
			for(BlockVO block : blockList) {
				blockedUserIds.add(block.getBl_blocked_num());
				}
			// 차단된 회원의 정보를 blockedUserIds에 저장한 후
			// 개인매치게시글 리스트를 가져오라고 서비스에게 시킨다.
			List<BoardVO> list = boardService.getBoardIndividualList(cri, board);
			
			// 차단된 사용자의 게시글을 필터링 해준다.
			// 필터링된 리스트를 만들어준다.
			List<BoardVO> filteredList = new ArrayList<BoardVO>();
			for(BoardVO board1 : list) {
				if(!blockedUserIds.contains(board1.getBo_me_num())) {
					filteredList.add(board1);
				}
			}
			model.addAttribute("list", filteredList);
		}else{
		// 자유게시판 조회하기 (매개변수 board추가)
			List<BoardVO> list = boardService.getBoardIndividualList(cri, board);
			model.addAttribute("list", list);		
		}
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
	public String boardClub (Model model, Criteria cri, BoardVO board, HttpSession session) {
		// 페이지네이션
		cri.setPerPageNum(10);
		int totalCount = boardService.getClubTotalCount(cri, board);
		final int DISPLAY_PAGE_NUM = 3;
		PageMaker pm = new PageMaker(DISPLAY_PAGE_NUM, cri, totalCount);
		
		// 현재 로그인한 사용자 정보를 가져온다.
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		// 현재 로그인한 사람이 null이 아니라면 
		if( user != null ) {
			// 차단 목록을 list로 가져오라고 blockService한테 시킨다. (여러명일 수 있으므로 list로 가져온다.)
			List<BlockVO> blockList = blockService.getBlockList(user.getMe_num());
			// 차단된 아이디 들을 list로 만들어준다. me_num은 정수이므로 Integer로 list를 만든다.
			List<Integer>blockedUserIds = new ArrayList<Integer>();
			
			// blockList의 각항목을 순회 하면서 blockVO의 객체(block)에서 bl_blocked_num값(차단된 me_num)을
			// 가져와서 blockedUserIds리스트에 추가해준다.
			for(BlockVO block : blockList) {
				blockedUserIds.add(block.getBl_blocked_num());
				}
			// 차단된 회원의 정보를 blockedUserIds에 저장한 후
			// 개인매치게시글 리스트를 가져오라고 서비스에게 시킨다.
			List<BoardVO> list = boardService.getBoardIndividualList(cri, board);
			
			// 차단된 사용자의 게시글을 필터링 해준다.
			// 필터링된 리스트를 만들어준다.
			List<BoardVO> filteredList = new ArrayList<BoardVO>();
			for(BoardVO board1 : list) {
				if(!blockedUserIds.contains(board1.getBo_me_num())) {
					filteredList.add(board1);
				}
			}
			model.addAttribute("list", filteredList);
		}else{
		// 자유게시판 조회하기 (매개변수 board추가)
			List<BoardVO> list = boardService.getBoardIndividualList(cri, board);
			model.addAttribute("list", list);		
		}
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
