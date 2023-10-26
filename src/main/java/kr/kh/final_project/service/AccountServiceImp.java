package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.AccountDAO;
import kr.kh.final_project.dao.BankDAO;
import kr.kh.final_project.vo.AccountVO;
import kr.kh.final_project.vo.BankVO;
import kr.kh.final_project.vo.MemberVO;

@Service
public class AccountServiceImp implements AccountService {

	@Autowired
	AccountDAO accountDao;
	@Autowired
	BankDAO bankDao;
	
	@Override
	public boolean insertAccount(AccountVO account, MemberVO user) {
		//null값 예외 처리
		if(user == null ||
			account == null ||
			account.getAc_ba_name() == null ||
			account.getAc_me_name() == null ||
			account.getAc_num() == null) {
			return false;
		}
		//회원 이름과 예금주명이 다르면 false
		if(!user.getMe_name().equals(account.getAc_me_name())) {
			return false;
		}
		
		return accountDao.insertAccount(account);
	}

	@Override
	public boolean updateAccount(AccountVO account, MemberVO user) {
		//null값 예외 처리
		if(user == null ||
			account == null ||
			account.getAc_ba_name() == null ||
			account.getAc_me_name() == null ||
			account.getAc_num() == null) {
			return false;
		}
		//회원 이름과 예금주명이 다르면 false
		if(!user.getMe_name().equals(account.getAc_me_name())) {
			return false;
		}
		return accountDao.updateAccount(account);
	}
	

	@Override
	public AccountVO getAccount(MemberVO user) {
		return accountDao.selectAccount(user.getMe_num());
	}

	@Override
	public List<BankVO> getBankList() {
		return bankDao.selectBankList();
	}
}
