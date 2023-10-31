package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;

public interface BusinessmanDAO {

	List<FacilityVO> selectFacilityList(@Param("member")MemberVO member);

	BusinessmanVO selectBusinessmanByNum(@Param("me_num")Integer me_num);

	boolean insertFacility(@Param("facility")FacilityVO facility, @Param("me_num")Integer me_num);

	boolean updateFacility(@Param("facility")FacilityVO facility);

	FacilityVO selectFacility(@Param("fa_num")Integer fa_num);

	List<FacilityVO> selectFacilityNum(@Param("fa_num")Integer fa_num);


}
