package kr.kh.final_project.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import lombok.Data;

@Data
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
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
	Integer me_point;
	int me_state1; 
	int me_state2;
	
	//회원조회 검색필터
	String membertable; //검색타입
	String keyword;		//검색내용
	
	private boolean autoLogin;
	private String me_session_id;
	private Date me_session_limit;
	
	public String getMe_profile() {
		if(me_profile ==null) {
			me_profile = "/resources/profile/basic.jpg";
		}
		return me_profile;
	}
	
}
