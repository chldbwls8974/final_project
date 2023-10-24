package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.ScheduleVO;
import kr.kh.final_project.vo.StadiumVO;

public interface ScheduleDAO {

	ScheduleVO selectSchedule(@Param("schedule")ScheduleVO schedule);

	boolean insertSchedule(@Param("schedule")ScheduleVO schedule);

	List<ScheduleVO> selectScheduleListByStNum(@Param("st_num")Integer st_num);

	boolean deleteSchedule(@Param("sc_num")int sc_num);

}
