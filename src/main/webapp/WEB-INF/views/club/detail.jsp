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
</style>
</head>
<body>
${club }
	<div class="container">
	<a href="<c:url value='/club/join?cl_num=${club.cl_num}'/>">
	 	<button type="button" class="btn btn-outline-success">가입신청하기</button>
	 </a>
	<a href="<c:url value='/club/update?cl_num=${club.cl_num}'/>">
	 	<button type="button" class="btn btn-outline-success">수정하기</button>
	 </a>
	</div>
</body>
</html>