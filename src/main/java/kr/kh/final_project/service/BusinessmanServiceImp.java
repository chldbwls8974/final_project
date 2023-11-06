package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.BusinessmanDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.dao.StadiumDAO;
import kr.kh.final_project.pagination.Criteria;
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

	//시설 리스트 가져오기
	@Override
	public List<FacilityVO> getFacilityList(MemberVO member, Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		//다오에게 시설 리스트를 가져오라고 시키고
		List<FacilityVO> list = businessmanDao.selectFacilityList(member, cri);
		//가져오면 반환
		return list;
	}
	//현재 페이지 정보에 맞는 전체 시설 수 가져오는 메서드
	@Override
	public int getTotalCount(Criteria cri, MemberVO member) {
		if(cri == null) {
			cri = new Criteria();
		}
		return businessmanDao.selectCountFacilityList(cri, member);
	}
	//회원번호로 사업자정보 가져오기
	@Override
	public BusinessmanVO getBusinessmanByMeNum(Integer me_num) {
		return businessmanDao.selectBusinessmanByMeNum(me_num);
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
	//Main 지역리스트
	@Override
	public List<RegionVO> getMainRegion() {
		return regionDao.selectMainRegion();
	}
	//Region 리스트
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
		//사업자번호가 같은지 확인 
		if(dbFacility == null || !dbFacility.getFa_bu_num().equals(business.getBu_num())) { 
			return false;
		}
		boolean res = businessmanDao.updateFacility(facility);
		return res;
	}
	//시설번호로 시설 정보 가져오기
	@Override
	public FacilityVO getFacility(Integer fa_num) {
		if(fa_num == null) {
			return null;
		}
		return businessmanDao.selectFacility(fa_num);
	}
	
	//시설번호로 경기장 리스트 가져오기
	@Override
	public List<StadiumVO> getStadiumList(Integer fa_num, Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		List<StadiumVO> stadiumList = stadiumDao.selectStadiumList(fa_num, cri);
		//가져오면 반환
		return stadiumList;
	}
	//현재 페이지 정보(검색어, 타입)에 맞는 전체 경기장 수를 가져옴
	@Override
	public int getTotalStadiumCount(Criteria cri, Integer fa_num) {
		if(cri == null) {
			cri = new Criteria();
		}
		return stadiumDao.selectCountStadiumList(cri, fa_num);
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
	//경기장번호로 경기장 정보가져오기
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
