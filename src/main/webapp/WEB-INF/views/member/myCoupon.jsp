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
	.container-body{
		background-color: #f2f2f2; border-radius: 30px;
		padding-bottom: 50px;
	}
	.mini-container{
		width: 1000px;  height: auto;
	    margin: 0 auto 40px auto; padding: 30px;
		background-color: white; border-radius: 30px;
	}
	.table td{ border: none; padding: 30px;}
	
	.page-item.active .page-link{
		z-index: 3;
	    color: #fff;
	    background-color: #b8d49e;
	    border-color: #b8d49e;
	}
	
</style>
<body>
	<div class="container-body">
		<p style="font-size: 35px; font-weight: bolder; margin: 10px auto;
		width: 30%; padding: 30px; text-align: center;">나의 보유 쿠폰</p>
		
		<div class="mini-container">
			<table class="table table-hover mt-4">
				<thead>
					<tr style="border-bottom: 1px solid #e9e9e9;">
						<td>쿠폰 이름</td>
						<td>할인 금액</td>
						<td>추천인</td>
						<td>상태</td>
					</tr>
				</thead>
				<tbody class="list-tbody">
				
				</tbody>
			</table>
		</div>
		<!-- 페이지네이션 -->
		<ul class="pagination justify-content-center mt-3 pagination">
		</ul>
	</div>
</body>

<script type="text/javascript">
	let cri = {
		page : 1,
		perPageNum : 5
	}
	
	//환급이력리스트를 가져오는 함수
	$(document).ready(function() {
   	 	getUserCoupon(cri);
   	 	
	});
	
	function getUserCoupon(cri){
		ajaxJsonToJson(false,'post','/member/myCoupon', cri ,(data)=>{
			//리스트를 생성
			createUserCouponList(data.hcList, '.list-tbody');
			//페이지네이션 생성
			createPagination(data.pm, '.pagination');
		});
	}
	
	//쿠폰 리스트 생성
	function createUserCouponList(hcList, target){
		let str ='';
		for(a of hcList){
			console.log(${a.hp_invited_nickname});
			let state = '';
			if(a.hp_state == '0'){
				state = '사용 가능'
			}else{
				state = '사용 불가'
			}
			str += `
				<tr>
					<td>\${a.cp_source}</td>//쿠폰 이름
					<td>\${a.cp_sale}</td>//할인 금액
					<td>\${a.hp_invited_nickname}</td>//추천인
					<td>\${state}</td>//상태
				</tr>
				
			`;
		}
		$(target).html(str);
	}
	
	//페이지네이션
	function createPagination(pm, target){
		let str = '';
		if(pm.prev){
			str += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="cri.page=\${pm.startPage-1};getUserCoupon(cri)">&lt;</a></li>`;
		}
		//현재페이지 = active 클래스 추가
		for(i=pm.startPage; i<=pm.endPage; i++){
			let active = pm.cri.page == i ? 'active' : '';
			str += `
			<li class="page-item \${active}">
				<a class="page-link" href="javascript:void(0);" onclick="cri.page=\${i};getUserCoupon(cri)">\${i}</a>
			</li>`;
		}
		if(pm.next){
			str += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="cri.page=\${pm.endPage+1};getUserCoupon(cri)">&gt;</a></li>`;
		}
		$(target).html(str);
	}
/*
	const addBtn = document.getElementById("addBtn");

	$(document).on('keyup','#refundAmount',function(){
		let point = $(this).val();
		
		let flag = false;
		
		var regPoint = /\d*000$/;
		
		if(!regPoint.test(point)){
			
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
	
	let cri = {
			page : 1,
			perPageNum : 5
	}    
	    
	//환급이력리스트를 가져오는 함수
	$(document).ready(function() {
   	 	getPointHistoryList(cri);
   	 	
	});
	
	
	//포인트 환급 신청 이력을 받아오는 함수
	function getPointHistoryList(cri){
		
		console.log(cri);
		ajaxJsonToJson(false,'post','/member/refund/list', cri ,(data)=>{
			$('.point').text("현재 보유 포인트는 " + data.dbMemberPoint + " 입니다.");
			//리스트를 생성
			createPointHistoryList(data.refundList, '.list-tbody');
			//페이지네이션 생성
			createPagination(data.pm, '.pagination');
		});
	}
	
	//페이지네이션
	function createPagination(pm, target){
		let str = '';
		if(pm.prev){
			str += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="cri.page=\${pm.startPage-1};getPointHistoryList(cri)">이전</a></li>`;
		}
		//현재페이지 = active 클래스 추가
		for(i=pm.startPage; i<=pm.endPage; i++){
			let active = pm.cri.page == i ? 'active' : '';
			str += `
			<li class="page-item \${active}">
				<a class="page-link" href="javascript:void(0);" onclick="cri.page=\${i};getPointHistoryList(cri)">\${i}</a>
			</li>`;
		}
		if(pm.next){
			str += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="cri.page=\${pm.endPage+1};getPointHistoryList(cri)">다음</a></li>`;
		}
		$(target).html(str);
	}
	
	function createPointHistoryList(refundList, target){
		let str ='';
		for(a of refundList){
			let btnStr = '';
			let state = '';
			let price = -parseInt(a.ph_price);
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
		 
		ajaxJsonToJson(false,'post','/member/refund/delete', data ,(data)=>{
			if(data.res){
				alert('환급 신청이 취소되었습니다.')
			}
			cri.page = 1;
			getPointHistoryList(cri);
		}); 
	}
*/
</script>
</html>