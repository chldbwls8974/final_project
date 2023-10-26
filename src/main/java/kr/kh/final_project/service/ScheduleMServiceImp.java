package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.ExtraDAO;
import kr.kh.final_project.vo.ExtraVO;

@Service
public class ScheduleMServiceImp implements ScheduleMService{
	
	@Autowired
	ExtraDAO extraDao;

	@Override
	public List<ExtraVO> selectThirdWeekDayList() {
		return extraDao.selectThirdWeekDayList();
	}
	
	
}
