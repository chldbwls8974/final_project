package kr.kh.final_project.service;

import java.util.Date;
import java.util.List;

import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.PreferredRegionVO;
import kr.kh.final_project.vo.PreferredTimeVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.TimeVO;

public interface MatchService {
	
	List<ExtraVO> selectThirdWeekDayList();

	List<MatchVO> selectMatchListOfManager(Integer me_num, Date mt_date);

	List<PreferredRegionVO> selectPRListByMeNum(Integer me_num);

	List<PreferredTimeVO> selectPTListByMeNum(Integer me_num);

	List<RegionVO> selectMainRegion();

	List<RegionVO> selectSubRegionByMainRegion(int rg_num);

	List<RegionVO> selectRegionListByRgNum(int rg_num);

	List<TimeVO> selectTimeListByMtDate(Date mt_date);

}
