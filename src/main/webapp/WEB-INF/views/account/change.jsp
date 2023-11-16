<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.container-body{
		background-color: #f0f0f0; height: 100%; padding: 100px 0 100px 0;
		border-radius: 40px;
	}
	form{ text-align: center;}
	.form-group label{margin: 0 auto;}
	.form-group{display:block; text-align: center;}
	.form-group input, .form-group select{ margin: 0 auto;}
	.form-group label{ margin-bottom: 10px;}
	.form-control{ width: 400px; border-radius: 20px;}
	.btn{
		border-radius: 3px; width: 400px; height: 45px; border: none;
		background-color: #0c0c0c; color: white; font-weight: 900; margin-top: 50px;
	}

</style>
<title>환급 계좌 수정</title>
</head>
<body>
<div class="container-body">
	<p style="font-size: 45px; font-weight: bolder;
		text-align: center; padding: 50px 0 20px 0;">환급 계좌 수정</p>
	<form action="<c:url value='/account/change'/>" method="post">
		<div class="form-group">
			<input type="hidden" class="form-control" name="ac_me_num" value="${user.me_num}" >
		</div>
		<div class="form-group">
			<label>예금주명</label>
			<input type="text" class="form-control" name="ac_me_name" value="${user.me_name}" style="text-align: center;" readonly>
		</div>
		<div class="form-group">
			<select class="form-control" name="ac_ba_name">
				<option value="0" >은행 선택</option>
				<c:forEach items="${bankList}" var="bank">
			    	<option value="${bank.ba_name}" <c:if test="${account.ac_ba_name == bank.ba_name }">selected</c:if> >${bank.ba_name}</option>
				</c:forEach>
		    </select>
			<label style="margin-top: 30px;">계좌번호</label>
			<input type="number" class="form-control" name="ac_num" value="${account.ac_num }">
		</div>
		<button class="btn">등록</button>
	</form>
</div>	
</body>
</html>