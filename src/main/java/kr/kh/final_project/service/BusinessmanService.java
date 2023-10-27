package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;

public interface BusinessmanService {

	List<FacilityVO> getFacilityList();

	BusinessmanVO getBusinessmanByNum(Integer me_num);



}
