package kr.kh.final_project.service;

import java.math.BigDecimal;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kr.kh.final_project.dao.PaymentDAO;
import kr.kh.final_project.dao.PointHistoryDAO;
import kr.kh.final_project.vo.PaymentVO;
import kr.kh.final_project.vo.PointHistoryVO;

@Service
public class PaymentService  {
	@Autowired
	private PaymentDAO paymentDao;
	@Autowired
	private PointHistoryDAO pointHistoryDao;
	
	
	/**
	 * 현재 결제번호에 해당하는 정보를 갖고와서 반환해줌.
	 * @param paymentsNo
	 * @return
	 */
	@Transactional
	public PaymentVO paymentLookupService(String impUid) {
		PaymentVO payment = paymentDao.getPaymentByImpUid(impUid);
		return payment;
	}
	
	/**
	 * 아임포트 서버쪽 결제내역과 DB에 물건가격을 비교하는 서비스. <br>
	 * 다름 -> 예외 발생시키고 GlobalExceptionHandler쪽에서 예외처리 <br>
	 * 같음 -> 결제정보를 DB에 저장(PaymentsInfo 테이블)
	 * @param irsp (아임포트쪽 결제 내역 조회 정보)
	 * @param actionBoardNo (내 DB에서 물건가격 알기위한 경매게시글 번호)
	 * @throws verifyIamportException
	 */
	@Transactional
	public void verifyIamportService(IamportResponse<Payment> irsp, int amount, int me_num) {
		
		//실제로 결제된 금액과 아임포트 서버쪽 결제내역 금액과 같은지 확인
		if(irsp.getResponse().getAmount().intValue() != amount) {
			//결제 취소 (ajax통신 실패 시 jsp에서 cancelPayments함수 실행)
			return;
		}
				
		//아임포트에서 서버쪽 결제내역과 DB의 결제 내역 금액이 같으면 DB에 결제 정보를 삽입.
		
		
		
		
		
		// 포인트내역 테이블에 추가
		PointHistoryVO ph =  new PointHistoryVO();
		ph.setPh_price(amount);
		ph.setPh_me_num(me_num);
		// 포인트내역테이블에 추가 후 생성된 기본키 ph에 저장하는 메서드.
		pointHistoryDao.insertPointHistoryByPayment(ph);
		int pm_ph_num = ph.getPh_num();
		System.out.println(ph);
		
		//결제 테이블에 추가
		PaymentVO payment = new PaymentVO();
		payment.setPm_imp_uid(irsp.getResponse().getImpUid());
		payment.setPm_amount(amount);
		payment.setPm_ph_num(pm_ph_num);
		System.out.println(payment);
		//		paymentDao.insertPayment(payment);  //결제테이블에 등록
		
	}
	
	/**
	 * 결제 취소할때 필요한 파라미터들을
	 * CancelData에 셋업해주고 반환함.
	 * @param map
	 * @param impUid
	 * @param bankAccount
	 * @param code
	 * @return
	 * @throws RefundAmountIsDifferent 
	 */
	@Transactional
	public CancelData cancelData(Map<String,String> map, 
			IamportResponse<Payment> lookUp) {
		//취소하기 위한 데이터 반환하는 메서드
		CancelData data = new CancelData(lookUp.getResponse().getImpUid(),true);
		data.setReason(map.get("reason"));
		return data;
	}
}
