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
		private String co_date;
		private Date co_up_date;
		private String co_delete;
		
		private int me_num;
		private String me_nickname;
		private String me_profile;
		
		private int bl_me_num;
		private int bl_blocked_num;
}
