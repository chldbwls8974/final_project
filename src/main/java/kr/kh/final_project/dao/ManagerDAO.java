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

	// 매니저신청 수락버튼 (권한 바꾸기)
	boolean updateManagerByAuthority(@Param("manager")ManagerVO manager);
	
	
}
