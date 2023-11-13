package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.OperatingVO;

public interface OperatingDAO {

	List<OperatingVO> selectOperatingListByFaNum(@Param("fa_num")int fa_num);

	boolean insertOperating(@Param("operating")OperatingVO operating);

	void updateOperatingList(@Param("operating")OperatingVO operating, @Param("fa_num")int fa_num);







}
