package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.ClubVO;

public interface ClubDAO {

	void insertClub(@Param("club")ClubVO club);

	ClubVO selectClub(@Param("club")ClubVO club);



}
