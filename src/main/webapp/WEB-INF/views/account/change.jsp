<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<title>환급 계좌 수정</title>
</head>
<body>
${account }
	<h1>환급 계좌 수정</h1>
	<form action="<c:url value='/account/change'/>" method="post">
		<div class="form-group">
			<label>회원번호</label>
			<!-- 세션에서 회원번호 가져오도록 수정해야 함. -->
			<input type="text" class="form-control" name="ac_me_num">
		</div>
		<div class="form-group">
			<label>은행명</label>
			<input type="text" class="form-control" name="ac_ba_name">
		</div>
		<div class="form-group">
			<label>예금주명</label>
			<input type="text" class="form-control" name="ac_me_name">
		</div>
		<div class="form-group">
			<label>계좌번호</label>
			<input type="number" class="form-control" name="ac_num">
		</div>
		<button class="btn btn-outline-warning col-12">등록</button>
	</form>
</body>
</html>