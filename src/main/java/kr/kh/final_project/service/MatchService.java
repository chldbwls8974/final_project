package kr.kh.final_project.service;

import java.util.Date;
import java.util.List;

import kr.kh.final_project.vo.ClubMemberVO;
import kr.kh.final_project.vo.ClubVO;
import kr.kh.final_project.vo.CouponVO;
import kr.kh.final_project.vo.EntryVO;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.QuarterVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TeamVO;

public interface MatchService {
	
	List<ExtraVO> selectWeekDayList(int i);

	List<RegionVO> selectMainRegion();

	List<RegionVO> selectSubRegionByMainRegion(int rg_num);

	List<MatchVO> selectMatchListOfManager(Integer me_num, Date mt_date, int rg_num, boolean check);

	List<MatchVO> selectMatchListOfSolo(Integer me_num, Date mt_date, int rg_num, boolean check);

	List<MatchVO> selectMatchListOfClub(int cl_num, Date mt_date);

	MatchVO selectMatchByMtNum(int mt_num, Integer me_num, int cl_num);

	ExpenseVO selectPrice(int cl_num, String ti_day);

	List<CouponVO> selectCouponListByMeNum(Integer me_num);

	boolean applicationMatchSolo(MemberVO user, int mt_num, int point, int hp_num);

	boolean canselMatchSolo(Integer me_num, int mt_num);

	List<ClubVO> selectClubListByMeNum(Integer me_num);

	ClubMemberVO selectClubMemberByMeNum(Integer me_num, int cl_num);
	
	List<TeamVO> selectTeamByMtNum(int mt_num);

	boolean applicationMatchClub(MemberVO user, int cl_num, int mt_num, int point);

	boolean canselMatchClub(Integer me_num, int mt_num, int cl_num);

	List<EntryVO> selectEntryByMtNum(int mt_num);

	List<ClubMemberVO> selectClubMemberListByMtNum(int cl_num, int mt_num);

	boolean insertEntryClub(int me_num, int cl_num, int mt_num);

	boolean deleteEntryClub(int en_num);

	void deleteMatch();

	void deleteMatchSolo();

	void deleteMatchClub();

	void updateEndMatch();
	
	boolean updateRatingMatchResult(int mt_num);

	boolean insertMatchTeamSolo(int mt_num);

	List<QuarterVO> selectQuarterListByMtNum(int mt_num);

	int countQuarterByMtNum(int mt_num);

	List<MatchVO> getMyMatchListByMeNum(Integer me_num);

	List<MatchVO> selectMyRecored(Integer me_num);

	MemberVO selectManagerByMtNum(int mt_num);

}
