package kr.kh.final_project.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BlockVO {
	private int bl_num;
	private int bl_me_num;
	private int bl_blocked_num;
	
	private int me_num;
	
	private int bo_me_num;
}
