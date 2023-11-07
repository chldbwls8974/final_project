package kr.kh.final_project.service;

import java.util.Date;
import java.util.List;

import kr.kh.final_project.vo.CouponVO;
import kr.kh.final_project.vo.ExpenseVO;
import kr.kh.final_project.vo.ExtraVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;

public interface MatchService {
	
	List<ExtraVO> selectWeekDayList(int i);

	List<RegionVO> selectMainRegion();

	List<RegionVO> selectSubRegionByMainRegion(int rg_num);

	List<MatchVO> selectMatchListOfManager(Integer me_num, Date mt_date, int rg_num, boolean check);

	List<MatchVO> selectMatchListOfSolo(Integer me_num, Date mt_date, int rg_num, boolean check);

	List<MatchVO> selectMatchListOfClub(Integer me_num, Date mt_date, int rg_num, boolean check);

	MatchVO selectMatchByMtNum(int mt_num, Integer me_num);

	ExpenseVO selectPrice(int type, String ti_day);

	List<CouponVO> selectCouponListByMeNum(Integer me_num);

	boolean applicationMatchSolo(MemberVO user, int mt_num, int point, int hp_num);

	boolean canselMatchSolo(Integer me_num, int mt_num);

}
