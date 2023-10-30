package kr.kh.final_project.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.ManagerDAO;
import kr.kh.final_project.dao.MatchDAO;
import kr.kh.final_project.vo.MatchVO;

@Service
public class ManagerServiceImp implements ManagerService{

	@Autowired
	ManagerDAO managerDao;
	
	@Autowired
	MatchDAO matchDao;
	
	@Override
	public boolean insertManagerToMatch(int mt_num, Integer me_num) {
		if(mt_num == 0 || me_num == null) {
			return false;
		}
		boolean res = managerDao.insertManagerToMatch(mt_num, me_num);
		if(res) {
			matchDao.updateMatchMtRuleTo1(mt_num);
		}
		return res;
	}

	@Override
	public List<MatchVO> selectManagerMatchListByMtDate(Integer me_num, Date mt_date) {
		if(me_num == null || mt_date == null) {
			return null;
		}
		return matchDao.selectManagerMatchListByMtDate(me_num, mt_date);
	}

	@Override
	public boolean deleteManagerToMatch(int mt_num, Integer me_num) {
		if(mt_num == 0 || me_num == null) {
			return false;
		}
		boolean res = managerDao.deleteManagerToMatch(mt_num, me_num);
		if(res) {
			matchDao.updateMatchMtRuleTo0(mt_num);
		}
		return res;
	}

	
}
