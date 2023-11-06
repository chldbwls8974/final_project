package kr.kh.final_project.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.MatchVO;

public interface MatchDAO {

	List<MatchVO> selectMatchListOfManager(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date);

	void updateMatchMtRuleTo1(@Param("mt_num")int mt_num);

	void updateMatchMtRuleTo0(@Param("mt_num")int mt_num);

	List<MatchVO> selectManagerMatchListByMtDate(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date);

	List<MatchVO> selectMatchListOfSolo(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date);
	

}