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
	 .list-group {
        text-align: center; /* 부모 요소에 적용 */
        border-radius: 30px;
    }
    .list-group-item {
        display: block; /* 블록 레벨로 변경 */
        margin: auto; /* 수직 가운데 정렬을 위해 추가 */
        cursor: pointer;
    }
    .minibox{
		width: 350px; height: 70px; background-color: #f0f0f0; border-radius: 20px;
		padding: 20px; text-align: center; margin: 40px auto;
    }
	.point{ font-size: 16px;}
	.list-group-item.active{ background-color: #d7fdb5; border-color: #d7fdb5; color: black;}
	.btn{
		border-radius: 5px; width: 200px; height: 50px; border: none;
		background-color: #c2f296; color: black; margin: 10px 0 10px 0;
	}
</style>
<body>
	<p style="font-size: 35px; font-weight: bolder; margin:50px auto; border-bottom: 8px solid #c2f296;
			width: 20%; padding: 30px 0 10px 0; text-align: center;">포인트 충전</p>
	<div class="minibox">
		<span class="point"> 현재 ${user.me_name}님의 보유 포인트는 </span>
	</div>
	<div style="text-align: center;">
		<ul class="list-group">
			 <li data-value="5" class="list-group-item col-4 " >5,000 포인트</li>
			 <li data-value="10" class="list-group-item col-4 ">10,000 포인트</li>
			 <li data-value="30" class="list-group-item col-4 ">30,000 포인트</li>
			 <li data-value="50" class="list-group-item col-4 ">50,000 포인트</li>
			 <li data-value="100" class="list-group-item col-4 ">100,000 포인트</li>
		</ul>
	</div>
	<div style="text-align: center; margin-top: 30px">
		<button class="btn" onclick="btnOnclick(selectedAmount)">결제하기</button>
	</div>
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
		getUserInformation()
	});
	//유저정보를 가져오는 ajax
	function getUserInformation() {
		num = { me_num : ${user.me_num}}
		ajaxJsonToJson(false, 'post', "/member/information", num,(data)=>{
			$('.point').text("현재  `${user.me_name}` 님의 보유 포인트는 " + data.userPoint + " P 입니다.");
		});
	}
	
	function btnOnclick(selectedAmount){
		if(selectedAmount == 0){
			alert('금액을 선택해 주세요.');
			return;
		}else{
			requestPay()
		}
	}
	
	//결제
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
	        	let data = {
	        		imp_uid: rsp.imp_uid,            // 결제 고유번호
                    //merchant_uid: rsp.merchant_uid,   // 주문번호
                    amount: rsp.paid_amount,
                    me_num : me_num
	        	}
	        	$.ajax({
					type:"post",
					url:'<c:url value="/payment/validate"/>',
					data:JSON.stringify(data),
					contentType:"application/json; charset=utf-8",
					dataType:"json",
					success: function(data) {
						alert("결제 완료");
						console.log(rsp);
						//유저포인트 갱신
						getUserInformation()
						//self.close();
					},
					error: function(data){
						alert("결제 실패");
						alert(data.responseText);
						cancelPayments(rsp);
					}
				});
	        } else {
	        	console.log()
	        	alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
	        }
	    });
	}
	
	//결제 취소 (ajax가 실패했을 때)
	function cancelPayments(temp){
		let data = null;
		data = {
			impUid:temp.imp_uid,
			reason:"결제 금액 위/변조 또는 중복결제로 인한 결제 취소.",
		};
	
		ajaxJsonToJson(false, 'post', "cancelPayments", data,(data)=>{
    		if(data){
    			alert("결제가 취소되었습니다.");
				//self.close();//팝업창닫기
				//결제 취소화면으로 이동해주기.
    		}else{
    			alert("결제금액 환불못함. 이유: " + data.responseText);
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