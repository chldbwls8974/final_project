package kr.kh.final_project.dao;

import java.util.List;

import kr.kh.final_project.vo.ExpenseVO;

public interface ExpenseDAO {

	List<ExpenseVO> selectPriceList();

}