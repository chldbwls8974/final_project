package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class ClubMemberVO {
	private int cm_num;
	private int cm_me_num;
	private int cm_cl_num;
	private String cm_authority;
	private String cm_introduction;
	private String me_nickname;
	private String cl_name;
	
}
