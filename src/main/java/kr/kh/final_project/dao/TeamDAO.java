package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.TeamVO;

public interface TeamDAO {

	TeamVO selectListTeamByMtNum(@Param("mt_num")int mt_num);

	boolean insertListTeamByMtNum(@Param("mt_num")int mt_num);
}