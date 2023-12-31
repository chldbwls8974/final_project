package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.AccountVO;
import kr.kh.final_project.vo.BankVO;
import kr.kh.final_project.vo.MemberVO;

public interface AccountService {

	boolean insertAccount(AccountVO account, MemberVO user);

	boolean updateAccount(AccountVO account, MemberVO user);

	AccountVO getAccount(MemberVO user);

	List<BankVO> getBankList();

}
