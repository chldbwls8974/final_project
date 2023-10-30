package kr.kh.final_project.service;

import java.util.Date;
import java.util.List;

import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.RegionVO;

public interface MatchService {
	
	List<ExtraVO> selectThirdWeekDayList();

	List<RegionVO> selectMainRegion();

	List<RegionVO> selectSubRegionByMainRegion(int rg_num);

	List<MatchVO> selectMatchListOfManager(Integer me_num, Date mt_date, int rg_num, boolean check);

}
