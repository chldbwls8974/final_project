package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityPictureVO;
import kr.kh.final_project.vo.ManagerVO;

public interface BusinessDAO {

	// 사업자신청 조회하기
	List<ManagerVO> selectBusinessList(@Param("cri")Criteria cri);

	// 사업자신청 수락버튼 (권한 바꾸기)
	boolean updateBusinessByAuthority(@Param("manager")ManagerVO manager);

	// 사업자신청 총 갯수 가져오기
	int selectTotalCount(@Param("cri")Criteria cri);

	
	// 사업자 조회하기
	List<ManagerVO> selectBusinessList2(@Param("cri")Criteria cri);

	// 사업자 취소버튼( 권한 바꾸기 )
	boolean updateBusinessByAuthority2(@Param("manager")ManagerVO manager);
	// 사업자 신청 게시글 삭제하기
	boolean deleteBoardBusinessList(@Param("manager")ManagerVO manager);

	// 사업자 총 수 가져오기
	int selectTotalCount2(@Param("cri")Criteria cri);

	// 사업자 관리자가 등록한 리스트 가져오기(3)
	List<BusinessmanVO> selectBusinessListByInsert(@Param("cri")Criteria cri);
	// 사업자 총 갯수 가져오기 (3)
	int selectTotalCountByBusiness(@Param("cri")Criteria cri);
	// 사업자 관리자가 등록하기 
	boolean insertBusiness(@Param("bu")BusinessmanVO businessman);
	// 수정할 사업자 가져오기 (3)
	BusinessmanVO selectBusinessList3(@Param("bu_num")Integer bu_num);
	// 사업자 수정하기 (3)
	boolean updateBusiness(@Param("businessman")BusinessmanVO businessman);
	// 사업자 삭제하기 (3)
	boolean deleteBusinessList(@Param("bu_num")Integer bu_num);

	BusinessmanVO selectBusinessManByFaBuNum(@Param("fa_bu_num")Integer fa_bu_num);
	
}
