package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.StadiumVO;

public interface StadiumDAO {

	List<StadiumVO> selectStadiumListByFaNum(@Param("fa_num")int fa_num);

	StadiumVO selectStadiumByStNum(@Param("st_num")Integer st_num);
	
	//시설번호로 경기장 리스트 가져오기
	List<StadiumVO> selectStadiumList(@Param("fa_num")Integer fa_num);
	//경기장 등록
	boolean insertStadium(@Param("stadium")StadiumVO stadium);
	//경기장번호로 경기장 정보가져오기
	StadiumVO selectStadium(@Param("st_num")Integer st_num);
	//경기장 정보 수정
	boolean updateStadium(@Param("stadium")StadiumVO stadium);
	

}
