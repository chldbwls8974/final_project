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
<style>
	.error {
		color: #f00;
		display: block;
	}
</style>
<body>
	<h1>포인트 환급 관리</h1>
	<form action="<c:url value='/member/refund'/>" method="post">
		<div class="form-group">
			<h5>${user.me_name} 님의</h5>
			<!-- 여기 작업해야 함. 유저가 로그인을 풀지않으면 변경포인트가 적용이 안됨. -->
			<span class="point">현재 보유 포인트는 ${user.me_point} 입니다.</span>
			<input type="hidden" class="form-control" value="${user.me_num}" name="me_num">
			<input type="hidden" class="form-control" value="${user.me_num}" name="ph_me_num">
			<input type="hidden" class="form-control" value="4" name="ph_source">
		</div>
		<br>
		<hr>
		<div class="form-group">
			<label>환급받을 금액</label>
			<label id="check-point-error" class="error" for="point"></label>
			<input type="number" class="form-control" id="refundAmount" name="ph_price" min="1000"  max="${user.me_point}" placeholder="1000원 단위로 입력" required>
		</div>
		<div class="form-group">
			<label>환급 후 예정 포인트</label>
			<input type="number" class="form-control" id="resultAmount" name="me_point" readonly required>
		</div>
		<button id="addBtn" class="btn btn-outline-dark col-12">등록</button>
	</form>
	<br>
	<hr>
	<div>
		<table class="table table-hover mt-4">
			<thead>
				<tr style="background: wheat; font-weight: bold;">
					<th>환급 신청 금액</th>
					<th>상태</th>
					<th></th>
				</tr>
			</thead>
			<tbody class="list-tbody">
			
			</tbody>
		</table>
	</div>
	<c:if test=""></c:if>
</body>

<script type="text/javascript">
	const addBtn = document.getElementById("addBtn");

	$(document).on('keyup','#refundAmount',function(){
		let point = $(this).val();
		
		let flag = false;
		
		var regPoint = /\d*000$/;
		
		if(!regPoint.test(point)){
			console.log("regex")
			
			addBtn.disabled = true;
			$('#check-point-error').text('1000원 단위로 입력해 주세요.');
			
			return;
		}else{
			addBtn.disabled = false;
			$('#check-point-error').text('');
		}
	})
	
    $(document).on("change", "#refundAmount", function(){
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
	
	    
	    
	/* 환급이력리스트를 가져오는 함수 */
	$(document).ready(function() {
   	 	getPointHistoryList();
	});
	
	
	
	function getPointHistoryList(){
		let data = {
			me_num : ${user.me_num}
		}
		console.log(data);
		
		ajaxJsonToJson(false,'post','/member/refund/list', data ,(data)=>{
			$('.point').text("현재 보유 포인트는 " + data.dbMemberPoint + " 입니다.");
			createPointHistoryList(data.refundList, '.list-tbody');
			console.log(data.refundList);
		});
	}
	
	
	function createPointHistoryList(refundList, target){
		let str ='';
		for(a of refundList){
			let btnStr = '';
			let state = '';
			let price = -parseInt(a.ph_price);
			console.log(price);
			if(a.ph_source == '4'){
				state = '승인 대기중'
				btnStr = `
					<div class="btn-group">
						<button class="btn btn-outline-danger btn-delete"  onclick="deleteRefund(\${a.ph_num})" >취소</button>
					</div>
					`;
			}else{
				state = '환급 완료'
				btnStr = `
					<div class="btn-group">
						<label class="btn btn-outline-dark disabled" >완료</label>
					</div>
					`
			} 
			str += `
				<tr>
					<td>\${price}</td>
					<td>\${state}</td>
					<td>\${btnStr}</td>
				</tr>
				
			`;
		}
		$(target).html(str);
	}
	
	//환급을 취소하는 함수
	function deleteRefund(ph_num){
		let data = { 
				ph_num : ph_num
		}
		console.log(ph_num)
		 
		ajaxJsonToJson(false,'post','/member/refund/delete', data ,(data)=>{
			if(data.res){
				alert('환급 신청이 취소되었습니다.')
			}
			
			getPointHistoryList();
		}); 
	}
</script>
</html>