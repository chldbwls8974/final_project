package kr.kh.final_project.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private int me_num;
	private String me_id;
	private String me_pw;
	private String me_name;
	private String me_nickname;
	private int me_rg_num; 
	private String me_phone;
	private String me_email;
	private String me_gender;
	private Date me_birthday; 
	private String me_authority;
	private int me_rating;
	private String me_profile;
	private String me_tr_name;
	private int me_point; 
	private int me_state1; 
	private int me_state2;
}
