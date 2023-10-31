package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.ManagerVO;

public interface ManagerDAO {
	
	List<ManagerVO> selectManagerList(@Param("cri")Criteria cri);
	// 회원정보를 담고 있는 List<MemberVO>
	// @Param을 사용하여 'cri' 매개변수를 사용할 때, 어떤 이름으로 참조할지 지정
	//List<MemberVO> selectMemberList(@Param("cri")Criteria cri);

	// 매니저신청 수락버튼 (권한 MANAGER로 바꾸기)
	boolean updateManagerByAuthority(@Param("manager")ManagerVO manager);
	// 매니저신청 totalCount 가져오라고 하기
	int selectTotalCount(@Param("cri")Criteria cri);
	
	
	// 매니저 조회
	List<ManagerVO> selectManagerList2(@Param("cri")Criteria cri);
	// 매니저 권한 삭제버튼 (권한 USER로 바꾸기)
	boolean updateManagerByAuthority2(@Param("manager")ManagerVO manager);
	// 매니저 totalCount 가져오라고 하기
	int selectTotalCount2(@Param("cri")Criteria cri);
	
	
}
