package kr.kh.final_project.vo;


import java.sql.Date;

import lombok.Data;

@Data
public class PenaltyVO {
	private int pn_num;
	private String pn_type;
	private int pn_warning;
	private int pn_stop;
	//@JsonFormat(pattern="yyyy-MM-dd")
	private Date pn_end;
	private int pn_me_num;
	
	
}
