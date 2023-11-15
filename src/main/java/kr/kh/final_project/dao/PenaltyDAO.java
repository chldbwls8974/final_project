package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.PenaltyVO;

public interface PenaltyDAO {

	List<PenaltyVO> selectPenaltyByMemberNum(@Param("me_num")int me_num);

	PenaltyVO selectPenaltyByMemberNumAndType(@Param("me_num")int me_num, @Param("rc_name")String rc_name);
	
	void insertNewPenalty(@Param("me_num")int me_num, @Param("pn_type")String pn_type);

	boolean updatePenalty(@Param("penalty")PenaltyVO penalty);





}
