package kr.kh.final_project.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class TimeVO {
	private int ti_num;
	private String ti_day;
	private Date ti_time;
	
	private String ti_time_str;
	
	public String getTi_time_str() {
		if(ti_time == null) {
			return "";	
		}
		SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		ti_time_str = format.format(ti_time);
		return ti_time_str;
	}
	public void setTi_time_str(String time) {
		SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		try {
			ti_time = format.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}
