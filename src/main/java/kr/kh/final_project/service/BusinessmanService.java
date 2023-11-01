package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;

public interface BusinessmanService {

	List<FacilityVO> getFacilityList();

	BusinessmanVO getBusinessmanByNum(Integer me_num);

	boolean insertFacility(BusinessmanVO business, MemberVO user, FacilityVO facility);

	List<RegionVO> getMainRegion();

	List<RegionVO> getSubRegionByMainRegion(String rg_main);



}
