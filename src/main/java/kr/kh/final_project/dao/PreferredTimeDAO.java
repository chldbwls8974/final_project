package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.PreferredTimeVO;

public interface PreferredTimeDAO {

	List<PreferredTimeVO> selectPTListByMeNum(@Param("me_num")Integer me_num);

}
