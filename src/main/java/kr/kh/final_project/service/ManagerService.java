package kr.kh.final_project.service;

import java.util.Date;
import java.util.List;

import kr.kh.final_project.vo.MatchVO;

public interface ManagerService {

	boolean insertManagerToMatch(int mt_num, Integer me_num);

	List<MatchVO> selectManagerMatchListByMtDate(Integer me_num, Date mt_date);

	boolean deleteManagerToMatch(int mt_num, Integer me_num);
	
}
