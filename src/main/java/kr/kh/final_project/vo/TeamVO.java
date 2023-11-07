package kr.kh.final_project.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class TeamVO {
	private int te_num;
	private int te_mt_num;
	private int te_type;

	private int entry_count;

	private int mt_num;
	private int mt_type;
	private int mt_rule;
	private int mt_personnel;
}