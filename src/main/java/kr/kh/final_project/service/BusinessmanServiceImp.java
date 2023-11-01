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
import kr.kh.final_project.vo.ScheduleVO;
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
	public List<FacilityVO> getFacilityList(MemberVO member) {
		//다오에게 시설 리스트를 가져오라고 시키고
		List<FacilityVO> list = businessmanDao.selectFacilityList(member);
		//가져오면 반환
		return list;
	}

	@Override
	public BusinessmanVO getBusinessmanByNum(Integer me_num) {
		return businessmanDao.selectBusinessmanByNum(me_num);
	}
	
	//시설 등록
	@Override
	public boolean insertFacility(MemberVO user, FacilityVO facility) {
		//System.out.println(facility);
		//예외처리
		if(user == null
			|| facility == null
			|| facility.getFa_name() == null 
			|| facility.getFa_add() == null
			|| facility.getFa_add_detail() == null
			|| facility.getFa_phone() == null) {
			return false;
		}
		boolean res = businessmanDao.insertFacility(facility, user.getMe_num());
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

	//시설 정보 수정
	@Override
	public boolean updateFacility(FacilityVO facility, BusinessmanVO business) {
		if(business == null || business.getBu_me_num() == 0) {
			return false;
		}
		if(facility == null || facility.getFa_bu_num() == null) {
			return false;
		}
		//시설 번호를 이용하여 시설 정보를 가져옴
		FacilityVO dbFacility = businessmanDao.selectFacility(facility.getFa_num());
		//시설 정보에서 회원번호와 로그인한 회원 정보가 같은지 확인 
		if(dbFacility == null || !dbFacility.getFa_bu_num().equals(business.getBu_num())) { 
			return false;
		}
		boolean res = businessmanDao.updateFacility(facility);
		return res;
	}
	
	@Override
	public FacilityVO getFacility(Integer fa_num) {
		if(fa_num == null) {
			return null;
		}
		return businessmanDao.selectFacility(fa_num);
	}

	@Override
	public List<StadiumVO> getStadiumList(Integer fa_num) {
		List<StadiumVO> stadiumList = stadiumDao.selectStadiumList(fa_num);
		//가져오면 반환
		return stadiumList;
	}
	
	//경기장 등록
	@Override
	public boolean insertStadium(StadiumVO stadium) {
		if(stadium== null 
			|| stadium.getSt_name() == null 
			|| stadium.getSt_locate() == null
			|| stadium.getSt_width() == 0 
			|| stadium.getSt_height() == 0
			|| stadium.getSt_max() == 0		
			|| stadium.getSt_fa_num() == 0) {
			return false;
		}
		return stadiumDao.insertStadium(stadium);
	}

	@Override
	public List<FacilityVO> getFacilityNum(Integer fa_num) {
		if(fa_num == 0) {
			return null;
		}
		return businessmanDao.selectFacilityNum(fa_num);
	}

	@Override
	public StadiumVO getStadium(Integer st_num) {
		if(st_num == null) {
			return null;
		}
		return stadiumDao.selectStadium(st_num);
	}
	
	//경기장 정보 수정
	public boolean updateStadium(StadiumVO stadium) {
		if(stadium == null || stadium.getSt_num() == null) {
			return false;
		}
		//경기장 번호를 이용하여 경기장 정보를 가져옴
		StadiumVO dbStadium = stadiumDao.selectStadium(stadium.getSt_num());
		//경기장 정보에서 경기장의 시설 번호와 시설 번호가 같은지 확인 
		if(dbStadium == null) { 
			return false;
		}
		boolean res = stadiumDao.updateStadium(stadium);
		return res;
	}
	
	
	
}
