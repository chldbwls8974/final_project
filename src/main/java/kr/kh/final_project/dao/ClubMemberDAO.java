package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.ClubMemberVO;
import kr.kh.final_project.vo.ClubVO;

public interface ClubMemberDAO {

	void insertClubLeader(@Param("cl_num")int cl_num, @Param("me_num")int me_num, @Param("authority")String authority);

	void insertClubMember(@Param("member")ClubMemberVO clubMember);

	ClubMemberVO selecMytAuthorityByClub(@Param("cl_num")Integer cl_num, @Param("me_num")Integer me_num);

}
