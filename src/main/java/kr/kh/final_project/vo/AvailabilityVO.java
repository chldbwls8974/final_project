package kr.kh.final_project.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AvailabilityVO {
	private int av_st_num;
	private Date av_notdate; 
	private String av_reason;
}
