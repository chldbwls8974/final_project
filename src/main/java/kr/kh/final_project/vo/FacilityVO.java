package kr.kh.final_project.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FacilityVO {
	private Integer fa_num;
	private Integer fa_bu_num;
	private Integer fa_rg_num;
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
	private int fa_deleted;

	//시설 지역수정 시 사용
	private String fa_rg_main;
	
    private List<OperatingVO> operatingList;

}
