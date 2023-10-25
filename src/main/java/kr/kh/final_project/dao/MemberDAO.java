package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.MemberVO;

public interface MemberDAO {

	//List<MemberVO> selectMemberList(int me_num);
	List<MemberVO> selectMemberList(@Param("cri")Criteria cri);

	int selectTotalCount(@Param("cri")Criteria cri);
}
