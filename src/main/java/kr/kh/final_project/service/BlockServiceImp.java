package kr.kh.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.BlockDAO;
import kr.kh.final_project.vo.BlockVO;

@Service
public class BlockServiceImp implements BlockService{
	
	@Autowired
	BlockDAO blockDao;
	
	
	String uploadPath = "D:\\uploadfiles";

	//차단된 회원명단 가져오기
	@Override
	public List<BlockVO> getBlockList(Integer me_num) {
		
		return blockDao.selectBlockList(me_num);
	}



	
}
