package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.EntryVO;

public interface EntryDAO {

	EntryVO selectEntryByMeNum(@Param("te_num")int te_num, @Param("me_num")Integer me_num);

	boolean insertEntry(@Param("te_num")int te_num, @Param("me_num")Integer me_num);

	boolean deleteEntry(@Param("en_num")int en_num);

	void deleteEntryByTeNum(@Param("te_num")int te_num);

	List<EntryVO> selectEntryByMtNum(@Param("mt_num")int mt_num);

	boolean insertEntryClub(@Param("me_num")int me_num, @Param("cl_num")int cl_num, @Param("mt_num")int mt_num);

	boolean deleteEntryClub(@Param("en_num")int en_num);

}