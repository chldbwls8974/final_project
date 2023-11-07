package kr.kh.final_project.service;

import lombok.Data;

@Data
public class SecretKey {
	private String API_KEY; 
	private String API_SECRET;
	
	public SecretKey() {
		this.API_KEY = "4805457555323716";
		this.API_SECRET ="k3kycMEDSTHVnFbRUdkPYTbETjog4ezIXIXsS2IB2oT2IFqdyY5dmmwXfLizD3uV9wpQmswR222sOJiO";
	}
	
	public String getAPI_KEY() {
        return API_KEY;
    }
	public String getAPI_SECRET() {
        return API_SECRET;
    }
	
}
