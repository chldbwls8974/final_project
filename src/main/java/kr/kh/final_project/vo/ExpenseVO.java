package kr.kh.final_project.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class ExpenseVO {
	private int ex_num;
	private int ex_price;
	private int ex_pre;
	private Date ex_date;
	
	private String ex_date_str;
	
	public String getEx_date_str() {
		if(ex_date == null) {
			return "";	
		}
		SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd");
		ex_date_str = format.format(ex_date_str);
		return ex_date_str;
	}
	public void setEx_date_str(String time) {
		SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd");
		try {
			ex_date = format.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}