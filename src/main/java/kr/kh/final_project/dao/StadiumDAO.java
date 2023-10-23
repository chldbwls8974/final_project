package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.StadiumVO;

public interface StadiumDAO {

	List<StadiumVO> selectStadiumList(@Param("fa_num")int fa_num);

}
