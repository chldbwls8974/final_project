package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.PointHistoryVO;

public interface PointHistoryDAO {

	boolean insertPointHistory(@Param("pointHistory")PointHistoryVO pointHistory);

}
