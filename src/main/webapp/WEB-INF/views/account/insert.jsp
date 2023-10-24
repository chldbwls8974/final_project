<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<title>환급 계좌 등록</title>
</head>
<body>
${account }
${bankList }
	<h1>환급 계좌 등록</h1>
	<form action="<c:url value='/account/insert'/>" method="post">
		<div class="form-group">
			<!-- (회원번호) 세션에서 회원번호 가져오도록 수정해야 함. -->
			<input type="hidden" class="form-control" name="ac_me_num" value="${user.me_num}" >
		</div>
		<div class="form-group">
			<label>예금주명</label>
			<input type="text" class="form-control" name="ac_me_name" value="${user.me_name}" readonly>
		</div>
		<div class="form-group">
			<select class="form-control" name="ac_ba_name" required>
				<option value="" >은행 선택</option>
				<c:forEach items="${bankList}" var="bank">
			    	<option value="${bank.ba_name}" >${bank.ba_name}</option>
				</c:forEach>
		    </select>
			<label>계좌번호</label>
			<input type="number" class="form-control" name="ac_num">
		</div>
		<button class="btn btn-outline-dark col-12">등록</button>
	</form>
</body>
</html>