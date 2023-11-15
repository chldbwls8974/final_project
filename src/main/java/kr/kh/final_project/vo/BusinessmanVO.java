package kr.kh.final_project.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BusinessmanVO {

	private Integer bu_num;
	private String bu_registration_number;
	private String bu_registration;
	private String bu_phone;
	private String bu_name;
	private int bu_price;
	private String bu_email;
	private Integer bu_me_num;
	private int bu_state;

}
