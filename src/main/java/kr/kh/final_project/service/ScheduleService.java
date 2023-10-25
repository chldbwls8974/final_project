package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.OperatingVO;
import kr.kh.final_project.vo.ScheduleVO;
import kr.kh.final_project.vo.StadiumVO;
import kr.kh.final_project.vo.TimeVO;

public interface ScheduleService {

	List<StadiumVO> selectStadiumListByFaNum(int fa_num);
	
	List<OperatingVO> selectOperatingListByFaNum(int fa_num);

	List<TimeVO> selectTimeList();

	List<ScheduleVO> selectScheduleListByStNum(Integer st_num);

	StadiumVO selectStadiumByStNum(Integer st_num);
	
	boolean insertSchedule(ScheduleVO schedule);

	boolean deleteSchedule(ScheduleVO schedule);

	boolean updateSchedule(ScheduleVO schedule);
}
