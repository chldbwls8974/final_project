package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class HoldingCouponVO {
	private int hp_num;
	private int hp_me_num;
	private int hp_cp_num;
	private Integer hp_invited_num;
	private int hp_state;
	
	//CouponVO
	private int cp_num;
	private int cp_sale;
	private String cp_source;
	
	//추천인 닉네임
	private String hp_invited_nickname;
}
