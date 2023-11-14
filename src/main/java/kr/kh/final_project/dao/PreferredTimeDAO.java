package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.PreferredTimeVO;

public interface PreferredTimeDAO {

	List<PreferredTimeVO> selectPTListByMeNum(@Param("me_num")Integer me_num);

	void insertPreferredTime(@Param("pt_num")int pt_num, @Param("me_num")int pr_me_num);

}
