package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.QuarterVO;
import kr.kh.final_project.vo.TeamVO;

public interface QuarterDAO {

	List<QuarterVO> selectQuarterListByMtNum(@Param("mt_num")int mt_num);

	boolean insertQuarter(@Param("quarter")QuarterVO quarter);

	boolean updateQuarter(@Param("quarter")QuarterVO quarter);

	boolean deleteQuarter(@Param("qu_num")int qu_num);

	int countQuarterByMtNum(@Param("mt_num")int mt_num);

	int selectWinTeamByQuNum(@Param("qu_num")int qu_num);

	int selectLoseTeamByQuNum(@Param("qu_num")int qu_num);
}