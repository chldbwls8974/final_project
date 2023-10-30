package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.ExtraVO;

public interface ExtraDAO {

	List<ExtraVO> selectWeekDayList(@Param("i")int i);

}