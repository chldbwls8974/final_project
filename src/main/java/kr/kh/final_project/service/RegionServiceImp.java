package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.vo.RegionVO;

@Service
public class RegionServiceImp implements RegionService{
	@Autowired
	RegionDAO regionDao;

	@Override
	public List<RegionVO> getMainRegion() {
		return regionDao.selectMainRegion();
		
	}

	@Override
	public List<RegionVO> getSubRegion(String rg_main) {
		return regionDao.selectSubRegion(rg_main);
	}


	
}
