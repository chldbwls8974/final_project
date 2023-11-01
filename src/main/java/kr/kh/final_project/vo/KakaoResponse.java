package kr.kh.final_project.vo;



import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class KakaoResponse {
	private long id;
    private String connected_at;
    private KakaoAccount kakao_account;
}