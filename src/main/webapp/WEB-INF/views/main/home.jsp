<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<h1>메인</h1>
	<a href="<c:url value='/schedule/insert'/>">
		<button>스케쥴 등록</button>
	</a>
</body>
</html>