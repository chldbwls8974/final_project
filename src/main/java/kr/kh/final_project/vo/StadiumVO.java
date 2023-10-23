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
	/*
	@Override
	public String toString() {
		return "{st_num : " + st_num + ", st_name : '" + st_name + "', st_locate : '" + st_locate + "', st_door : "
				+ st_door + ", st_floortype : " + st_floortype + ", st_width : " + st_width + ", st_height : " + st_height
				+ ", st_max : " + st_max + ", st_available : " + st_available + ", st_note : '" + st_note + "', st_fa_num : "
				+ st_fa_num + "}";
	}
	*/
}
