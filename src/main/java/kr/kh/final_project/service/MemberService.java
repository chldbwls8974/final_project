package kr.kh.final_project.service;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;

public interface MemberService {

	MemberVO userById(String name);

	boolean applyManager(MemberVO member, MemberVO user, MultipartFile[] files);

	boolean signup(MemberVO member);

	MemberVO getMember(String me_id);

	boolean pointRefundApply(MemberVO user, PointHistoryVO pointHistory);


}
