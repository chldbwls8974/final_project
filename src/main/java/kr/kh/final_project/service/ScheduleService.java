package kr.kh.final_project.service;

import java.util.List;

import kr.kh.final_project.vo.StadiumVO;

public interface ScheduleService {

	List<StadiumVO> selectStadiumList(int fa_num);

}
