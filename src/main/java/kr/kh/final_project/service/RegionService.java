package kr.kh.final_project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.RegionVO;

public interface RegionService {

	List<RegionVO> getMainRegion();

	List<RegionVO> getSubRegion(String rg_main);

	List<RegionVO> getUserRegionList(Integer me_num);

}
