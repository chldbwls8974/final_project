<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">

.error{
	color:#f00;
}
.form-control{border-radius: 30px; width: 500px;}
.form-group{text-align: center;}
.form-group label{display: inline-block; text-align: center;}
.form-group button, .form-group select{margin: 0 auto;}
.form-group input{margin: 0 auto;}
.form-group textarea{margin: 0 auto; height: 200px; background-color: #f7f7f7;}
.badge{ text-align: left;}
.btn{
	width: 120px; height: 40px; margin: auto auto 10px; border: none;
	border-radius: 5px; background-color: #c2f296; color: black;
}

</style>
</head>
<body>
	<p style="font-size: 35px; font-weight: bolder; margin:50px auto; border-bottom: 8px solid #c2f296;
	width: 15%; padding: 30px 0 10px 0; text-align: center;">회원 탈퇴</p>
	<form action="<c:url value='/member/signout'/>" method="post" id="myForm">
		<div class="form-group" hidden="hidden">
			<label>회원번호</label> 
			<input type="text" class="form-control" name="me_num" id="me_num" value="${user.me_num}"readonly>
		</div>
 		<div class="form-group" hidden="hidden">
			<label>포인트</label> 
			<input type="text" class="form-control" name="me_point" id="me_point" value="${user.me_point}" readonly>
		</div>
		<br>
		<div class="form-group">
			<div>
				<label for="terms" style="font-weight: bold;">
			 	</label> <span class="badge badge-danger">필수</span> 
				<p>탈퇴를 원하시는 경우, “회원탈퇴” 메뉴에서 본인확인 절차를 거친 후 진행해주세요.</p>
				<p>다만, 회원탈퇴를 하신 경우, 서비스의 일부 또는 전부 이용이 어려울 수 있습니다.</p>
			 </div>
			 <div>
				<textarea class="form-control" rows="5" id="terms" readonly>
				■ 회원 탈퇴 및 이용 제한
				o 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지 않습니다.
				o 회원 가입시 입력했던 개인신상 정보는 회원 탈퇴 시 즉각 삭제됩니다.
				o 탈퇴한 계정은 복구가 불가합니다.
				o 탈퇴 시, 포인트는 모두 소멸됩니다.
				</textarea>
			</div>
		</div>
		<div class="form-group form-check" >
            <input type="checkbox" class="form-check-input"
            	id="agreeCheck" style="margin-top: 5px;">
            <label class="form-check-label" for="agreeCheck" style="margin-left: 20px;">
            	약관에 동의합니다.</label>
        </div>
		<br>
		<div style="text-align: center;">
			<button class="btn" id="signout" name="signout">회원탈퇴</button>
		</div>
	</form>
	
	<script type="text/javascript">
		
		
		//필수사항 및 포인트 체크 alert
		$('#signout').click(function () {
			let agreeCheck = $('#agreeCheck').prop('checked');
	    	let me_point = parseInt('${user.me_point}');
		   if(confirm("정말 탈퇴하시겠습니까?")){
			   if(!agreeCheck){ 
					alert("회원탈퇴 개인정보처리방침에 동의해야 합니다.");
					return false
			   }
			   if(me_point > 0){
				   if(confirm("[${user.me_point}원] 포인트가 남아있습니다. 탈퇴를 진행하시겠습니까?")){
					   return true
				   }else{
					   return false
				   }
				  
			   }
				return true
		   }else{
			   return false
		   }
		});
	

	
	</script>
</body>
</html>