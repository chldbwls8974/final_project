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
.form-group label{margin: 0 auto;}
.form-group{display:block; text-align: center;}
.form-group input{ margin: 0 auto;}
.form-control{ width: 400px; border-radius: 20px;}
.form-group-info{
	background-color: #f0f0f0; border-radius: 30px;
	width: 400px; height: 80px; margin: 0 auto;
}

.refund-thead{
	display: flex; justify-content: space-between; padding: 0 0 16px 0;
	border-bottom: 1px solid rgba(0,0,0,.1);
}
.list-tbody{ justify-content: space-between;}

.one{ justify-content: space-between;}
.btn{
	border-radius: 3px; width: 400px; height: 45px; border: none;
	background-color: #0c0c0c; color: white; font-weight: 900; margin-top: 50px;
}
.cancel-btn, .commit-btn{
	border-radius: 20px; width: 100px; height: 45px; border: none;
	background-color: #c2f296; color: black; font-weight: 900; margin-bottom: 20px;
}


.page-link {
  color: #000; 
  background-color: #fff;
  border: 1px solid #ccc; 
}
.page-item.active .page-link {
 z-index: 1;
 color: #555;
 background-color: #f1f1f1;
 border-color: #ccc;
 
}
.page-link:focus, .page-link:hover {
  color: #000;
  background-color: #fafafa; 
  border-color: #ccc;
}
</style>
<body>
	<p style="font-size: 45px; font-weight: bolder;
		text-align: center; padding: 50px 0 20px 0;">포인트 환급</p>
	<form action="<c:url value='/member/refund'/>" method="post" style="text-align: center;">
		<div class="form-group-info">
			<p style="font-size: 20px; margin: 0; padding-top: 10px; ">${user.me_name} 님의 보유 포인트</p> 
			<!-- 여기 작업해야 함. 유저가 로그인을 풀지않으면 변경포인트가 적용이 안됨. -->
			<p class="point" style="font-size: 18px;">${user.me_point}</p>
			<input type="hidden" class="form-control" value="${user.me_num}" name="me_num">
			<input type="hidden" class="form-control" value="${user.me_num}" name="ph_me_num">
			<input type="hidden" class="form-control" value="4" name="ph_source">
		</div>
		<br>
		<div class="form-group">
			<label style="margin-bottom: 10px;">환급받을 금액</label>
			<label id="check-point-error" class="error" for="point"></label>
			<input type="number" class="form-control" id="refundAmount" name="ph_price" min="1000"  max="" placeholder="1000원 단위로 입력" required>
		</div>
		<div class="form-group">
			<label style="margin-bottom: 10px;">환급 후 예정 포인트</label>
			<input type="number" class="form-control" id="resultAmount" name="me_point" readonly required>
		</div>
		<button id="addBtn" class="btn">등록</button>
	</form>
	<br>
		<p style="font-size: 20px; font-weight: bolder;
			padding: 50px 0 10px 10px;">환급 신청 내역</p>
	<hr>
	<div style="">
		<ul class="refund-thead">
			<li class="refund-td" style="margin-left: 20px;">환급 신청 금액</li>
			<li class="refund-td" style="margin-right: 50px;">환급 신청 상태</li>
			<li class="refund-td" style="margin-right: 20px;">취소/완료</li>
		</ul>
		<ul class="list-tbody one" >
		
		</ul>
	</div>
	<!-- 페이지네이션 -->
	<ul class="pagination justify-content-center mt-3 pagination">
	    <li class="page-item"><a class="page-link" href="javascript:void(0);">&lt;</a></li>
	    <li class="page-item"><a class="page-link" href="javascript:void(0);">1</a></li>
	    <li class="page-item"><a class="page-link" href="javascript:void(0);">2</a></li>
	    <li class="page-item"><a class="page-link" href="javascript:void(0);">&gt;</a></li>
	</ul>
</body>

<script type="text/javascript">
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
	        var userPoint = parseFloat($('.point').text());
	        $("#resultAmount").val(userPoint - num);
	        
        }
    });
	
	let cri = {
			page : 1,
			perPageNum : 5
	}    
	    
	/* 환급이력리스트를 가져오는 함수 */
	$(document).ready(function() {
   	 	getPointHistoryList(cri);
   	 	
   		
	});
	
	
	//포인트 환급 신청 이력을 받아오는 함수
	function getPointHistoryList(cri){
		
		console.log(cri);
		ajaxJsonToJson(false,'post','/member/refund/list', cri ,(data)=>{
			//유저 포인트 갱신
			$('.point').text(data.dbMemberPoint);
			//max 속성 값을 변경
			$('#refundAmount').attr('max', data.dbMemberPoint);
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
						<button class="cancel-btn"  onclick="deleteRefund(\${a.ph_num})" >취소</button>
					</div>
					`;
			}else{
				state = '환급 완료'
				btnStr = `
					<div class="btn-group">
						<label class="commit-btn disabled" >완료</label>
					</div>
					`
			} 
			str += `
					<li>
					<div style="display: flex; justify-content: space-between;">
						<div>\${price}</div>
						<div>\${state}</div>
						<div>\${btnStr}</div>
					</div>	
					</li>
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
</script>
</html>