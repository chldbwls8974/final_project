package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.MarkVO;
import kr.kh.final_project.vo.MemberVO;

public interface MarkDAO {

	List<MarkVO> selectMyMarkList(@Param("user")MemberVO user);

	boolean deleteMark(@Param("mark")MarkVO mark);

	boolean insertMark(@Param("mark")MarkVO mark);


}
