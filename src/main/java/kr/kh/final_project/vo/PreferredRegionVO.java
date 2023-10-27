package kr.kh.final_project.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PreferredRegionVO {
	private int pr_num;
	private int pr_me_num;
	private int pr_rg_num;
	private List<PreferredRegionVO> prRegionList;
}
