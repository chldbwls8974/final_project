package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class RegionVO {
	private int rg_num;
	private String rg_main;
	private String rg_sub;
	
	private int pr_rg_num; 
	
	public int getPr_rg_num() {
		pr_rg_num = rg_num;
		return pr_rg_num;
	}
}
