package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class ExpenseVO {
	private int ex_num;
	private int ex_price;
	private int ex_pre;
	private String ex_date;
}