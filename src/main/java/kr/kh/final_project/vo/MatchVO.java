package kr.kh.final_project.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class MatchVO {
	private int mt_num;
	private Date mt_date;
	private int mt_st_num;
	private int mt_ti_num;
	private int mt_type;
	private int mt_rule;
	private int mt_personnel;
	private int mt_state1;
	private int mt_state2;
	private String mt_memo;
	
	private String mt_date_str;
	
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
	
	private int fa_num;
	private int fa_bu_name;
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
	
	private int ti_num;
	private String ti_day;
	private Date ti_time;
	
	private String ti_time_str;
	
	private int rg_num;
	private String rg_main;
	private String rg_sub;
	
	private int mn_mt_num;
	private int mn_me_num;
	
	public String getMt_date_str() {
		if(mt_date == null) {
			return "";	
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		mt_date_str = format.format(mt_date);
		return mt_date_str;
	}
	public void setMt_date(String time) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			mt_date = format.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
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