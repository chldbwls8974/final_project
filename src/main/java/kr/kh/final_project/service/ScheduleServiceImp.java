package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.FacilityDAO;
import kr.kh.final_project.dao.OperatingDAO;
import kr.kh.final_project.dao.ScheduleDAO;
import kr.kh.final_project.dao.StadiumDAO;
import kr.kh.final_project.dao.TimeDAO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.OperatingVO;
import kr.kh.final_project.vo.ScheduleVO;
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
	
	@Autowired
	ScheduleDAO scheduleDao;
	
	@Autowired
	FacilityDAO facilityDao;
	
	@Override
	public List<StadiumVO> selectStadiumListByFaNum(int fa_num) {
		if(fa_num == 0) {
			return null;
		}
		return stadiumDao.selectStadiumListByFaNum(fa_num);
	}
	
	@Override
	public List<OperatingVO> selectOperatingListByFaNum(int fa_num) {
		if(fa_num == 0) {
			return null;			
		}
		return operatingDao.selectOperatingListByFaNum(fa_num);
	}

	@Override
	public List<TimeVO> selectTimeList() {
		return timeDao.selectTimeList();
	}

	@Override
	public List<ScheduleVO> selectScheduleListByStNum(Integer st_num) {
		if(st_num == null) {
			return null;
		}
		return scheduleDao.selectScheduleListByStNum(st_num);
	}

	@Override
	public StadiumVO selectStadiumByStNum(Integer st_num) {
		if(st_num == null) {
			return null;
		}
		return stadiumDao.selectStadiumByStNum(st_num);
	}
	
	@Override
	public boolean insertSchedule(ScheduleVO schedule) {
		if(schedule == null
				|| schedule.getSc_st_num() == null
				|| schedule.getSc_ti_num() == null
				|| schedule.getSc_personnel() == null) {
			return false;
		}
		if(scheduleDao.selectSchedule(schedule) != null) {
			return false;
		}
		return scheduleDao.insertSchedule(schedule);
	}

	@Override
	public boolean deleteSchedule(ScheduleVO schedule) {
		if(schedule == null
				|| schedule.getSc_st_num() == null
				|| schedule.getSc_ti_num() == null) {
			return false;
		}
		ScheduleVO dbSchedule = scheduleDao.selectSchedule(schedule);
		if(dbSchedule == null) {
			return false;
		}
		return scheduleDao.deleteSchedule(dbSchedule.getSc_num());
	}

	@Override
	public boolean updateSchedule(ScheduleVO schedule) {
		if(schedule == null
				|| schedule.getSc_st_num() == null
				|| schedule.getSc_ti_num() == null
				|| schedule.getSc_personnel() == null) {
			return false;
		}
		ScheduleVO dbSchedule = scheduleDao.selectSchedule(schedule);
		if(dbSchedule == null) {
			return false;
		}
		return scheduleDao.updateSchedule(dbSchedule.getSc_num(), schedule.getSc_personnel());
	}

	@Override
	public int selectFaNumByMeNum(Integer me_num) {
		if(me_num == null) {
			return 0;
		}
		FacilityVO facility = facilityDao.selectFacilityByMeNum(me_num);
		if(facility == null) {
			return 0; 
		}
		return facility.getFa_num();
	}
}
