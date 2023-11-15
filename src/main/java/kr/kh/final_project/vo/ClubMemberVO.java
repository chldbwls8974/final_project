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
	private int me_rating;
	private String me_tr_name;
	
	private String cl_name;

  private int en_num;
    
  private int entry_able;
}