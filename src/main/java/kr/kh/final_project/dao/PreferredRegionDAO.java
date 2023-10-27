package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.AccountVO;

public interface PreferredRegionDAO {

	void insertPreferredRegion(@Param("me_num")int pr_me_num, @Param("rg_num")int pr1);


}
