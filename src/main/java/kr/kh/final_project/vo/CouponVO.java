package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class CouponVO {
	private int hp_num;
	private int hp_me_num;
	private int hp_cp_num;
	private int hp_invited_num;
	private int hp_state;
	private int cp_sale;
	private String cp_source;
}