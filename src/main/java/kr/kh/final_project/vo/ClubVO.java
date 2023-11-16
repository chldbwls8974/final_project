package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class ClubVO {
	private int cl_num;
	private String cl_name;
	private String cl_emblem;
	private int cl_price;
	private String cl_rule;
	private String cl_introduction;
	private int cl_rg_num;
	private String cl_url;
	
	// club_member와 조인할때
	private int cm_num;
	private int cm_me_num;
	private int cm_cl_num;
	private String cm_authority;
	
	private String cl_rg_main;
	
}
