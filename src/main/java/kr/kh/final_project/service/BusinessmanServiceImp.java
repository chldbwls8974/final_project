package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.BusinessmanDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;

@Service
public class BusinessmanServiceImp implements BusinessmanService{

	@Autowired
	BusinessmanDAO businessmanDao;
	
	@Autowired
	RegionDAO regionDao;

	@Autowired
	PreferredRegionDAO prRegionDao;

	@Override
	public List<FacilityVO> getFacilityList() {
		List<FacilityVO> list = businessmanDao.selectFacilityList();
		return list;
	}

	@Override
	public BusinessmanVO getBusinessmanByNum(Integer me_num) {
		return businessmanDao.seletBusinessmanByNum(me_num);
	}

	@Override
	public boolean insertFacility(BusinessmanVO business, MemberVO user, FacilityVO facility) {
		if(user == null || user.getMe_num() == null){
			return false;
		}
		if(business == null 
				|| business.getBu_me_num() == null 
				|| business.getBu_state() == 0 ) {
			return false;
		}
		if(facility == null) {
			return false;
		}
		facility.setFa_bu_num(business.getBu_num());
		boolean res = businessmanDao.insertFacility(facility);
		return res;
	}

	@Override
	public List<RegionVO> getMainRegion() {
		return regionDao.selectMainRegion();
	}

	@Override
	public List<RegionVO> getSubRegionByMainRegion(String rg_main) {
		return regionDao.selectSubRegion(rg_main);
	}
	
	
}
