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
	
	private int entry_count;		//매치의 참가자 수
	private int club_entry_count;	//클럽 매치의 경우 해당 클럽의 참가자 수
	private int team_count;			//매치에 참가한 클럽 수
	private int application;		//리스트 조회 페이지에서 개인 매치의 경우 회원이 클럽 매치의 경우 회원이 가입한 클럽이 참가했는지 판단
	private int application_able;	//개인 또는 클럽이 해당 매치에 신청 가능한지 유무
	private int entry_res;			//신청 페이지에서 개인 매치의 경우 회원이 클럽 매치의 경우 회원이 가입한 클럽이 참가했는지 판단
	private int ready;	//매치시간으로부터 특정 시간이 지났는지 판단
	private int delete;	//매치시간으로부터 특정 시간까지 정원(참가자/클럽)이 다 찼는지 판단	
	
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