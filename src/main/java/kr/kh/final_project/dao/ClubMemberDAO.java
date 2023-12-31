package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.ClubMemberVO;

public interface ClubMemberDAO {

	void insertClubLeader(@Param("cl_num")int cl_num, @Param("me_num")int me_num, @Param("authority")String authority);

	void insertClubMember(@Param("member")ClubMemberVO clubMember);

	ClubMemberVO selectClubMemberByMeNum(@Param("me_num")Integer me_num, @Param("cl_num")int cl_num);

	List<ClubMemberVO> selectClubMemberListByMtNum(@Param("cl_num")int cl_num, @Param("mt_num")int mt_num);

	ClubMemberVO selectClubLeader(@Param("cl_num")int cl_num);

	ClubMemberVO selecMytAuthorityByClub(@Param("cl_num")Integer cl_num, @Param("me_num")Integer me_num);

	List<ClubMemberVO> selectClubMemberList(@Param("cl_num")Integer cl_num);

	void deleteMember(@Param("cl_num")int cl_num, @Param("me_num")int me_num);

	void changeAuthority(@Param("authority")String authority, @Param("cl_num") int cl_num, @Param("me_num")int me_num);


 
}
