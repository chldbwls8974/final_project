package kr.kh.final_project.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class OperatingVO {
	private int op_num;
	private String op_day;
	private int op_open;
	private int op_close;
	private int op_fa_num;
	
	private Date op_open_time;
	private Date op_close_time;
	
	public Date getOp_open_time() {
		SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		try {
			op_open_time = format.parse(this.op_open + ":00");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return op_open_time;
	}
	public Date getOp_close_time() {
		SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		try {
			op_close_time = format.parse(this.op_close <= 24 ? this.op_close + ":00" : this.op_close - 24 + ":00");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return op_close_time;
	}
	/*
	@Override
	public String toString() {
		return "{op_num : " + op_num + ", op_day : '" + op_day + "', op_open : " + op_open + ", op_close : "
				+ op_close + ", op_fa_num : " + op_fa_num + "}";
	}
	*/
}
