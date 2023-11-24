package kr.kh.final_project.vo;

import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class MemberVO {
	private Integer me_num;
	private String me_id; 
	private String me_pw;
	private String me_name;
	private String me_nickname;
	private int me_rg_num;
	private String me_phone; 
	private String me_email;
	private String me_gender;
	private String me_birthday;
	private String me_authority;
	private int me_rating; 
	private String me_profile; 
	private String me_tr_name;
	private Integer me_point;
	private int me_state1; 
	private int me_state2;
	
	//회원조회 검색필터
	private String membertable; //검색타입
	private String keyword;		//검색내용
	
	private int rg_num;
	private String rg_main;
	private String rg_sub;
	private int pr_num;
	private String pr_me_num;
	private String pr_rg_num;
	private int ti_num;
	private String ti_day;
	
	private Time ti_time;
	
	private int pt_num;
	private int pt_ti_num;
	private int pt_me_num;
	
	
	private boolean autoLogin;
	private String me_session_id;
	private Date me_session_limit;
	
	
	private String me_rg_main;
	
	
    private List<PreferredTimeVO> preferTimeList;
    private List<PreferredRegionVO> preferRegionList;
	
	public String getMe_profile() {
		if(me_profile ==null) {
			me_profile = "/basic.jpg";
		}
		return me_profile;
	}
	
	
}
