package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.OperatingVO;

public interface OperatingDAO {

	List<OperatingVO> selectOperatingListByFaNum(@Param("fa_num")int fa_num);

	//운영시간 등록
	boolean insertOperating(@Param("operating")OperatingVO operating);
	//운영시간 수정
	void updateOperatingList(@Param("operating")OperatingVO operating, @Param("fa_num")int fa_num);

	void deleteOperating(@Param("fa_num")Integer fa_num);







}
