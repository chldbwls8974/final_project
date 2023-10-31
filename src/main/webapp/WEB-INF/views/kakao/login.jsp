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
	<form action="<c:url value='/kakao/login'/>" method="post" id="myForm">
	<input name="me_id" value="${user.me_id }">
	<button name="btn">-</button>
	</form>
</body>
 	<script type="text/javascript"> 
  	window.onload = function() {
  	    document.getElementById("myForm").submit();
  	}
 	</script> 
</html>