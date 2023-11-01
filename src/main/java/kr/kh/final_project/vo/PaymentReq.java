package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class PaymentReq {
	//결제 요청
	private String imp_uid;
	private String merchant_uid;
	private String amount;
	private Integer me_num;
}
