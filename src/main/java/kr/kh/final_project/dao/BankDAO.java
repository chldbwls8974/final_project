package kr.kh.final_project.dao;

import java.util.List;

import kr.kh.final_project.vo.BankVO;

public interface BankDAO {

	List<BankVO> selectBankList();

}
