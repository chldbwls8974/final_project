package kr.kh.final_project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.ManagerDAO;
import kr.kh.final_project.dao.MatchDAO;

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
			matchDao.updateMatchMtRule(mt_num);
		}
		return res;
	}

	
}
