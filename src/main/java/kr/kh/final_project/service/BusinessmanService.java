package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.StadiumVO;

public interface BusinessmanService {

	List<FacilityVO> getFacilityList();

	BusinessmanVO getBusinessmanByNum(Integer me_num);

	boolean insertFacility(MemberVO user, FacilityVO facility, int fa_num);

	List<RegionVO> getMainRegion();

	List<RegionVO> getSubRegionByMainRegion(String rg_main);

	int selectFaNumByMeNum(Integer me_num);

	List<StadiumVO> getStadiumList();




}
