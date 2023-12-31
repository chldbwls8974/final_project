package kr.kh.final_project.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.ClubDAO;
import kr.kh.final_project.dao.ClubMemberDAO;
import kr.kh.final_project.dao.CouponDAO;
import kr.kh.final_project.dao.EntryDAO;
import kr.kh.final_project.dao.ExpenseDAO;
import kr.kh.final_project.dao.ExtraDAO;
import kr.kh.final_project.dao.ManagerDAO;
import kr.kh.final_project.dao.MatchDAO;
import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.dao.PointHistoryDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.PreferredTimeDAO;
import kr.kh.final_project.dao.QuarterDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.dao.TeamDAO;
import kr.kh.final_project.dao.TimeDAO;
import kr.kh.final_project.vo.AvailabilityVO;
import kr.kh.final_project.vo.ClubMemberVO;
import kr.kh.final_project.vo.ClubVO;
import kr.kh.final_project.vo.CouponVO;
import kr.kh.final_project.vo.EntryVO;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.QuarterVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.StadiumVO;
import kr.kh.final_project.vo.TeamVO;

@Service
public class MatchServiceImp implements MatchService{

	@Autowired
	ExtraDAO extraDao;
	
	@Autowired
	ExpenseDAO expenseDao;
	
	@Autowired
	MatchDAO matchDao;
	
	@Autowired
	PreferredRegionDAO preferredRegionDao;
	
	@Autowired
	PreferredTimeDAO preferredTimeDao;
	
	@Autowired
	RegionDAO regionDao;
	
	@Autowired
	TimeDAO timeDao;
	
	@Autowired
	CouponDAO couponDao;
	
	@Autowired
	EntryDAO entryDao;
	
	@Autowired
	TeamDAO teamDao;
	
	@Autowired
	QuarterDAO quarterDao;
	
	@Autowired
	PointHistoryDAO pointHistoryDao;
	
	@Autowired
	ClubDAO clubDao;
	
	@Autowired
	ClubMemberDAO clubMemberDao;
	
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	ManagerDAO managerDao;
	
	@Override
	public List<ExtraVO> selectWeekDayList(int i) {
		return extraDao.selectWeekDayList(i);
	}

	@Override
	public List<RegionVO> selectMainRegion() {
		return regionDao.selectMainRegion2();
	}

	@Override
	public List<RegionVO> selectSubRegionByMainRegion(int rg_num) {
		if(rg_num == 0) {
			return null;
		}
		return regionDao.selectSubRegionByMainRegion(rg_num);
	}

	@Override
	public List<MatchVO> selectMatchListOfManager(Integer me_num, Date mt_date, int rg_num, boolean check) {
		if(me_num == null || mt_date == null) {
			return null;
		}
		List<MatchVO> dbMatchList = matchDao.selectMatchListOfManager(me_num, mt_date);
		for(MatchVO match : dbMatchList) {
			if(match.getTi_time_str().equals("00:00")) {
				if(matchDao.selectManagerAble0ByMtDate(me_num, mt_date).size() != 0) {
					match.setApplication_able(0);
				}
			}
			if(match.getTi_time_str().equals("23:00")) {
				if(matchDao.selectManagerAble23ByMtDate(me_num, mt_date).size() != 0) {
					match.setApplication_able(0);
				}
			}
		}
		return filterMatch(me_num, mt_date, rg_num, check, dbMatchList);
	}

	@Override
	public List<MatchVO> selectMatchListOfSolo(Integer me_num, Date mt_date, int rg_num, boolean check) {
		if(me_num == null || mt_date == null) {
			return null;
		}
		List<MatchVO> dbMatchList = matchDao.selectMatchListOfSolo(me_num, mt_date);
		for(MatchVO match : dbMatchList) {
			if(match.getTi_time_str().equals("00:00")) {
				if(matchDao.selectManagerAble0ByMtDate(me_num, mt_date).size() != 0 || matchDao.selectSoloMatchAble0ByMtDate(me_num, mt_date).size() != 0) {
					match.setApplication_able(0);
				}
			}
			if(match.getTi_time_str().equals("23:00")) {
				if(matchDao.selectManagerAble23ByMtDate(me_num, mt_date).size() != 0 || matchDao.selectSoloMatchAble23ByMtDate(me_num, mt_date).size() != 0) {
					match.setApplication_able(0);
				}
			}
		}
		return filterMatch(me_num, mt_date, rg_num, check, dbMatchList);
	}

	@Override
	public List<MatchVO> selectMatchListOfClub(int cl_num, Date mt_date){
		if(cl_num == 0 || mt_date == null) {
			return null;
		}
		List<MatchVO> dbMatchList = matchDao.selectMatchListOfClub(cl_num, mt_date);
		for(MatchVO match : dbMatchList) {
			if(match.getTi_time_str().equals("00:00")) {
				if(matchDao.selectClubMatchAble0ByMtDate(cl_num, match.getMt_date()).size() != 0) {
					match.setApplication_able(0);
				}
			}
			if(match.getTi_time_str().equals("23:00")) {
				if(matchDao.selectClubMatchAble23ByMtDate(cl_num, match.getMt_date()).size() != 0) {
					match.setApplication_able(0);
				}
			}
		}
		return filterMatch(cl_num, dbMatchList);
	}

	@Override
	public MatchVO selectMatchByMtNum(int mt_num, Integer me_num, int cl_num) {
		if(mt_num == 0 || me_num == null) {
			return null;
		}
		MatchVO match = null;
		if(cl_num == 0) {
			match = matchDao.selectMatchByMeNum(mt_num, me_num);

			match.setApplication_able(matchDao.selectAbleSolo(me_num, match.getMt_date(), mt_num));
			if(match.getTi_time_str().equals("00:00")) {
				if(matchDao.selectManagerAble0ByMtDate(me_num, match.getMt_date()).size() != 0 || matchDao.selectSoloMatchAble0ByMtDate(me_num, match.getMt_date()).size() != 0) {
					match.setApplication_able(0);
				}
			}else if(match.getTi_time_str().equals("23:00")) {
				if(matchDao.selectManagerAble23ByMtDate(me_num, match.getMt_date()).size() != 0 || matchDao.selectSoloMatchAble23ByMtDate(me_num, match.getMt_date()).size() != 0) {
					match.setApplication_able(0);
				}
			}
		}else if(cl_num != 0) {
			match = matchDao.selectMatchByClNum(mt_num, cl_num);

			match.setApplication_able(matchDao.selectAbleClub(cl_num, match.getMt_date(), mt_num));
			if(match.getTi_time_str().equals("00:00")) {
				if(matchDao.selectClubMatchAble0ByMtDate(cl_num, match.getMt_date()).size() != 0) {
					match.setApplication_able(0);
				}
			}
			if(match.getTi_time_str().equals("23:00")) {
				if(matchDao.selectClubMatchAble23ByMtDate(cl_num, match.getMt_date()).size() != 0) {
					match.setApplication_able(0);
				}
			}
		}
		if(match.getMt_rule() == 1) {
			MemberVO dbManager = memberDao.selectManagerByMtNum(match.getMt_num());
			match.setMe_name(dbManager.getMe_name());
			match.setMe_phone(dbManager.getMe_phone());
		}
		return match;
	}

	@Override
	public ExpenseVO selectPrice(int cl_num, String ti_day) {
		if(ti_day == null) {
			return null;
		}
		List<ExpenseVO> expenseList = expenseDao.selectPriceList();
		if(cl_num == 0) {
			if(!ti_day.equals("토") && !ti_day.equals("일")) {
				return expenseList.get(0);
			}else {
				return expenseList.get(1);
			}
		}else if(cl_num != 0){
			if(!ti_day.equals("토") && !ti_day.equals("일")) {
				return expenseList.get(2);
			}else {
				return expenseList.get(3);
			}			
		}
		return null;
	}

	public List<MatchVO> filterMatch(Integer me_num, Date mt_date, int rg_num, boolean check, List<MatchVO> dbMatchList){
		List<Integer> rgNumList = new ArrayList<Integer>();
		List<Integer> rgNumSubList = new ArrayList<Integer>();
		List<Integer> tiNumList;
		List<MatchVO> matchList = new ArrayList<MatchVO>();
		if(rg_num == 0) {
			rgNumList = preferredRegionDao.selectPrRgNumListByMeNum(me_num);
			List<Integer> rgMainList = regionDao.selectRgNumSubAll();
			for(Integer rgNum : rgNumList) {
				if(rgMainList.indexOf(rgNum) != -1) {
					for(Integer rgN : rgMainList) {
						if(rgNum == rgN) {
							List<Integer> dbRgNumList = regionDao.selectSubRgNumByMainRgNum(rgN);
							for(Integer dbRgN : dbRgNumList) {
								if(rgN != dbRgN) {
									rgNumSubList.add(dbRgN);
								}
							}
						}
					}
				}
			}
			for(Integer rgNumSub : rgNumSubList) {
				rgNumList.add(rgNumSub);
			}
		}else if(rg_num == 246){
			List<RegionVO> regionList = regionDao.selectUserRegion();
			for(RegionVO region : regionList) {
				rgNumList.add(region.getRg_num());				
			}
		}else {
			List<Integer> rgMainList = regionDao.selectRgNumSubAll();
			if(rgMainList.indexOf(rg_num) != -1) {
				for(Integer rgNum : rgMainList) {
					if(rg_num == rgNum) {
						rgNumList = regionDao.selectSubRgNumByMainRgNum(rgNum);
					}
				}
			}else {
				rgNumList = regionDao.selectRgNumByRgNum(rg_num);
			}
		}
		if(check) {
			tiNumList = preferredTimeDao.selectPtTiNumListByMeNum(me_num);
		}else {
			tiNumList = timeDao.selectTiNumListByMtDate(mt_date);
		}
		for(MatchVO m : dbMatchList) {
			for(Integer r : rgNumList) {
				if(r == m.getFa_rg_num()) {
					for(Integer t : tiNumList) {
						if(t == m.getMt_ti_num()) {
							matchList.add(m);
						}
					}
				}
			}
		}
		return matchList;
	}
	private List<MatchVO> filterMatch(int cl_num, List<MatchVO> dbMatchList) {
		List<Integer> rgNumList = new ArrayList<Integer>();
		List<MatchVO> matchList = new ArrayList<MatchVO>();
		ClubVO dbClub = clubDao.selectClubByNum(cl_num);
		List<Integer> rgMainList = regionDao.selectRgNumSubAll();
		if(rgMainList.indexOf(dbClub.getCl_rg_num()) != -1) {
			for(Integer rgNum : rgMainList) {
				if(dbClub.getCl_rg_num() == rgNum) {
					rgNumList = regionDao.selectSubRgNumByMainRgNum(rgNum);
				}
			}
		}else {
			rgNumList = regionDao.selectRgNumByRgNum(dbClub.getCl_rg_num());
		}
		for(MatchVO m : dbMatchList) {
			for(Integer r : rgNumList) {
				if(r == m.getFa_rg_num()) {
					matchList.add(m);
				}
			}
		}
		return matchList;
	}

	@Override
	public List<CouponVO> selectCouponListByMeNum(Integer me_num) {
		if(me_num == null) {
			return null;
		}
		return couponDao.selectCouponListByMeNum(me_num);
	}

	@Override
	public boolean applicationMatchSolo(MemberVO user, int mt_num, int point, int hp_num) {
		if(user == null || mt_num == 0) {
			return false;
		}
		
		TeamVO dbTeam = teamDao.selectListTeamByMtNum(mt_num);
		if(dbTeam == null) {
			teamDao.insertListTeamByMtNum(mt_num);
			dbTeam = teamDao.selectListTeamByMtNum(mt_num);
		}
		if(dbTeam.getEntry_count() < (dbTeam.getMt_rule() == 0 ? dbTeam.getMt_personnel()*2 : dbTeam.getMt_personnel()*3)) {
			if(entryDao.selectEntryByMeNum(dbTeam.getTe_num(), user.getMe_num()) == null) {
				if(entryDao.insertEntry(dbTeam.getTe_num(), user.getMe_num())) {
					pointHistoryDao.insertPointHistoryApplicationMatch(point, mt_num, user.getMe_num());
					memberDao.updateMemberPoint2(point, user.getMe_num());
					if(dbTeam.getMt_type() == 0) {
						matchDao.updateMatchMtTypeTo1(mt_num);
						matchDao.updateMatchMtState2To1(mt_num);
					}
					if(hp_num != 0) {
						couponDao.deleteCoupon(hp_num);
					}
					return true;
				}		
			}
		}
		
		return false;
	}

	@Override
	public boolean canselMatchSolo(Integer me_num, int mt_num) {
		if(me_num == null || mt_num == 0) {
			return false;
		}
		PointHistoryVO dbPH = pointHistoryDao.selectPointHistoryApplicationMatch(me_num, mt_num);
		TeamVO dbTeam = teamDao.selectListTeamByMtNum(mt_num);
		EntryVO dbEntry = entryDao.selectEntryByMeNum(dbTeam.getTe_num(), me_num);
		if(dbPH != null) {
			if(pointHistoryDao.insertPointHistoryCanselMatch(dbPH.getPh_price(), mt_num, me_num)){
				dbPH = pointHistoryDao.selectPointHistoryRefund(me_num, mt_num);
				memberDao.updateMemberPoint2(-dbPH.getPh_price(), me_num);
				if(entryDao.deleteEntry(dbEntry.getEn_num())) {
					dbTeam = teamDao.selectListTeamByMtNum(mt_num);
					if(dbTeam.getEntry_count() == 0) {
						teamDao.deleteTeam(dbTeam.getTe_num());
						matchDao.updateMatchMtTypeTo0(mt_num);
					}
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public List<ClubVO> selectClubListByMeNum(Integer me_num) {
		if(me_num == null) {
			return null;
		}
		return clubDao.selectClubListByMeNum(me_num);
	}

	@Override
	public ClubMemberVO selectClubMemberByMeNum(Integer me_num, int cl_num) {
		if(me_num == null || cl_num == 0) {
			return null;
		}
		return clubMemberDao.selectClubMemberByMeNum(me_num, cl_num);
	}


	@Override
	public List<MatchVO> getMyMatchListByMeNum(Integer me_num) {
		if(me_num == null) {
			return null;
		}
		List<MatchVO> matchList = matchDao.selectMyMatchListByMeNum(me_num);
		for(MatchVO match : matchList) {
			if(match.getMt_type() == 1) {
				match.setCl_num(0);
			}else if(match.getMt_type() == 2) {
				match.setCl_num(teamDao.selectClubTeamByMeNum(match.getMt_num(), me_num));
			}
		}
		return matchList;
	}
	
	@Override
	public List<TeamVO> selectTeamByMtNum(int mt_num) {
		if(mt_num == 0) {
			return null;
		}
		return teamDao.selectTeamByMtNum(mt_num);
	}

	@Override
	public boolean applicationMatchClub(MemberVO user, int cl_num, int mt_num, int point) {
		if(user == null || cl_num == 0 || mt_num == 0) {
			return false;
		}
		TeamVO dbTeam = teamDao.selectTeamByClNum(mt_num, cl_num);
		if(dbTeam == null) {
			teamDao.insertTeam(mt_num);
			dbTeam = teamDao.selectNewTeamByMtNum(mt_num);
			teamDao.insertClubTeam(dbTeam.getTe_num(), cl_num);
			pointHistoryDao.insertPointHistoryApplicationMatch(point, mt_num, user.getMe_num());
			memberDao.updateMemberPoint2(point, user.getMe_num());
			if(dbTeam.getMt_type() == 0) {
				matchDao.updateMatchMtTypeTo2(mt_num);
				matchDao.updateMatchMtState2To1(mt_num);
			}
			return true;
		}
		return false;
	}

	@Override
	public boolean canselMatchClub(Integer me_num, int mt_num, int cl_num) {
		if(me_num == null || mt_num == 0 || cl_num == 0) {
			return false;
		}
		PointHistoryVO dbPH = pointHistoryDao.selectPointHistoryApplicationMatch(me_num, mt_num);
		List<TeamVO> teamList = teamDao.selectTeamByMtNum(mt_num);
		boolean res = false;
		for(TeamVO t:teamList) {
			if(res) {
				teamDao.updateTeamTeType(t.getTe_num());
			}
			if(t.getCt_cl_num() == cl_num) {
				entryDao.deleteEntryByTeNum(t.getTe_num());
				teamDao.deleteClubTeamByTeNum(t.getTe_num());
				teamDao.deleteTeam(t.getTe_num());
				res = true;
			}
		}
		MatchVO dbMatch = matchDao.selectMatchByClNum(mt_num, cl_num);
		if(dbMatch.getTeam_count() == 0) {
			matchDao.updateMatchMtTypeTo0(mt_num);
		}
		if(res) {
			pointHistoryDao.insertPointHistoryCanselMatch(dbPH.getPh_price(), mt_num, me_num);
			dbPH = pointHistoryDao.selectPointHistoryRefund(me_num, mt_num);
			memberDao.updateMemberPoint2(-dbPH.getPh_price(), me_num);
			return res;
		}
		return false;
	}

	@Override
	public List<EntryVO> selectEntryByMtNum(int mt_num) {
		if(mt_num == 0) {
			return null;
		}
		return entryDao.selectEntryByMtNum(mt_num);
	}

	@Override
	public List<ClubMemberVO> selectClubMemberListByMtNum(int cl_num, int mt_num) {
		if(cl_num == 0 || mt_num == 0) {
			return null;
		}
		return clubMemberDao.selectClubMemberListByMtNum(cl_num, mt_num);
	}

	@Override
	public boolean insertEntryClub(int me_num, int cl_num, int mt_num) {
		if(me_num == 0 || cl_num == 0 || mt_num == 0) {
			return false;
		}
		return entryDao.insertEntryClub(me_num, cl_num, mt_num);
	}

	@Override
	public boolean deleteEntryClub(int en_num) {
		if(en_num == 0) {
			return false;
		}
		return entryDao.deleteEntry(en_num);
	}

	@Override
	public void deleteMatch() {
		matchDao.deleteMatch();
		List<MatchVO> matchList = matchDao.selectLimitMatch();
		for(MatchVO match : matchList) {
			matchDao.updateMatchMtState1To1(match.getMt_num());
		}
	}

	@Override
	public void deleteMatchSolo() {
		List<MatchVO> matchList = matchDao.selectMatchSolo();
		deleteSoloMatch(matchList);
		
	}
	
	public void deleteSoloMatch(List<MatchVO> matchList) {
		for(MatchVO match : matchList) {
			if(match.getMt_rule() == 1) {
				managerDao.deleteManagerByMtNum(match.getMt_num());
			}
			if(match.getDelete() == 1) {
				//매치 정원이 안되면 참가자 전원 환불 후 참가자 삭제
				List<EntryVO> entryList = entryDao.selectEntryByMtNum(match.getMt_num());
				for(EntryVO entry : entryList) {
					PointHistoryVO dbPH = pointHistoryDao.selectPointHistoryApplicationMatch(entry.getEn_me_num(), match.getMt_num());
					if(pointHistoryDao.insertPointHistoryTimeOverMatch(dbPH.getPh_price(), match.getMt_num(), entry.getEn_me_num())) {
						dbPH = pointHistoryDao.selectPointHistoryTimeOver(entry.getEn_me_num(), match.getMt_num());
						memberDao.updateMemberPoint2(-dbPH.getPh_price(), entry.getEn_me_num());
						entryDao.deleteEntry(entry.getEn_num());
					}
				}
				//참가자 삭제 후 팀 삭제
				List<TeamVO> teamList = teamDao.selectTeamByMtNum(match.getMt_num());
				for(TeamVO team : teamList) {
					teamDao.deleteTeam(team.getTe_num());
				}
				//팀 삭제 후 매치 삭제(mt_state1 을 1로 수정)
				matchDao.updateMatchMtState1To1(match.getMt_num());
			}
		}
	}

	@Override
	public boolean insertMatchTeamSolo(int mt_num) {
		List<TeamVO> teamList = teamDao.selectTeamByMtNum(mt_num);
		boolean res = true;
		if(teamList.size() == 0) {
				for(int i = 0; i < 3; i++) {
					if(!teamDao.insertTeam(mt_num)) {
						res = false;
					}
			}
		}
		return res;
	}
	
	@Override
	public void deleteMatchClub() {
		List<MatchVO> matchList = matchDao.selectMatchClub();
		deleteClubMatch(matchList);
		
	}
	
	private void deleteClubMatch(List<MatchVO> matchList) {
		for(MatchVO match : matchList) {
			if(match.getMt_rule() == 1) {
				managerDao.deleteManagerByMtNum(match.getMt_num());
			}
			if(match.getDelete() == 1) {
				//클럽 매치 환불 후 참가자/클럽팀/팀 삭제
				List<TeamVO> teamList = teamDao.selectTeamByMtNum(match.getMt_num());
				for(TeamVO team : teamList) {
					ClubMemberVO dbLeader = clubMemberDao.selectClubLeader(team.getCt_cl_num());
					PointHistoryVO dbPH = pointHistoryDao.selectPointHistoryApplicationMatch(dbLeader.getCm_me_num(), match.getMt_num());
					pointHistoryDao.insertPointHistoryTimeOverMatch(dbPH.getPh_price(), match.getMt_num(), dbLeader.getCm_me_num());
					dbPH = pointHistoryDao.selectPointHistoryTimeOver(dbLeader.getCm_me_num(), match.getMt_num());
					memberDao.updateMemberPoint2(-dbPH.getPh_price(), dbLeader.getCm_me_num());
					entryDao.deleteEntryByTeNum(team.getTe_num());
					teamDao.deleteClubTeamByTeNum(team.getTe_num());
					teamDao.deleteTeam(team.getTe_num());
				}
				//팀 삭제 후 매치 삭제(mt_state1 을 1로 수정)
				matchDao.updateMatchMtState1To1(match.getMt_num());
			}
		}
	}

	@Override
	public void updateEndMatch() {
		List<MatchVO> matchList = matchDao.selectEndMatch();
		for(MatchVO match : matchList) {
			updateRatingMatchResult(match.getMt_num());
		}
	}
	//점수 업데이트
	public boolean updateRatingMatchResult(int mt_num) {
		//등록된 경기 조회
		List<QuarterVO> quarterList = quarterDao.selectQuarterListByMtNum(mt_num);
		
		for(QuarterVO quarter : quarterList) {
			//승리팀 점수 업데이트
			int winTeam = quarterDao.selectWinTeamByQuNum(quarter.getQu_num());
			if(winTeam != 0) {
				List<EntryVO> winnerList = entryDao.selectEntryListByTeNum(winTeam);
				for(EntryVO winner : winnerList) {
					memberDao.updateRatingWinByMeNum(winner.getEn_me_num());
				}
			}
			
			//패배팀 점수 업데이트
			int loserTeam = quarterDao.selectLoseTeamByQuNum(quarter.getQu_num());
			if(loserTeam != 0) {
				List<EntryVO> loserList = entryDao.selectEntryListByTeNum(loserTeam);
				for(EntryVO loser : loserList) {
					memberDao.updateRatingLoseByMeNum(loser.getEn_me_num());
				}
			}
		}
		return matchDao.updateMatchMtState1To2(mt_num);
	}

	@Override
	public List<QuarterVO> selectQuarterListByMtNum(int mt_num) {
		if(mt_num == 0) {
			return null;
		}
		return quarterDao.selectQuarterListByMtNum(mt_num);
	}

	@Override
	public int countQuarterByMtNum(int mt_num) {
		if(mt_num == 0) {
			return 0;
		}
		return quarterDao.countQuarterByMtNum(mt_num);
	}

	@Override
	public List<MatchVO> selectMyRecored(Integer me_num) {
		if(me_num == 0) {
			return null;
		}
		List<MatchVO> matchList = matchDao.selectMyRecored(me_num);
		for(MatchVO match : matchList) {
			if(match.getMt_rule() == 1) {
				MatchVO record = matchDao.selectMatchRecord(match.getMt_num(), match.getTe_num());
				match.setWin(record.getWin());
				match.setDraw(record.getDraw());
				match.setLose(record.getLose());
			}
		}
		return matchList;
	}

	@Override
	public MemberVO selectManagerByMtNum(int mt_num) {
		if(mt_num == 0) {
			return null;
		}
		return memberDao.selectManagerByMtNum(mt_num);
	}

	@Override
	public MemberVO selecBusinessByMtNum(int mt_num) {
		if(mt_num == 0) {
			return null;
		}
		return memberDao.selectBusinessByMtNum(mt_num);
	}

	@Override
	public MatchVO selectDBMatchByMtNum(int mt_num) {
		if(mt_num == 0) {
			return null;
		}
		return matchDao.selectDBMatchByMtNum(mt_num);
	}

	@Override
	public void updateMatchByStadium(StadiumVO stadium, AvailabilityVO availability) {
		if(stadium.getSt_num() == null) {
			return;
		}
		
		int st_num = stadium.getSt_num();
		Date av_notdate = availability.getAv_notdate();
		List<MatchVO> matchList = new ArrayList<MatchVO>();
		List<MatchVO> soloMatchList = new ArrayList<MatchVO>();
		List<MatchVO> clubMatchList =new ArrayList<MatchVO>();
		List<MatchVO> beforeMatchList =new ArrayList<MatchVO>();
		List<MatchVO> afterMatchList =new ArrayList<MatchVO>();
		if(stadium.getSt_available() == 0) {
			matchList = matchDao.selectMatchByStNumAll(st_num);
			for(MatchVO match : matchList) {
				matchDao.updateMatchMtState1To0(match.getMt_num());
			}
		}else if(stadium.getSt_available() == 1) {
			beforeMatchList = matchDao.selectMatchByAvBefore(st_num, av_notdate);
			for(MatchVO match : beforeMatchList) {
				matchDao.updateMatchMtState1To0(match.getMt_num());
			}
			afterMatchList = matchDao.selectMatchByAvAfter(st_num, av_notdate);
			for(MatchVO match : afterMatchList) {
				if(match.getMt_type() == 1) {
					soloMatchList.add(match);
				}else if(match.getMt_type() == 2) {
					clubMatchList.add(match);
				}else {
					matchList.add(match);
				}
			}
			for(MatchVO match : matchList) {
				if(match.getMt_rule() == 1) {
					managerDao.deleteManagerByMtNum(match.getMt_num());
				}
				matchDao.updateMatchMtState1To1(match.getMt_num());					
			}
		}else if(stadium.getSt_available() == 2) {
			soloMatchList = matchDao.selectMatchByStNumSolo(st_num);
			clubMatchList = matchDao.selectMatchByStNumClub(st_num);
			
			deleteSoloMatch(soloMatchList);
			deleteClubMatch(clubMatchList);
			
			matchList = matchDao.selectMatchByStNumAll(st_num);
			for(MatchVO match : matchList) {
				if(match.getMt_rule() == 1) {
					managerDao.deleteManagerByMtNum(match.getMt_num());
				}
				if(match.getMt_state2() == 0) {
					matchDao.deleteMatchByMtNum(match.getMt_num());
				}else if(match.getMt_state2() == 1) {
					matchDao.updateMatchMtState1To1(match.getMt_num());					
				}
			}
		}
	}

}
