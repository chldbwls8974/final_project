package kr.kh.final_project.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberVO {
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
	int me_point;
	int me_state1; 
	int me_state2;
	private boolean autoLogin;
	private String me_session_id;
	private Date me_session_limit;
	
	public MemberVO(Integer me_num, String me_id, String me_pw, String me_name, String me_nickname, int me_rg_num,
			String me_phone, String me_email, String me_gender, String me_birthday, String me_authority, int me_rating,
			String me_profile, String me_tr_name, int me_point, int me_state1, int me_state2) {
		super();
		this.me_num = me_num;
		this.me_id = me_id;
		this.me_pw = me_pw;
		this.me_name = me_name;
		this.me_nickname = me_nickname;
		this.me_rg_num = me_rg_num;
		this.me_phone = me_phone;
		this.me_email = me_email;
		this.me_gender = me_gender;
		this.me_birthday = me_birthday;
		this.me_authority = me_authority;
		this.me_rating = me_rating;
		this.me_profile = me_profile;
		this.me_tr_name = me_tr_name;
		this.me_point = me_point;
		this.me_state1 = me_state1;
		this.me_state2 = me_state2;
	}
}
