package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.StadiumVO;

public interface BusinessmanService {

	//시설 리스트 가져오기
	List<FacilityVO> getFacilityList(MemberVO member, Criteria cri);
	//현재 페이지 정보(검색어, 타입)에 맞는 전체 시설 수를 가져옴
	int getTotalCount(Criteria cri, MemberVO member);
	//회원번호로 사업자정보 가져오기
	BusinessmanVO getBusinessmanByMeNum(Integer me_num);
	//시설 등록
	boolean insertFacility(MemberVO user, FacilityVO facility);
	
	List<RegionVO> getMainRegion();
	
	List<RegionVO> getSubRegionByMainRegion(String rg_main);
	//시설 정보 수정
	boolean updateFacility(FacilityVO facility, BusinessmanVO business);
	//시설번호로 시설 정보 가져오기
	FacilityVO getFacility(Integer fa_num);
	
	//시설번호로 경기장 리스트 가져오기
	List<StadiumVO> getStadiumList(Integer fa_num, Criteria cri);
	//경기장 등록
	boolean insertStadium(StadiumVO stadium);
	//경기장번호로 경기장 정보가져오기
	StadiumVO getStadium(Integer st_num);
	//경기장 정보 수정
	boolean updateStadium(StadiumVO stadium);
    //현재 페이지 정보(검색어, 타입)에 맞는 전체 경기장 수를 가져옴
	int getTotalStadiumCount(Criteria cri, Integer fa_num);

}
