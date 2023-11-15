package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.ClubVO;
import kr.kh.final_project.vo.PreferredAgeVO;
import kr.kh.final_project.vo.TeamPreferredTimeVO;

public interface ClubDAO {

	void insertClub(@Param("fi_name")String fi_name, @Param("club")ClubVO club);

	ClubVO selectClubByName(@Param("cl_name")String club);

	List<ClubVO> selectClubList();

	ClubVO selectClubByNum(@Param("cl_num")Integer cl_num);

	List<ClubVO> selectMyClubList(@Param("me_num")Integer me_num,@Param("authority") String authority);
	
	List<ClubVO> selectClubListByMeNum(@Param("me_num")Integer me_num);
	
	void updateClub(@Param("club")ClubVO club,@Param("fi_name")String fi_name);
	
	List<PreferredAgeVO> selectClubAgeList();

	List<TeamPreferredTimeVO> selectClubTimeList();
}
