package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.ClubVO;

public interface ClubDAO {

	void insertClub(@Param("club")ClubVO club);

	ClubVO selectClubByName(@Param("cl_name")String club);

	List<ClubVO> selectClubList();

	ClubVO selectClubByNum(@Param("cl_num")Integer cl_num);

	List<ClubVO> selectMyClubList(@Param("me_num")Integer me_num,@Param("authority") String authority);
}
