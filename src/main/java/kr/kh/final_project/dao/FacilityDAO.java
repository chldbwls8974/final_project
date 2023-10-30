package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.FacilityVO;

public interface FacilityDAO {

	List<FacilityVO> selectFacilityByMeNum(@Param("me_num")Integer me_num);

}
