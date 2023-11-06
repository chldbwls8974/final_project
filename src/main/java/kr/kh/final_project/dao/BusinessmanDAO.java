package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;

public interface BusinessmanDAO {

	//시설 리스트 가져오기
	List<FacilityVO> selectFacilityList(@Param("member")MemberVO member, @Param("cri")Criteria cri);
	//현재 페이지 정보에 맞는 전체 시설 수 가져오기
	int selectCountFacilityList(@Param("cri")Criteria cri, @Param("member")MemberVO member);
	//회원번호로 사업자정보 가져오기
	BusinessmanVO selectBusinessmanByMeNum(@Param("me_num")Integer me_num);
	//시설 등록
	boolean insertFacility(@Param("facility")FacilityVO facility, @Param("me_num")Integer me_num);
	//시설 정보 수정
	boolean updateFacility(@Param("facility")FacilityVO facility);
	//시설번호로 시설 정보 가져오기
	FacilityVO selectFacility(@Param("fa_num")Integer fa_num);


}
