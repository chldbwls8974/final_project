package kr.kh.final_project.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class ExtraVO {
	private Date date;
	private String day_of_week;
	
	private String date_str;
	
	private int month;
	private int day;
	
	public String getDate_str() {
		if(date == null) {
			return "";	
		}
		SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd");
		date_str = format.format(date);
		String[] parts = date_str.split("-");
		month = Integer.parseInt(parts[1]);
		day = Integer.parseInt(parts[2]);
		return date_str;
	}
	public void setDate_str(String time) {
		SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd");
		try {
			date = format.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}