package kr.kh.final_project.service;

import kr.kh.final_project.vo.AccountVO;
import kr.kh.final_project.vo.MemberVO;

public interface AccountService {

	boolean insertAccount(AccountVO account, MemberVO user);

}
