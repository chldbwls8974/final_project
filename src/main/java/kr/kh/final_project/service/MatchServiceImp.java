package kr.kh.final_project.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public List<MatchVO> selectMatchListOfClub(Integer me_num, Date mt_date, int rg_num, boolean check) {
		if(me_num == null || mt_date == null) {
			return null;
		}
		List<MatchVO> dbMatchList = matchDao.selectMatchListOfClub(me_num, mt_date);
		return filterMatch(me_num, mt_date, rg_num, check, dbMatchList);
	}

	@Override
	public MatchVO selectMatchByMtNum(int mt_num, Integer me_num) {
		if(mt_num == 0 || me_num == null) {
			return null;
		}
		return matchDao.selectMatchByMtNum(mt_num, me_num);
	}

	@Override
	public ExpenseVO selectPrice(int type, String ti_day) {
		if((type != 0 && type != 1) || ti_day == null) {
			return null;
		}
		List<ExpenseVO> expenseList = expenseDao.selectPriceList();
		if(type == 0) {
			if(!ti_day.equals("토") && !ti_day.equals("일")) {
				return expenseList.get(0);
			}else {
				return expenseList.get(1);
			}
		}else if(type == 1){
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
						rgNumList = regionDao.selectSubRgNumByMainRgNum(rg_num);
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
					pointHistoryDao.insertPointHistorySoloMatch(point, 1, mt_num, user.getMe_num());
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
			if(pointHistoryDao.insertPointHistorySoloMatch(dbPH.getPh_price(), 2, mt_num, me_num)){
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
}