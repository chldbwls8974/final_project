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
</style>
</head>
<body>
	<h1>로그인</h1>
	<form action="<c:url value='/member/login'/>" method="post">
		<div class="form-group">
			<label>아이디</label>
			<input type="text" class="form-control" name="me_id">
			
		</div>
		<div class="form-group">
			<label>비번</label>
			<input type="password" class="form-control" name="me_pw" id="pw">
		</div>
		
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="checkbox" class="form-check-input" value="true" name="autoLogin">자동로그인
		  </label>
		</div>
		<button class="btn btn-outline-warning col-12">로그인</button>
	</form>
</body>
</html>