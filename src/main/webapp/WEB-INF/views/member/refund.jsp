<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<title>포인트 환급</title>
</head>
<body>
	<h1>포인트 환급</h1>
	<form action="<c:url value='/member/refund'/>" method="post">
		<div class="form-group">
			<h5>홍길동 님의</h5>
			<label>현재 보유 포인트는 ${user.me_point} 입니다.</label>
		</div>
		<hr>
		<div class="form-group">
			<label>환급받을 금액</label>
			<input type="number" class="form-control" id="refundAmount" min="0"  max="${user.me_point}">
		</div>
		<div class="form-group">
			<label>환급 후 예정 포인트</label>
			<input type="number" class="form-control" name="me_point" readonly>
		</div>
		<button class="btn btn-outline-dark col-12">등록</button>
	</form>
</body>
<script type="text/javascript">
	//let 자료형에 keyup으로 반올림한 정수를 저장
	
	//change로 계산해서 화면에 보여줌
	
	$(document).ready(function() {
	    // refundAmount input 요소의 변경 이벤트 리스너를 추가합니다.
	    $("#refundAmount").on("change", function() {
	        //유저가 입력한 환급받을 포인트 (parseInt으로 문자열을 숫자로 변환)
	        var refundAmountValue = parseInt($(this).val());
	        var intValue = Math.round(parseFloat(refundAmountValue) / 1000) * 1000;
            $(this).val(intValue);
	        
	        var userMePoint = parseInt('${user.me_point}');
	        
	
	        // 차액을 환급 후 예정포인트에 입력
	        $("input[name='me_point']").val(userMePoint - refundAmountValue);
	    });
	});
</script>
</html>