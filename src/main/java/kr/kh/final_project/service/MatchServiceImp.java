package kr.kh.final_project.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.MatchDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.PreferredTimeDAO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.PreferredRegionVO;
import kr.kh.final_project.vo.PreferredTimeVO;

@Service
public class MatchServiceImp implements MatchService{
	
	@Autowired
	MatchDAO matchDao;
	
	@Autowired
	PreferredRegionDAO PreferredRegionDao;
	
	@Autowired
	PreferredTimeDAO PreferredTimeDao;

	@Override
	public List<MatchVO> selectMatchListOfManager(Integer me_num, Date mt_date) {
		if(me_num == null || mt_date == null) {
			return null;
		}
		return matchDao.selectMatchListOfManager(me_num, mt_date);
	}

	@Override
	public List<PreferredRegionVO> selectPRListByMeNum(Integer me_num) {
		if(me_num == null) {
			return null;
		}
		return PreferredRegionDao.selectPRListByMeNum(me_num);
	}

	@Override
	public List<PreferredTimeVO> selectPTListByMeNum(Integer me_num) {
		if(me_num == null) {
			return null;
		}
		return PreferredTimeDao.selectPTListByMeNum(me_num);
	}
	
	
}
