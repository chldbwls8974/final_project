package kr.kh.final_project.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FileVO {
		private int fi_num, fi_bo_num;
		private String fi_ori_name, fi_name;
				
		public FileVO(int fi_bo_num, String fi_ori_name, String fi_name) {
			this.fi_bo_num = fi_bo_num;
			this.fi_ori_name = fi_ori_name;
			this.fi_name = fi_name;
		}
		
}
