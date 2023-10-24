package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.AccountVO;

public interface AccountDAO {

	boolean insertAccount(@Param("account")AccountVO account);

}
