package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class PaymentVO {

	private String pm_imp_uid; // 결제 식별자
	private Integer pm_amount; //결제 금액
	private Integer pm_ph_num;	//포인트내역번호
	
}
