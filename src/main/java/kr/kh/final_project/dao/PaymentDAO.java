package kr.kh.final_project.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.vo.PaymentVO;

public interface PaymentDAO {

	PaymentVO getPaymentByImpUid(@Param("impUid")String impUid);

}
