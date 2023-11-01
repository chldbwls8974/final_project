package kr.kh.final_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.pagination.PageMaker;
import kr.kh.final_project.service.CommentService;
import kr.kh.final_project.vo.CommentVO;

@RestController
public class CommentController {
	
	@Autowired
	CommentService commentService;
	
	//댓글 추가하기
	// 클라이언트로부터 전송된 JSON형식의 데이터를 받아서 댓글을 추가
	@ResponseBody
	@PostMapping("/comment/insert")
	// 받은 JSON형식의 데이터를 CommentVO로 변환
	public Map<String,Object> commentInsert(@RequestBody CommentVO comment){
		// JSON 응답을 위한 빈 Map 객체를 생성한다. 이 Map에 데이터를 추가하여 클라이언트에 전달
		System.out.println(comment);
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = commentService.insertComment(comment);
		map.put("res", res);
		return map;
	}
	
	// 댓글 조회하기
	// @RespenseBody : 직렬로 클라이언트로 전송하는 역할
	@ResponseBody
	@PostMapping("/comment/list/{bo_num}")
	public Map<String, Object> list(@RequestBody Criteria cri, @PathVariable("bo_num")int bo_num){
		Map<String, Object> map = new HashMap<String, Object>();
		// 페이지당 항목수 5개로 잡음
		cri.setPerPageNum(5);
		List<CommentVO> list = commentService.getCommentList(bo_num, cri);
		// 이 게시글의 총 댓글 갯수를 가져와라
		int totalCount = commentService.getTotalCount(bo_num);
		PageMaker pm = new PageMaker(3, cri, totalCount);
		map.put("list", list);
		map.put("pm", pm);
		return map;
	}
}
	

