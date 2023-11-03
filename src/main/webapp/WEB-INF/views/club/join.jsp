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
	<form action="<c:url value='/club/join'/>" method="post">
		<div class="form-group">
			<p>간단한 자기소개를 부탁해요.</p>
			<input type="hidden" name="cm_cl_num" value="${club.cl_num}">
			<input type="hidden" name="cm_me_num" value="${user.me_num}">
			<textarea rows="" cols="" name="cm_introduction"></textarea>
			<button class="btn btn-outline-success">제출하기</button>
		</div>
	</form>
</body>
</html>