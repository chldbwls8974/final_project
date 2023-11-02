package kr.kh.final_project.service;

import kr.kh.final_project.vo.ClubVO;

public interface ClubService {

	boolean insertClub(int me_num, ClubVO club, int[] age, int[] favoriteTime, int[] favoriteHoliTime);
	
}
	
