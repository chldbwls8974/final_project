package kr.kh.final_project.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PointHistoryVO {
	private int ph_num;
	private int ph_price;
	private int ph_source;
	private int ph_mt_num;
	private int ph_me_num;
	private Date ph_date;
	
	//memberVO
	Integer me_num;
	String me_id; 
	String me_pw;
	String me_name;
	String me_nickname;
	int me_rg_num;
	String me_phone; 
	String me_email;
	String me_gender;
	String me_birthday;
	String me_authority;
	int me_rating; 
	String me_profile; 
	String me_tr_name;
	Integer me_point;
	int me_state1; 
	int me_state2;
	private String me_session_id;
	private Date me_session_limit;
	
	//acountVO
	private int ac_me_num;
	private String ac_ba_name;
	private String ac_me_name;
	private String ac_num;
}
