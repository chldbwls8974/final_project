package kr.kh.final_project.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardVO {
	private int bo_num;
	private int bo_bt_num;
	private int bo_rg_num;
	private String bo_title;
	private int bo_me_num; 
	private Date bo_reg_date;
	private Date bo_up_date; 
	private String bo_contents; 
	private int bo_count;
	private int bo_comment;
	
	private String me_nickname;
	
	private String bo_reg_date_str;
	
	private List<FileVO> fileVoList;
	
	public String getBo_reg_date_str() {
		if(bo_reg_date == null) {
			return "";	
		}
		SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd HH:mm");
		bo_reg_date_str = format.format(bo_reg_date);
		return bo_reg_date_str;
	}
	public void setBo_reg_date_str(String time) {
		SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd HH:mm");
		try {
			bo_reg_date = format.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}
