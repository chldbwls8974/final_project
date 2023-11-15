package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class TeamVO {
	private int te_num;
	private int te_mt_num;
	private int te_type;

	private int entry_count;
	private int club_entry_count;

	private int mt_num;
	private int mt_type;
	private int mt_rule;
	private int mt_personnel;
	
	private int ct_te_num;
	private int ct_cl_num;

	private int cl_num;
	private String cl_name;
}