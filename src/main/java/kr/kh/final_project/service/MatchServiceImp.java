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
import kr.kh.final_project.dao.MatchDAO;
import kr.kh.final_project.dao.PointHistoryDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.PreferredTimeDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.dao.TeamDAO;
import kr.kh.final_project.dao.TimeDAO;
import kr.kh.final_project.vo.ClubMemberVO;
import kr.kh.final_project.vo.ClubVO;
import kr.kh.final_project.vo.CouponVO;
import kr.kh.final_project.vo.EntryVO;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;
import kr.kh.final_project.vo.RegionVO;
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
	PointHistoryDAO pointHistoryDao;
	
	@Autowired
	ClubDAO clubDao;
	
	@Autowired
	ClubMemberDAO clubMemberDao;
	
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
		return filterMatch(me_num, mt_date, rg_num, check, dbMatchList);
	}

	@Override
	public List<MatchVO> selectMatchListOfSolo(Integer me_num, Date mt_date, int rg_num, boolean check) {
		if(me_num == null || mt_date == null) {
			return null;
		}
		List<MatchVO> dbMatchList = matchDao.selectMatchListOfSolo(me_num, mt_date);
		return filterMatch(me_num, mt_date, rg_num, check, dbMatchList);
	}

	@Override
	public List<MatchVO> selectMatchListOfClub(int cl_num, Date mt_date){
		if(cl_num == 0 || mt_date == null) {
			return null;
		}
		List<MatchVO> dbMatchList = matchDao.selectMatchListOfClub(cl_num, mt_date);
		return filterMatch(cl_num, dbMatchList);
	}

	@Override
	public MatchVO selectMatchByMtNum(int mt_num, Integer me_num, int cl_num) {
		if(mt_num == 0 || me_num == null) {
			return null;
		}
		if(cl_num == 0) {
			return matchDao.selectMatchByMeNum(mt_num, me_num);			
		}else if(cl_num != 0) {
			return matchDao.selectMatchByClNum(mt_num, cl_num);
		}
		return null;
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
		List<Integer> tiNumList;
		List<MatchVO> matchList = new ArrayList<MatchVO>();
		if(rg_num == 0) {
			rgNumList = preferredRegionDao.selectPrRgNumListByMeNum(me_num);
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
					if(dbTeam.getMt_type() == 0) {
						matchDao.updateMatchMtTypeTo1(mt_num);
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
				if(entryDao.deleteEntry(dbEntry.getEn_num())) {
					dbTeam = teamDao.selectListTeamByMtNum(mt_num);
					if(dbTeam.getEntry_count() == 0) {
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
			if(dbTeam.getMt_type() == 0) {
				matchDao.updateMatchMtTypeTo2(mt_num);
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
		return entryDao.deleteEntryClub(en_num);
	}

}
