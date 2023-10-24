package kr.kh.final_project.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int bo_num;
	private int bo_bt_num;
	private int bo_rg_num;
	private String bo_title;
	private int bo_me_num;
	private Date bo_reg_date;
	private Date bo_up_date;
	private String bo_contents;
	private int bo_count;
	private int bo_comment;
}
