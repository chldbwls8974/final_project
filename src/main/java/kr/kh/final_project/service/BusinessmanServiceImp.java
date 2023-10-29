package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.BusinessmanDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.dao.StadiumDAO;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.StadiumVO;

@Service
public class BusinessmanServiceImp implements BusinessmanService{

	@Autowired
	BusinessmanDAO businessmanDao;
	
	@Autowired
	RegionDAO regionDao;

	@Autowired
	PreferredRegionDAO prRegionDao;
	
	@Autowired
	StadiumDAO stadiumDao;

	@Override
	public List<FacilityVO> getFacilityList() {
		//다오에게 시설 리스트를 가져오라고 시키고
		List<FacilityVO> list = businessmanDao.selectFacilityList();
		//가져오면 반환
		return list;
	}

	@Override
	public BusinessmanVO getBusinessmanByNum(Integer me_num) {
		return businessmanDao.seletBusinessmanByNum(me_num);
	}

	@Override
	public boolean insertFacility(MemberVO user, FacilityVO facility, int fa_num) {
		if(user == null || user.getMe_num() == null || user.getMe_num() == 0){
			return false;
		}
		if(facility == null 
				|| facility.getFa_name() == null 
				|| facility.getFa_bu_num() == 0
				|| facility.getFa_add() == null
				|| facility.getFa_add_detail() == null
				|| facility.getFa_phone() == null) {
			return false;
		}
		facility.setFa_num(user.getMe_num());
		return businessmanDao.insertFacility(facility);
	}
	/*@Override
	public boolean insertFacility(BusinessmanVO business, MemberVO user, FacilityVO facility) {
		if(user == null || user.getMe_num() == null){
			return false;
		}
		if(business == null 
				|| business.getBu_me_num() == null 
				|| business.getBu_state() == 0 ) {
			return false;
		}
		facility.setFa_bu_num(business.getBu_num());
		
		boolean res = businessmanDao.insertFacility(facility);
		return res;
	}*/

	@Override
	public List<RegionVO> getMainRegion() {
		return regionDao.selectMainRegion();
	}

	@Override
	public List<RegionVO> getSubRegionByMainRegion(String rg_main) {
		return regionDao.selectSubRegion(rg_main);
	}

	@Override
	public int selectFaNumByMeNum(Integer me_num) {
		if(me_num == null) {
			return 0;
		}
		FacilityVO facility = businessmanDao.selectFacilityByMeNum(me_num);
		if(facility == null) {
			return 0; 
		}
		return facility.getFa_num();
	}

	@Override
	public List<StadiumVO> getStadiumList() {
		List<StadiumVO> stadiumList = stadiumDao.selectStadiumList();
		//가져오면 반환
		return stadiumList;
	}

	
}
