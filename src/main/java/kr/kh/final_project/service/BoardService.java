package kr.kh.final_project.service;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.vo.BoardVO;
import kr.kh.final_project.vo.MemberVO;

public interface BoardService {

	boolean insertApplication(BoardVO board, MemberVO user, MultipartFile[] files);

}
