package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.PreferredTimeVO;
import kr.kh.final_project.vo.TeamPreferredTimeVO;
import kr.kh.final_project.vo.AccountVO;

public interface TeamPreferredTimeDAO {

	void insertPreferredTime(@Param("pt_num")int pt_num,@Param("cl_num") int cl_num);

	TeamPreferredTimeVO selectTeamTime(@Param("cl_num")Integer cl_num);

	void deletePreferredTime(@Param("cl_num")int cl_num);


}
