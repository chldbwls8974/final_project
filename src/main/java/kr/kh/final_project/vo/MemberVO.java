package kr.kh.final_project.vo;

import java.util.Date;

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
	
	public MemberVO(int i, String string, String string2, String string3, String string4, int j, String string5,
			String string6, String string7, String string8, String string9, int k, String string10, String string11,
			int l, int m, int n) {
		// TODO Auto-generated constructor stub
	}
}
