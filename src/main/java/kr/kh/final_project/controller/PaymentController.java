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

		paymentService.verifyIamportService(irsp, amount, me_num);
		
		return irsp;
	}
	
	/**
	 * impUid로 결제내역 조회.
	 * @param impUid
	 * @return
	 * @throws IamportResponseException
	 * @throws IOException
	 */
	public IamportResponse<Payment> paymentLookup(String impUid) throws IamportResponseException, IOException{
		return iamportClientApi.paymentByImpUid(impUid);
	}
	
	/**
	 * 결제한 금액을 취소요청이 들어오면 실행되는 메서드<br>
	 * 환불될 금액과 아임포트 서버에서 조회한 결제 금액이 다르면 환불 or 취소 안됨.
	 * @param map
	 * @param principal
	 * @return
	 * @throws IamportResponseException
	 * @throws IOException
	 * @throws RefundAmountIsDifferent
	 */
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
	
}
