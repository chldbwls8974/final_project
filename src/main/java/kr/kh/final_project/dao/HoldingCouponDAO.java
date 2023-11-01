package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.HoldingCouponVO;
import kr.kh.final_project.vo.MemberVO;

public interface HoldingCouponDAO {

	List<HoldingCouponVO> selectMemberCouponList(@Param("user")MemberVO user, @Param("cri")Criteria cri);

	int selectMemberCouPonListCount(@Param("user")MemberVO user);

	void insertSignupCouponOriginalMember(@Param("user")MemberVO dbMember);

	void insertSignupCouponNewMember(@Param("user")MemberVO newMember);


}
