package kr.kh.final_project.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.ClubDAO;
import kr.kh.final_project.dao.ClubMemberDAO;
import kr.kh.final_project.dao.PreferredAgeDAO;
import kr.kh.final_project.dao.TeamPreferredTimeDAO;
import kr.kh.final_project.vo.ClubMemberVO;
import kr.kh.final_project.vo.ClubVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PreferredAgeVO;
import kr.kh.final_project.vo.TeamPreferredTimeVO;



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
	public boolean insertClub(int me_num,String fi_name, ClubVO club, int[] age, int[] favoriteTime, int[] favoriteHoliTime) {
		if(club ==null) {
			return false;
		}
		clubDao.insertClub(fi_name,club);
		int cl_num = clubDao.selectClubByName(club.getCl_name()).getCl_num();
		
		if(favoriteTime !=null) {
			insertPreferredTime(0,cl_num,favoriteTime);
		}
		if(favoriteHoliTime !=null) {
			insertPreferredTime(1,cl_num,favoriteHoliTime);
		}
		if(age != null) {
			for(int i : age) {
				preAgeDao.insertPrefferedAge(i,cl_num);
			}
		}
		String authority = "LEADER";
		clubMemberDao.insertClubLeader(cl_num,me_num,authority);
		return true;
	}

	private void insertPreferredTime(int div, int cl_num, int[] Time) {
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

	
	
	@Override
	public Object checkClubName(String name) {
		ClubVO dbClub = clubDao.selectClubByName(name);
		return dbClub;
	}

	@Override
	public List<ClubVO> getClubList() {
		return clubDao.selectClubList();
	}

	@Override
	public ClubVO getClub(Integer cl_num) {
		return clubDao.selectClubByNum(cl_num);
	}

	@Override
	public boolean joinClub(ClubMemberVO clubMember) {
		if(clubMember == null) {
			return false;
		}
		clubMemberDao.insertClubMember(clubMember);
		return true;
	}
	
	
	@Override
	public TeamPreferredTimeVO getClubTime(Integer cl_num) {
		return teamTimeDao.selectTeamTime(cl_num);
	}

	@Override
	public boolean updateClub(int me_num, ClubVO club, String fi_name, int[] age, int[] favoriteTime, int[] favoriteHoliTime) {
		if(club == null) {
			return false;
		}
		ClubVO dbClub =  clubDao.selectClubByNum(club.getCl_num());
		if(dbClub == null) {
			return false;
		}
		clubDao.updateClub(club, fi_name);
		teamTimeDao.deletePreferredTime(club.getCl_num());
		preAgeDao.deletePreferredAge(club.getCl_num());
		int cl_num = clubDao.selectClubByName(club.getCl_name()).getCl_num();
		if(favoriteTime !=null) {
			insertPreferredTime(0,cl_num,favoriteTime);
		}
		if(favoriteHoliTime !=null) {
			insertPreferredTime(1,cl_num,favoriteHoliTime);
		}
		if(age != null) {
			for(int i : age) {
				preAgeDao.insertPrefferedAge(i,cl_num);
			}
		}
		return true;
	}

	

	@Override
	public List<ClubVO> getMyClubList(Integer me_num,String authority) {
		if(me_num == 0 || authority == null) {
			return null;
		}
		return clubDao.selectMyClubList(me_num,authority);
	}

	@Override
	public ClubMemberVO getMyAuthorityByClub(Integer cl_num, Integer me_num) {
		if(cl_num == 0 || me_num == 0) {
			return null;
		}
		return clubMemberDao.selecMytAuthorityByClub(cl_num, me_num);
	}

	@Override
	public List<ClubMemberVO> getClubMemberList(Integer cl_num) {
		if(cl_num == 0) {
			return null;
		}
		return clubMemberDao.selectClubMemberList(cl_num);
	}

	@Override
	public void memberManage(String type, int cl_num, int me_num,  MemberVO user) {
		if(type == null || cl_num == 0 || me_num == 0 || user == null) {
			return;
		}
		// 강퇴시
		if(type.equals("discharge")) {
			clubMemberDao.deleteMember(cl_num,me_num);
		}
		// 위임시
		if(type.equals("delegate")) {
			clubMemberDao.changeAuthority("LEADER",cl_num,me_num);
			clubMemberDao.changeAuthority("MEMBER",cl_num,user.getMe_num());
		}
		// 거절시
		if(type.equals("refuse")) {
			clubMemberDao.deleteMember(cl_num,me_num);
		}
		// 승인시
		if(type.equals("approval")) {
			clubMemberDao.changeAuthority("MEMBER",cl_num,me_num);
		}
		// 탈퇴시
		if(type.equals("withdraw")) {
			clubMemberDao.deleteMember(cl_num,me_num);
		}
	}



	public List<PreferredAgeVO> getClubAgeList() {
		return clubDao.selectClubAgeList();
	}

	@Override
	public List<TeamPreferredTimeVO> getClubTimeList() {
		return clubDao.selectClubTimeList();
	}



}