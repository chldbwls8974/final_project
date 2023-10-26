package kr.kh.final_project.vo;

import lombok.Data;

@Data
public class StadiumVO {
	private int st_num;
	private String st_name;
	private String st_locate;
	private int st_door;
	private int st_floortype;
	private int st_width;
	private int st_height;
	private int st_max;
	private int st_available;
	private String st_note;
	private int st_fa_num;
}
