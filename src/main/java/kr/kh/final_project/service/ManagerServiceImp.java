package kr.kh.final_project.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.EntryDAO;
import kr.kh.final_project.dao.ManagerDAO;
import kr.kh.final_project.dao.MatchDAO;
import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.dao.QuarterDAO;
import kr.kh.final_project.dao.TeamDAO;
import kr.kh.final_project.vo.EntryVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.QuarterVO;
import kr.kh.final_project.vo.TeamVO;

@Service
public class ManagerServiceImp implements ManagerService{

	@Autowired
	ManagerDAO managerDao;
	
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	MatchDAO matchDao;
	
	@Autowired
	EntryDAO entryDao;
	
	@Autowired
	TeamDAO teamDao;

	@Autowired
	QuarterDAO quarterDao;
	
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
	public MatchVO selectManageMatchByMtNum(int mt_num) {
		if(mt_num == 0) {
			return null;
		}
		return matchDao.selectManageMatchByMtNum(mt_num);
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

	@Override
	public boolean updateEntryTeam(int en_num, int te_num) {
		if(en_num == 0 || te_num == 0) {
			return false;
		}
		return entryDao.updateEntryTeam(en_num, te_num);
	}
	
	@Override
	public boolean resetEntryTeam(int mt_num) {
		if(mt_num == 0) {
			return false;
		}
		TeamVO listTeam = teamDao.selectListTeamByMtNum(mt_num);
		List<EntryVO> entryList = entryDao.selectEntryByMtNum(mt_num);
		boolean res = true;
		for(EntryVO entry : entryList) {
			if(!entryDao.updateEntryTeam(entry.getEn_num(), listTeam.getTe_num())) {
				res = false;
			}
		}
		return res;
	}
	
	@Override
	public boolean autoBalanceByMtNum(int mt_num) {
		if(mt_num == 0) {
			return false;
		}
		List<TeamVO> teamList = teamDao.selectTeamByMtNum(mt_num);
		List<EntryVO> entryList = entryDao.selectEntryByMtNum(mt_num);
		
		boolean res = true;
		int count = 0;
		for(EntryVO entry : entryList) {
			if(((count / 3) % 2) == 0) {
				for(TeamVO team : teamList) {
					if(team.getTe_type() == ((count % 3) + 1)) {
						if(!entryDao.updateEntryTeam(entry.getEn_num(), team.getTe_num())) {
							res = false;
						}
					}
				}
			}else {
				for(TeamVO team : teamList) {
					if(team.getTe_type() == (3 - (count % 3))) {
						if(!entryDao.updateEntryTeam(entry.getEn_num(), team.getTe_num())) {
							res = false;
						}
					}
				}
			}
			count++;
		}
		return res;
	}
	
	@Override
	public boolean completeTeamByMtNum(int mt_num) {
		if(mt_num == 0) {
			return false;
		}
		TeamVO listTeam = teamDao.selectListTeamByMtNum(mt_num);
		if(listTeam.getEntry_count() != 0) {
			return false;
		}
		return teamDao.deleteTeam(listTeam.getTe_num());
	}
	@Override
	public boolean insertQuarter(QuarterVO quarter) {
		if(quarter.getQu_mt_num() == 0 || quarter.getQu_te_num1() == 0 || quarter.getQu_te_num2() == 0) {
			return false;
		}
		boolean res = true;
		//경기 등록
		if(!quarterDao.insertQuarter(quarter)) {
			res = false;
		}
		return res;
	}

	@Override
	public boolean updateQuarter(QuarterVO quarter) {
		if(quarter.getQu_num() == 0
				|| quarter.getQu_mt_num() == 0
				|| quarter.getQu_te_num1() == 0
				|| quarter.getQu_te_num2() == 0) {
			return false;
		}
		return quarterDao.updateQuarter(quarter);
	}
	
	@Override
	public boolean deleteQuarter(int qu_num) {
		if(qu_num == 0) {
			return false;
		}
		return quarterDao.deleteQuarter(qu_num);
	}
}
