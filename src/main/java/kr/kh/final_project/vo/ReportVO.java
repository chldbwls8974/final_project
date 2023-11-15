package kr.kh.final_project.vo;


import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReportVO {
	private int rp_num;
	private int rp_rc_num;
	private String rp_content;
	private int rp_me_num;
	private int rp_me_num2;
	private String rp_state;
	private Integer rp_bo_num;
	@JsonFormat(pattern="yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date rp_date;
	private int rp_mt_num;
	
	//신고 카테고리
	private int rc_num;
	private String rc_name;
	private String rc_detail;
	
	//회원
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
	
	//회원2
	String me_id2;
}
