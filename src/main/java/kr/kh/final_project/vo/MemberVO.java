package kr.kh.final_project.vo;

import java.util.Date;
import lombok.Data;

import lombok.Data;

@Data
public class MemberVO {
	int me_num;
	String me_id; 
	String me_pw;
	String me_name;
	String me_nickname;
	int me_rg_num;
	String me_phone; 
	String me_email;
	String me_gender;
	Date me_birthday;
	String me_authority;
	int me_rating; 
	String me_profile; 
	String me_tr_name;
	int me_point;
	int me_state1; 
	int me_state2;
	
	//회원조회 검색필터
	String membertable; //검색타입
	String keyword;		//검색내용
}
