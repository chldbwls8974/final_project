package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.TeamVO;

public interface TeamDAO {

	TeamVO selectListTeamByMtNum(@Param("mt_num")int mt_num);

	boolean insertListTeamByMtNum(@Param("mt_num")int mt_num);

	TeamVO selectTeamByClNum(@Param("mt_num")int mt_num, @Param("cl_num")int cl_num);

	void insertTeam(@Param("mt_num")int mt_num);

	TeamVO selectTeamByMtNum(@Param("mt_num")int mt_num);

	void insertClubTeam(@Param("te_num")int te_num, @Param("cl_num")int cl_num);
}