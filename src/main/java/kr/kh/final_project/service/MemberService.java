package kr.kh.final_project.service;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.vo.MemberVO;

public interface MemberService {

	boolean applyManager(MemberVO member, MemberVO user, MultipartFile[] files);



}
