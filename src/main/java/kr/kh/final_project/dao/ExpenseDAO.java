package kr.kh.final_project.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.ExpenseVO;

public interface ExpenseDAO {

	List<ExpenseVO> selectExpense();

	void updatePrice(@Param("ex_num")int count,@Param("ex_pre") int i, @Param("ex_date")String date);


}