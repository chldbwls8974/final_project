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
			<h5>${user.me_name} 님의</h5>
			<label>현재 보유 포인트는 ${user.me_point} 입니다.</label>
			<input type="hidden" class="form-control" value="${user.me_num}" name="me_num">
			<input type="hidden" class="form-control" value="${user.me_num}" name="ph_me_num">
			<input type="hidden" class="form-control" value="4" name="ph_source">
		</div>
		<hr>
		<div class="form-group">
			<label>환급받을 금액</label>
			<input type="number" class="form-control" id="refundAmount" name="ph_price" min="1000"  max="${user.me_point}" placeholder="1000원 단위로 입력" required>
		</div>
		<div class="form-group">
			<label>환급 후 예정 포인트</label>
			<input type="number" class="form-control" id="resultAmount" name="me_point" readonly required>
		</div>
		<button class="btn btn-outline-dark col-12">등록</button>
	</form>
</body>

<script type="text/javascript">
	$(document).ready(function() {
	    $("#refundAmount").on("change", function() {
	        //입력한 금액을 변수에 저장
	        var refundAmountValue = parseFloat($(this).val());
	        if(refundAmountValue > 0){
	        	//1000단위로 입력값 변경
		        var num = Math.floor(parseFloat(refundAmountValue) / 1000) * 1000;
	            $(this).val(num);
		        //(유저의 현재 포인트 - 환급받을 금액)을 저장
		        var userPoint = parseFloat('${user.me_point}');
		        $("#resultAmount").val(userPoint - num);
	        }
	    });
	});
</script>
</html>