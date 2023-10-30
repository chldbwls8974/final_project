package kr.kh.final_project.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.TimeVO;

public interface TimeDAO {

	List<TimeVO> selectTimeList();

	List<Integer> selectTiNumListByMtDate(@Param("mt_date")Date mt_date);

}