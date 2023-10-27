package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.BusinessmanDAO;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityVO;

@Service
public class BusinessmanServiceImp implements BusinessmanService{

	@Autowired
	BusinessmanDAO businessmanDao;

	@Override
	public List<FacilityVO> getFacilityList() {
		List<FacilityVO> list = businessmanDao.selectFacilityList();
		return list;
	}

	@Override
	public BusinessmanVO getBusinessmanByNum(Integer me_num) {
		return businessmanDao.seletBusinessmanByNum(me_num);
	}
	
	
}
