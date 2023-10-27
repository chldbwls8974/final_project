package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.FacilityVO;

public interface BusinessmanDAO {

	List<FacilityVO> selectFacilityList();

}
