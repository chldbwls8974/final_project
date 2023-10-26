package kr.kh.final_project.service;

import java.util.Date;
import java.util.List;

import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.PreferredRegionVO;
import kr.kh.final_project.vo.PreferredTimeVO;

public interface MatchService {

	List<MatchVO> selectMatchListOfManager(Integer me_num, Date mt_date);

	List<PreferredRegionVO> selectPRListByMeNum(Integer me_num);

	List<PreferredTimeVO> selectPTListByMeNum(Integer me_num);

}
