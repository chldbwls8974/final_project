package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.StadiumVO;

public interface StadiumDAO {

	List<StadiumVO> selectStadiumListByFaNum(@Param("fa_num")int fa_num);

	StadiumVO selectStadiumByStNum(@Param("st_num")Integer st_num);
	
	//시설번호로 경기장 리스트 가져오기
	List<StadiumVO> selectStadiumList(@Param("fa_num")Integer fa_num, @Param("cri")Criteria cri);
	//현재 페이지 정보(검색어, 타입)에 맞는 전체 경기장 수를 가져옴
	int selectCountStadiumList(@Param("cri")Criteria cri, @Param("fa_num")Integer fa_num);
	//경기장 등록
	boolean insertStadium(@Param("stadium")StadiumVO stadium);
	//경기장번호로 경기장 정보가져오기
	StadiumVO selectStadium(@Param("st_num")Integer st_num);
	//경기장 정보 수정
	boolean updateStadium(@Param("stadium")StadiumVO stadium);
	//시설 삭제 시 경기장 삭제(화면에서만)
	void updateStadiumAvailability(@Param("fa_num")Integer fa_num);
	
	//경기장 리스트 가져오기(관리자)
	List<StadiumVO> selectStadiumListByAdmin(@Param("fa_num")Integer fa_num, @Param("cri")Criteria cri);
	//경기장 페이지네이션(관리자)
	int selectCountStadiumListByAdmin(@Param("cri")Criteria cri, @Param("fa_num")Integer fa_num);
	//경기장 정보수정(관리자)
	boolean updateStadiumByAdmin(StadiumVO stadium);

	List<StadiumVO> selectAllStadiumList();
	

}
