package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface PreferredRegionDAO {

	void insertPreferredRegion(@Param("me_num")int pr_me_num, @Param("rg_num")int pr1);

	List<Integer> selectPrRgNumListByMeNum(@Param("me_num")Integer me_num);
	
	void deletePreferredRegion(@Param("me_num")int pr_me_num);

}
