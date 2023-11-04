package kr.kh.final_project.service;

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
	
	
	//현재 결제번호에 해당하는 정보를 DB에서 갖고와서 반환해줌.
	@Transactional
	public PaymentVO paymentLookupService(String impUid) {
		PaymentVO payment = paymentDao.getPaymentByImpUid(impUid);
		return payment;
	}
	//금액이 다르면 취소되는지?
		// db에는 안들어가지만 취소는 안됨
	//impUid가 다를 때 결제취소가 되는지?
	// 기본키가 다르거나 등의 이유로 db에 등록에 실패했을 때 결제 취소가 되는지?
	@Transactional
	public boolean verifyIamportService(IamportResponse<Payment> irsp, int amount, int me_num)  {
		//실제로 결제된 금액과 아임포트 서버쪽 결제내역 금액과 같은지 확인
		if(irsp.getResponse().getAmount().intValue() != amount) {
			//결제 취소 (ajax통신 실패 시 jsp에서 cancelPayments함수 실행)
			return false;
		}
				
		//아임포트에서 서버쪽 결제내역과 DB에 추가될 금액이 같으면 DB에 결제 정보를 삽입.
		// 포인트내역 테이블에 추가
		PointHistoryVO ph =  new PointHistoryVO();
		ph.setPh_price(amount);
		ph.setPh_me_num(me_num);
		// 포인트내역테이블에 추가 후 생성된 기본키 ph에 저장하는 메서드.
		boolean pointHistoryRes = pointHistoryDao.insertPointHistoryByPayment(ph);
		int pm_ph_num = ph.getPh_num();
		System.out.println(ph);
		
		//결제 테이블에 추가
		PaymentVO payment = new PaymentVO();
		payment.setPm_imp_uid(irsp.getResponse().getImpUid());
		payment.setPm_amount(amount);
		payment.setPm_ph_num(pm_ph_num);
		System.out.println(payment);
		boolean paymentRes = paymentDao.insertPayment(payment);  //결제테이블에 등록
		
		return true;
	}
	
	//결제 취소할때 필요한 파라미터들을 CancelData에 셋업해주고 반환함.
	@Transactional
	public CancelData cancelData(Map<String,String> map, 
			IamportResponse<Payment> lookUp) {
		//취소하기 위한 데이터 반환하는 메서드
		CancelData data = new CancelData(lookUp.getResponse().getImpUid(),true);
		data.setReason(map.get("reason"));
		return data;
	}
}
