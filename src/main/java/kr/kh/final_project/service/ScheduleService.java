package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.OperatingVO;
import kr.kh.final_project.vo.StadiumVO;
import kr.kh.final_project.vo.TimeVO;

public interface ScheduleService {

	List<StadiumVO> selectStadiumList(int fa_num);
	
	List<OperatingVO> selectOperatingList(int fa_num);

	List<TimeVO> selectTimeList();
}
