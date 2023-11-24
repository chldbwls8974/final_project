package kr.kh.final_project.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FacilityPictureVO {
	private int fp_num, fp_fa_num;
	private String fp_ori_name, fp_name;
	
	public FacilityPictureVO(int fp_fa_num,String fp_name, String fp_ori_name) {
		this.fp_fa_num = fp_fa_num;
		this.fp_ori_name = fp_ori_name;
		this.fp_name = fp_name;
	}
			
	
	
	
}
