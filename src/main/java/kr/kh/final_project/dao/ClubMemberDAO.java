package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.ClubVO;

public interface ClubMemberDAO {

	void insertClubMember(@Param("cl_num")int cl_num, @Param("me_num")int me_num, @Param("authority")String authority);

}
