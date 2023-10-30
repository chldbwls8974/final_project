package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface PreferredTimeDAO {

	void insertPreferredTime(@Param("pt_num")int pt_num, @Param("me_num")int pr_me_num);

	List<Integer> selectPtTiNumListByMeNum(@Param("me_num")Integer me_num);

}
