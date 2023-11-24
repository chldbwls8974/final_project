package kr.kh.final_project.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;

public interface MatchDAO {

	List<MatchVO> selectMatchListOfManager(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date);
	//친선전
	void updateMatchMtRuleTo1(@Param("mt_num")int mt_num);
	//경쟁전
	void updateMatchMtRuleTo0(@Param("mt_num")int mt_num);
	//개인 매치 & 클럽 매치 조회 가능
	void updateMatchMtTypeTo0(@Param("mt_num")int mt_num);
	//개인 매치 조회 가능
	void updateMatchMtTypeTo1(@Param("mt_num")int mt_num);
	//클럽 매치 조회 가능
	void updateMatchMtTypeTo2(@Param("mt_num")int mt_num);
	//등록된 매치(조회가능)
	void updateMatchMtState1To0(@Param("mt_num")int mt_num);
	//삭제된 매치(조회 불가능)
	void updateMatchMtState1To1(@Param("mt_num")int mt_num);
	//종료된 매치(전적 조회용)
	boolean updateMatchMtState1To2(@Param("mt_num")int mt_num);
	//한번이라도 신청된 매치(포인트 내역의 참조키로 필요)
	void updateMatchMtState2To1(@Param("mt_num")int mt_num);

	List<MatchVO> selectManagerMatchListByMtDate(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date);

	List<MatchVO> selectMatchListOfSolo(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date);

	MatchVO selectMatchByMeNum(@Param("mt_num")int mt_num, @Param("me_num")Integer me_num);

	List<MatchVO> selectMatchListOfClub(@Param("cl_num")int me_num, @Param("mt_date")Date mt_date);

	MatchVO selectMatchByClNum(@Param("mt_num")int mt_num, @Param("cl_num")int cl_num);

	void deleteMatch();

	List<MatchVO> selectLimitMatch();

	List<MatchVO> selectMatchSolo();
	
	List<MatchVO> selectMatchClub();
	
	List<MatchVO> selectEndMatch();
	
	MatchVO selectManageMatchByMtNum(@Param("mt_num")int mt_num);
	
	List<MatchVO> selectMyMatchListByMeNum(@Param("me_num")Integer me_num);
	
	List<MatchVO> selectMyRecored(@Param("me_num")Integer me_num);
	
	MatchVO selectMatchRecord(@Param("mt_num")int mt_num, @Param("te_num")int te_num);
	
	int selectAbleSolo(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date, @Param("mt_num")int mt_num);

	List<MatchVO> selectManagerAble0ByMtDate(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date);
	
	List<MatchVO> selectManagerAble23ByMtDate(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date);
	
	List<MatchVO> selectSoloMatchAble0ByMtDate(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date);
	
	List<MatchVO> selectSoloMatchAble23ByMtDate(@Param("me_num")Integer me_num, @Param("mt_date")Date mt_date);
	
	int selectAbleClub(@Param("cl_num")Integer cl_num, @Param("mt_date")Date mt_date, @Param("mt_num")int mt_num);
	
	List<MatchVO> selectClubMatchAble0ByMtDate(@Param("cl_num")Integer cl_num, @Param("mt_date")Date mt_date);
	
	List<MatchVO> selectClubMatchAble23ByMtDate(@Param("cl_num")Integer cl_num, @Param("mt_date")Date mt_date);
	
	MatchVO selectDBMatchByMtNum(@Param("mt_num")int mt_num);
	
	void selectMatchByStAvailable(@Param("st_num")Integer st_num);
	
	List<MatchVO> selectMatchByStNumAll(@Param("st_num")int st_num);
	
	List<MatchVO> selectMatchByStNumSolo(@Param("st_num")int st_num);
	
	List<MatchVO> selectMatchByStNumClub(@Param("st_num")int st_num);
	
	void deleteMatchByMtNum(@Param("mt_num")int mt_num);
	
	List<MatchVO> selectMatchByAvBefore(@Param("st_num")int st_num, @Param("av_notdate")Date av_notdate);
	
	List<MatchVO> selectMatchByAvAfter(@Param("st_num")int st_num, @Param("av_notdate")Date av_notdate);
	
}