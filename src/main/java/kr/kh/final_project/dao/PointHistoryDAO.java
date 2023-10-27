package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;

public interface PointHistoryDAO {

	boolean insertPointHistory(@Param("pointHistory")PointHistoryVO pointHistory);

	List<PointHistoryVO> selectPointRefundHistoryByUserNum(@Param("user")MemberVO user);

	boolean deleteRefundPointHistory(@Param("pointHistory") PointHistoryVO ph);

	PointHistoryVO selectPointHistoryByNum(@Param("ph_num")int ph_num);

}
