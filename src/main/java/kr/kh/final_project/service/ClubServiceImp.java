package kr.kh.final_project.service;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.ClubDAO;
import kr.kh.final_project.dao.ClubMemberDAO;
import kr.kh.final_project.dao.PreferredAgeDAO;
import kr.kh.final_project.dao.TeamPreferredTimeDAO;
import kr.kh.final_project.vo.ClubVO;



@Service
public class ClubServiceImp implements ClubService{
	
	@Autowired
	ClubDAO clubDao;
	
	@Autowired
	ClubMemberDAO clubMemberDao;
	
	@Autowired
	TeamPreferredTimeDAO teamTimeDao;
	
	@Autowired
	PreferredAgeDAO preAgeDao;

	@Override
	public boolean insertClub(int me_num,ClubVO club, int[] age, int[] favoriteTime, int[] favoriteHoliTime) {
		if(club ==null) {
			return false;
		}
		clubDao.insertClub(club);
		int cl_num = clubDao.selectClub(club).getCl_num();
		
		System.out.println(cl_num);
		if(favoriteTime !=null) {
			insertPrefferedTime(0,cl_num,favoriteTime);
		}
		if(favoriteHoliTime !=null) {
			insertPrefferedTime(1,cl_num,favoriteHoliTime);
		}
		if(age != null) {
			for(int i : age) {
				preAgeDao.insertPrefferedAge(i,cl_num);
			}
		}
		String authority = "LEADER";
		clubMemberDao.insertClubMember(cl_num,me_num,authority);
		return true;
	}

	private void insertPrefferedTime(int div, int cl_num, int[] Time) {
		for(int i : Time) {
			// 평일이면
						if(div == 0) {
							// 선호시간은 2시간 간격이기 때문에 for문이 2개 필요함
							//월(0) ~ 금(4)까지 첫번째 시간을 넣기 위한 반복문 
							for(int day = 0 ; day < 5; day++) {
								int pt_num = (i+1) +(24*day); // 요일별 시간테이블의 숫자
								teamTimeDao.insertPreferredTime(pt_num, cl_num);
							}
							//월(0) ~ 금(4)까지 두번째 시간을 넣기 위한 반복문 
							for(int day = 0 ; day < 5; day++) {
								int pt_num = (i+2) +(24*day); // 요일별 시간테이블의 숫자
								teamTimeDao.insertPreferredTime(pt_num, cl_num);
							}
						}
						
						// 주말이면
						else if(div == 1) {
							// 선호시간은 2시간 간격이기 때문에 for문이 2개 필요함
							//토(5), 일(6)첫번째 시간을 넣기 위한 반복문 
							for(int day = 5 ; day < 7; day++) {
								int pt_num = (i+1) +(24*day); // 요일별 시간테이블의 숫자
								teamTimeDao.insertPreferredTime(pt_num, cl_num);
							}
							//토(5), 일(6) 두번째 시간을 넣기 위한 반복문 
							for(int day = 5 ; day < 7; day++) {
								int pt_num = (i+2) +(24*day); // 요일별 시간테이블의 숫자
								teamTimeDao.insertPreferredTime(pt_num, cl_num);
							}
						}
			
		}
		
	}



}
