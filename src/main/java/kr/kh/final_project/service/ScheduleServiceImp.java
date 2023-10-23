package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.OperatingDAO;
import kr.kh.final_project.dao.StadiumDAO;
import kr.kh.final_project.dao.TimeDAO;
import kr.kh.final_project.vo.OperatingVO;
import kr.kh.final_project.vo.StadiumVO;
import kr.kh.final_project.vo.TimeVO;

@Service
public class ScheduleServiceImp implements ScheduleService{
	
	@Autowired
	StadiumDAO stadiumDao;
	
	@Autowired
	OperatingDAO operatingDao;
	
	@Autowired
	TimeDAO timeDao;
	
	@Override
	public List<StadiumVO> selectStadiumList(int fa_num) {
		if(fa_num == 0) {
			return null;
		}
		return stadiumDao.selectStadiumList(fa_num);
	}
	
	@Override
	public List<OperatingVO> selectOperatingList(int fa_num) {
		if(fa_num == 0) {
			return null;			
		}
		return operatingDao.selectOperatingList(fa_num);
	}

	@Override
	public List<TimeVO> selectTimeList() {
		return timeDao.selectTimeList();
	}
}
