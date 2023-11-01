package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.StadiumVO;

public interface BusinessmanService {

	List<FacilityVO> getFacilityList(MemberVO member);

	BusinessmanVO getBusinessmanByNum(Integer me_num);

	boolean insertFacility(MemberVO user, FacilityVO facility);

	List<RegionVO> getMainRegion();
	
	List<RegionVO> getSubRegionByMainRegion(String rg_main);

	boolean updateFacility(FacilityVO facility, BusinessmanVO business);

	FacilityVO getFacility(Integer fa_num);

	List<StadiumVO> getStadiumList(Integer fa_num);

	boolean insertStadium(StadiumVO stadium);

	List<FacilityVO> getFacilityNum(Integer fa_num);

	StadiumVO getStadium(Integer st_num);

	boolean updateStadium(StadiumVO stadium);


}
