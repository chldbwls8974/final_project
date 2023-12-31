package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.BlockVO;
import kr.kh.final_project.vo.MatchVO;
import kr.kh.final_project.vo.MemberVO;

public interface MemberDAO {

	
	List<MemberVO> selectMemberListBySearch(@Param("cri")Criteria cri);

	int selectTotalCount(@Param("cri")Criteria cri);
	
	MemberVO selectManager(@Param("me_num")Integer me_num);

	List<MemberVO> searchMemberById(String keyword);

	List<MemberVO> searchMemberByName(String keyword);

	List<MemberVO> selectMemberList();
	
	MemberVO selectMember(@Param("me_id")String me_id);
	
	MemberVO selectMemberByEmail(@Param("me_email")String email);

	boolean insertMember(@Param("m")MemberVO member);

	MemberVO selectMemberByNickName(@Param("check")String check);

	void updateMemberSession(@Param("user")MemberVO user);

	MemberVO selectMemberBySession(String me_session_id);

	boolean updateMemberPoint(@Param("user")MemberVO user);

	MemberVO selectMemberByNum(@Param("me_num")int me_num);
	
	MemberVO selectMemberNumByNick2(String check);

	boolean updateMemberProfile(@Param("user")MemberVO user);

	void updateFile(@Param("file")MultipartFile file);

	MemberVO selectMemberByKaKao(@Param("me_id")String me_id);

	MemberVO selectMemberRegion(@Param("user") MemberVO user);

	void updateEmailMember(@Param("me_id")String me_id);

	boolean updateUserBoardBanState(@Param("me_num")int me_num, @Param("i")int i);

	boolean updateUserMatchBanState(@Param("me_num")int me_num, @Param("i")int i);

	void updateMember(@Param("m")MemberVO member, @Param("fi_name")String fi_name);

	boolean updateEmail(@Param("me_num")int me_num,@Param("email") String email);
	
	void updateMemberPoint2(@Param("point")int difference_point, @Param("me_num")int me_num);

	boolean updateRatingWinByMeNum(@Param("me_num")int me_num);

	boolean updateRatingLoseByMeNum(@Param("me_num")int me_num);

	MemberVO selectManagerByMtNum(@Param("mt_num")int mt_num);

	MemberVO selectBusinessByMtNum(@Param("mt_num")int mt_num);
}
