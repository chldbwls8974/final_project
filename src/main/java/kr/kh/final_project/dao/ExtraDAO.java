package kr.kh.final_project.dao;

import java.util.Date;
import java.util.List;

import kr.kh.final_project.vo.ExtraVO;

public interface ExtraDAO {

	List<ExtraVO> selectThirdWeekDayList();

}