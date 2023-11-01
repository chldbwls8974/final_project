<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>결제</title>
</head>
<style>
	.list-group-item {
	  cursor: pointer;
	}
</style>
<body>
	<h1>결제 페이지</h1>
	<ul class="list-group">
		 <li data-value="5" class="list-group-item col-4 " >5,000 포인트</li>
		 <li data-value="10" class="list-group-item col-4 ">10,000 포인트</li>
		 <li data-value="30" class="list-group-item col-4 ">30,000 포인트</li>
		 <li data-value="50" class="list-group-item col-4 ">50,000 포인트</li>
		 <li data-value="100" class="list-group-item col-4 ">100,000 포인트</li>
	</ul>
	<button class="btn btn-outline-dark col-4" onclick="btnOnclick(selectedAmount)">결제하기</button>
	<span>보유 포인트 ${user.me_point}</span>
	
</body>


<script type="text/javascript">
	//
	var IMP = window.IMP; 
	IMP.init("imp13470341"); 
	
	var today = new Date();   
	var hours = today.getHours(); // 시
	var minutes = today.getMinutes();  // 분
	var seconds = today.getSeconds();  // 초
	var milliseconds = today.getMilliseconds();
	var makeMerchantUid = hours +  minutes + seconds + milliseconds;
	let selectedAmount = 0;
	let me_email ;
	let me_name ;
	let name ;
	let me_num ;
	$(document).ready(function() {
		//유저 선택 금액
		selectedAmount = 0;
		me_email = '${user.me_email}';
		me_name = '${user.me_name}';
		me_num = ${user.me_num};
		console.log(me_num);
	});
	
	
	function btnOnclick(selectedAmount){
		if(selectedAmount == 0){
			alert('금액을 선택해 주세요.');
			return;
		}else{
			requestPay()
		}
	}
	
	function requestPay() {
	    IMP.request_pay({
	    	//필수 파라미터
	        pg : 'html5_inicis',
	        pay_method : 'card',
	        merchant_uid: "IMP"+makeMerchantUid, 
	        name : name,
	        amount : selectedAmount,
	        //선택 파라미터
	        buyer_email : me_email,
	        buyer_name : me_name
	    }, function (rsp) { // callback함수
	        if (rsp.success) {
	        	//ajax
	        	//let url = "/payment/validate/" + rsp.imp_uid;
	        	//console.log(url);
	        	let data = {
        			imp_uid: rsp.imp_uid,            // 결제 고유번호
                    merchant_uid: rsp.merchant_uid,   // 주문번호
                    amount: rsp.paid_amount,
                    me_num : me_num
	        	}
	        	ajaxJsonToJson(false, 'post', "/payment/validate", data,(data)=>{
	        		console.log("결제 ajax 성공")
				});
	            console.log(rsp);
	        } else {
	        	alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
	        }
	    });
	}
	
	//가격 클릭 이벤트
	$(".list-group-item").on("click", function() {
		//상품명 // 유저의 선택 금액
		name = $(this).text();
	    selectedAmount = parseInt($(this).data("value"), 10);
	    // 모든 항목에서 active 클래스를 제거
	    $(".list-group-item").removeClass("active");
	    // 클릭한 항목에만 active 클래스 추가
	    $(this).addClass("active");
	    console.log(selectedAmount);
	    console.log(name);
	});

</script>
</html>