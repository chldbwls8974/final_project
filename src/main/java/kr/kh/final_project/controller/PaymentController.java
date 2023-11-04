package kr.kh.final_project.controller;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kr.kh.final_project.service.MemberService;
import kr.kh.final_project.service.PaymentService;
import kr.kh.final_project.service.SecretKey;

@RestController
public class PaymentController {
	
	SecretKey key = new SecretKey();
	private String API_KEY = key.getAPI_KEY();
    private String API_SECRET = key.getAPI_SECRET(); 
    private final IamportClient iamportClientApi;
    
    public PaymentController() {
		this.iamportClientApi = new IamportClient(API_KEY, API_SECRET);
	}
	
	@Autowired
	PaymentService paymentService;
	
	@Autowired
	MemberService memberService;
	
	@PostMapping("/payment/validate")
	public IamportResponse<Payment> verifyIamport(@RequestBody Map<String,String> map) throws IamportResponseException, IOException {
		String impUid = map.get("imp_uid");//실제 결제금액 조회위한 아임포트 서버쪽에서 id
		int me_num = Integer.parseInt(map.get("me_num")); //유저번호
		int amount = Integer.parseInt(map.get("amount"));//실제로 유저가 결제한 금액
		
		//아임포트 서버쪽에 결제된 정보 조회.
		//paymentByImpUid 는 아임포트에 제공해주는 api인 결제내역 조회(/payments/{imp_uid})의 역할을 함. 
		IamportResponse<Payment> irsp = paymentLookup(impUid);
		
		//서비스에서 결제 검증
		// 성공 : DB에 등록
		// 실패 : DB에 등록하지 않고 false 반환
		paymentService.verifyIamportService(irsp, amount, me_num);
		return irsp;
	}
	
	//결제 취소 메서드
	// 결제에 실패한 impUid를 이용해 결제취소에 필요한 값을 가져와서 취소하는 메서드
	@PostMapping("cancelPayments")
	public IamportResponse<Payment> cancelPayments(@RequestBody Map<String,String> map) throws IamportResponseException, IOException {
		
		//조회
		IamportResponse<Payment> lookUp = null;
		if(map.containsKey("impUid")) {
			lookUp = paymentLookup(map.get("impUid"));//들어온 정보에 imp_uid가 있을때
		}
		else if(map.containsKey("paymentsNo")) {
			lookUp = paymentLookup(map.get("paymentsNo"));//imp_uid가 없을때
		}
		 
		CancelData data = paymentService.cancelData(map,lookUp);//취소데이터 셋업
		IamportResponse<Payment> cancel = iamportClientApi.cancelPaymentByImpUid(data);//취소
		
		return cancel;
	}
	
	
	//impUid로 결제내역 조회
	public IamportResponse<Payment> paymentLookup(String impUid) throws IamportResponseException, IOException{
		return iamportClientApi.paymentByImpUid(impUid);
	}
	
	
	
}
