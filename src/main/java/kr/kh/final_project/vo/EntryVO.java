package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class EntryVO {
	private int en_num;
	private int en_me_num;
	private int en_te_num;
	
	private String me_nickname;
	private int me_rating;
	private String me_tr_name;
	
	private int ct_cl_num;

	private int te_type;
}
