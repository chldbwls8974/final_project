package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.CouponVO;

public interface CouponDAO {

	List<CouponVO> selectCouponListByMeNum(Integer me_num);

	boolean deleteCoupon(@Param("hp_num")int hp_num);

}