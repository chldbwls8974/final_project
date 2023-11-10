package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.EntryVO;

public interface EntryDAO {

	EntryVO selectEntryByMeNum(@Param("te_num")int te_num, @Param("me_num")Integer me_num);

	boolean insertEntry(@Param("te_num")int te_num, @Param("me_num")Integer me_num);

	boolean deleteEntry(@Param("en_num")int en_num);

	void deleteEntryByTeNum(@Param("te_num")int te_num);

}