package kr.kh.final_project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import kr.kh.final_project.vo.PaymentReq;

@RestController
public class PaymentController {
	

	@PostMapping("/payment/validate")
	public Map<String, Object> createPayment(@RequestBody PaymentReq paymentReq){
		Map<String, Object> map = new HashMap<String, Object>();
        //PaymentRes paymentRes = reservationService.createReservation(paymentReq);
		
		System.out.println(paymentReq);
		
		
		
		//map.put("res", res);
        return map;
    }
	
}
