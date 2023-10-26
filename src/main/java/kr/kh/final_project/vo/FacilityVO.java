package kr.kh.final_project.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FacilityVO {
	private int fa_num;
	private int fa_bu_num;
	private int fa_rg_num;
	private String fa_name;
	private String fa_add;
	private String fa_add_detail;
	private String fa_phone;
	private int fa_pay;
	private int fa_locker;
	private int fa_toilet;
	private int fa_shower;
	private int fa_smoking;
	private int fa_machine;
	private String fa_note;
}
