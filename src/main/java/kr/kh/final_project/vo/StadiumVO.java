package kr.kh.final_project.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class StadiumVO {
	private Integer st_num;
	private String st_name;
	private String st_locate;
	private int st_door;
	private int st_floortype;
	private Integer st_width;
	private Integer st_height;
	private Integer st_max;
	private int st_available;
	private String st_note;
	private Integer st_fa_num;
	private int st_deleted;
}
