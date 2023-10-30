<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		
		<h1>카카오 로그인</h1>
		<form action="<c:url value='/kakao/login'/>" method="post" id="myForm">
		<input name="user" value="${user }">
		<button name="btn">-</button>
		</form>
</body>
	<script type="text/javascript"> 
 	window.onload = function() {
 	    document.getElementById("myForm").submit();
 	}
 	</script> 
</html>