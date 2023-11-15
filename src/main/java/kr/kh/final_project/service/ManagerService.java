package kr.kh.final_project.service;

import java.util.Date;
import java.util.List;

import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.QuarterVO;

public interface ManagerService {

	boolean insertManagerToMatch(int mt_num, Integer me_num);

	List<MatchVO> selectManagerMatchListByMtDate(Integer me_num, Date mt_date);

	boolean deleteManagerToMatch(int mt_num, Integer me_num);

	MatchVO selectManageMatchByMtNum(int mt_num);

	boolean updateEntryTeam(int en_num, int te_num);

	boolean resetEntryTeam(int mt_num);

	boolean autoBalanceByMtNum(int mt_num);

	boolean completeTeamByMtNum(int mt_num);

	boolean insertQuarter(QuarterVO quarter);

	boolean updateQuarter(QuarterVO quarter);

	boolean deleteQuarter(int qu_num);
	
}
