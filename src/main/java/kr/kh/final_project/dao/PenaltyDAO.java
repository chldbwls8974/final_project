package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.PenaltyVO;

public interface PenaltyDAO {

	List<PenaltyVO> selectPenaltyByMemberNum(@Param("me_num")int me_num);




}
