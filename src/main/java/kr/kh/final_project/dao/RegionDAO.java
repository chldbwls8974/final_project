package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.RegionVO;

public interface RegionDAO {

	List<RegionVO> selectMainRegion();

	List<RegionVO> selectSubRegion(@Param("rg_main")String rg_main);

	List<RegionVO> selectMainRegion2();

	List<RegionVO> selectSubRegionByMainRegion(@Param("rg_num")int rg_num);

	List<Integer> selectRgNumSubAll();

	List<Integer> selectSubRgNumByMainRgNum(@Param("rg_num")int rg_num);

	List<Integer> selectRgNumByRgNum(@Param("rg_num")int rg_num);
	
	List<RegionVO> selectRegionByRgNum(@Param("rg_num")int rg_num);

	List<RegionVO> selectMemberRegion();

	List<RegionVO> selectUserRegion(Integer me_num);
}
