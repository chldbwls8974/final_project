package kr.kh.final_project.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CommentVO {
		private int co_num;
		private String co_comments;
		private int co_bo_num;
		private int co_me_num;
		private int co_ori_num;
		private Date co_date;
		private Date co_up_date;
		private String co_delete;
}
