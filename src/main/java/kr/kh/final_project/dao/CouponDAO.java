package kr.kh.final_project.dao;

import java.util.List;

import kr.kh.final_project.vo.CouponVO;

public interface CouponDAO {

	List<CouponVO> selectCouponListByMeNum(Integer me_num);

}