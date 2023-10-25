package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.RegionVO;

public interface RegionDAO {

	List<RegionVO> selectMainRegion();

	List<RegionVO> selectSubRegion(@Param("rg_main")String rg_main);
}