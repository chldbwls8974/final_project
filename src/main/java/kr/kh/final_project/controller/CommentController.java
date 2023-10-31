package kr.kh.final_project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

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

	
}
	

