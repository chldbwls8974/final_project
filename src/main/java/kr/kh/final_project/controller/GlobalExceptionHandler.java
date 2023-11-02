package kr.kh.final_project.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

@ControllerAdvice
@RestController
public class GlobalExceptionHandler {
	
	/**
	 * 그외 모든 에러는 서버에러로~
	 * @param e
	 * @return
	 */
	@ExceptionHandler(Exception.class)
	public ResponseEntity<String> handleArgumentException(Exception e) {
		String message = "서버 에러 입니다.(Exception)";
		return new ResponseEntity<String>(message, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
}