package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.PreferredRegionVO;

public interface PreferredAgeDAO {

	void insertPrefferedAge(@Param("age")int i,@Param("cl_num") int cl_num);

	void deletePreferredAge(@Param("cl_num")int cl_num);

	List<Integer> selectPreAgeListByClNum(@Param("cl_num")Integer cl_num);


}
