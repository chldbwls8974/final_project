package kr.kh.final_project.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AvailabilityVO {
	private int av_st_num;
	private Date av_notdate; 
	private String av_reason;
	
	private String av_notdate_str;

	public String getAv_notdate_str() {
	    if (av_notdate == null) {
	        return "";
	    }
	    SimpleDateFormat format = new SimpleDateFormat("yy년 MM월 dd일");
	    return format.format(av_notdate);
	}	
	public void setAv_notdate_str(String time) {
		SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd HH:mm");
		try {
			av_notdate = format.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
}
