package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;

public interface BusinessmanDAO {

	List<FacilityVO> selectFacilityList();

	BusinessmanVO seletBusinessmanByNum(@Param("me_num")Integer me_num);

	boolean insertFacility(@Param("facility")FacilityVO facility);

}
