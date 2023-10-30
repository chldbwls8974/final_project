package kr.kh.final_project.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.ExtraDAO;
import kr.kh.final_project.dao.MatchDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.PreferredTimeDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.dao.TimeDAO;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.RegionVO;

@Service
public class MatchServiceImp implements MatchService{

	@Autowired
	ExtraDAO extraDao;
	
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
		List<Integer> rgNumList = new ArrayList<Integer>();
		List<Integer> tiNumList;
		List<MatchVO> dbMatchList = matchDao.selectMatchListOfManager(me_num, mt_date);
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
	
}
