<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
<style type="text/css">
.error{
	color:#f00;
}
</style>
</head>
<body>
	<h1>회원가입</h1>
	<form action="<c:url value='/member/signup'/>" method="post">
		<div class="form-group">
			<label>아이디</label><label id="check-id-error" class="error" for="me_id"></label>
			<input type="text" class="form-control" name="me_id">
			
		</div>
		<div class="form-group">
			<label>비번</label>
			<input type="password" class="form-control" name="me_pw" id="pw">
		</div>
		<div class="form-group">
			<label>비번 확인</label>
			<input type="password" class="form-control" name="me_pw2">
		</div>
		<div class="form-group">
			<label>이메일</label>
			<input type="email" class="form-control" name="me_email">
			<button type ="button" class="form-control" name="me_email_btn">이메일 인증</button>
		</div>
		<div class="form-group">
			<label>이름</label>
			<input type="text" class="form-control" name="me_name">
		</div>
		<div class="form-group">
			<label>닉네임</label>
			<input type="text" class="form-control" name="me_nickname">
		</div>
		<div class="form-group">
		 <label>거주지</label>
		 	<select class="form-control" name="rg_main">
			 	<option value="0">지역을 선택하세요</option>
			 	<c:forEach items="${MainRegion}" var="main">
			 		<option value="${main.rg_main}">${main.rg_main}</option>
			 	</c:forEach>
			 </select>
			 <select class="form-control" name="rg_sub">
			 	<option value="0">지역을 선택하세요</option>
			 	<c:forEach items="${SubRegion}" var="sub">
			 		<option value="${sub.rg_num}">${sub.rg_sub}</option>
			 	</c:forEach>
			 </select>
		</div>
		<button class="btn btn-outline-warning col-12">회원가입</button>
	</form>
	<script type="text/javascript">
	
	 $(document).on('change','[name=rg_main]',function(){
		 let th = $(this);
		 rg_main = th.val();
		 console.log(rg_main)
		 data={
			 rg_main : rg_main}
		 
		ajaxJsonToJson2(false, 'post', '/member/signup/region', data, (a)=>{
			console.log(a)
		})
		
	   });
	
	
	
	</script>
</body>
</html>