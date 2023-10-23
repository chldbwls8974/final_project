package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.StadiumDAO;
import kr.kh.final_project.vo.StadiumVO;

@Service
public class ScheduleServiceImp implements ScheduleService{
	
	@Autowired
	StadiumDAO stadiumDao;

	@Override
	public List<StadiumVO> selectStadiumList(int fa_num) {
		if(fa_num == 0) {
			return null;			
		}
		return stadiumDao.selectStadiumList(fa_num);
	}
	
	
}
