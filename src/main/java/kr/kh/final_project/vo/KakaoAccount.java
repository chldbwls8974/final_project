package kr.kh.final_project.vo;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class KakaoAccount {
    private boolean name_needs_agreement;
    private String name;
    private boolean has_email;
    private boolean email_needs_agreement;
    private boolean is_email_valid;
    private boolean is_email_verified;
    private String email;
    private String profile_nickname;
    private String gender;
    private String birthday;
}