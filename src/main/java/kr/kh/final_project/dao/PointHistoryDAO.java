package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.PointHistoryVO;

public interface PointHistoryDAO {

	boolean insertPointHistory(@Param("pointHistory")PointHistoryVO pointHistory);

	List<PointHistoryVO> selectPointRefundHistoryByUserNum(@Param("user")MemberVO user, @Param("cri")Criteria cri);

	boolean deleteRefundPointHistory(@Param("pointHistory") PointHistoryVO ph);

	PointHistoryVO selectPointHistoryByNum(@Param("ph_num")int ph_num);

	boolean insertPointHistoryApplicationMatch(@Param("point")int point, @Param("mt_num")int mt_num, @Param("me_num")Integer me_num);
	
	boolean insertPointHistoryCanselMatch(@Param("point")int point, @Param("mt_num")int mt_num, @Param("me_num")Integer me_num);

	PointHistoryVO selectPointHistoryApplicationMatch(@Param("me_num")Integer me_num, @Param("mt_num")int mt_num);

	boolean insertPointHistoryTimeOverMatch(@Param("point")int point, @Param("mt_num")int mt_num, @Param("me_num")Integer me_num);
	
	int selectRefundCount(@Param("user")MemberVO user);

	List<PointHistoryVO> selectPointRefundHistoryBySearch(@Param("cri")Criteria cri, @Param("searchType1")String searchType1, @Param("searchType2")String searchType2);

	int selectPointRefundHistoryCountBySearch(@Param("cri")Criteria cri,  @Param("searchType1")String searchType1,  @Param("searchType2")String searchType2);

	boolean updateRefundApproval(@Param("ph")PointHistoryVO ph);

	boolean insertPointHistoryByPayment(@Param("ph")PointHistoryVO ph);

}
