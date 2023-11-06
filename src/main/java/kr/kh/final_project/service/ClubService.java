package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.ClubMemberVO;
import kr.kh.final_project.vo.ClubVO;
import kr.kh.final_project.vo.PreferredAgeVO;
import kr.kh.final_project.vo.TeamPreferredTimeVO;

public interface ClubService {

	boolean insertClub(int me_num, ClubVO club, int[] age, int[] favoriteTime, int[] favoriteHoliTime);

	Object checkClubName(String name);

	List<ClubVO> getClubList();

	ClubVO getClub(Integer cl_num);

	boolean joinClub(ClubMemberVO clubMember);

	boolean updateClub(int me_num, ClubVO club, int[] age, int[] favoriteTime, int[] favoriteHoliTime);

	List<ClubVO> getMyClubList(Integer me_num, String authority);
 
	List<PreferredAgeVO> getClubAgeList(); //마이페이지-내클럽 선호연령 가져오기

	List<TeamPreferredTimeVO> getClubTimeList(); //마이페이지-내클럽 선호시간 가져오기
	
}
	
