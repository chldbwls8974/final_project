package kr.kh.final_project.service;

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
import kr.kh.final_project.vo.PreferredRegionVO;
import kr.kh.final_project.vo.PreferredTimeVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TimeVO;

@Service
public class MatchServiceImp implements MatchService{

	@Autowired
	ExtraDAO extraDao;
	
	@Autowired
	MatchDAO matchDao;
	
	@Autowired
	PreferredRegionDAO PreferredRegionDao;
	
	@Autowired
	PreferredTimeDAO PreferredTimeDao;
	
	@Autowired
	RegionDAO regionDao;
	
	@Autowired
	TimeDAO timeDao;
	
	@Override
	public List<ExtraVO> selectThirdWeekDayList() {
		return extraDao.selectThirdWeekDayList();
	}
	

	@Override
	public List<MatchVO> selectMatchListOfManager(Integer me_num, Date mt_date) {
		if(me_num == null || mt_date == null) {
			return null;
		}
		return matchDao.selectMatchListOfManager(me_num, mt_date);
	}

	@Override
	public List<PreferredRegionVO> selectPRListByMeNum(Integer me_num) {
		if(me_num == null) {
			return null;
		}
		return PreferredRegionDao.selectPRListByMeNum(me_num);
	}

	@Override
	public List<PreferredTimeVO> selectPTListByMeNum(Integer me_num) {
		if(me_num == null) {
			return null;
		}
		return PreferredTimeDao.selectPTListByMeNum(me_num);
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
	public List<RegionVO> selectRegionListByRgNum(int rg_num) {
		if(rg_num == 0) {
			return null;
		}
		List<RegionVO> region = regionDao.selectRegionByRgNum(rg_num);
		List<RegionVO> regionList = regionDao.selectMainRegion2();
		for(RegionVO r : region) {
			for(RegionVO rList : regionList) { 
				if(r.getRg_num() == rList.getRg_num()){
					return regionDao.selectSubRegionByMainRegion(r.getRg_num());
				}
			}
		}
		return region;
	}


	@Override
	public List<TimeVO> selectTimeListByMtDate(Date mt_date) {
		if(mt_date == null) {
			return null;
		}
		return timeDao.selectTimeListByMtDate(mt_date);
	}
	
	
}
