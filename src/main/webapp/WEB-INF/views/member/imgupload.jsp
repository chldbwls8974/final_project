<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 사진 변경</title>
</head>
<body>
	<form class="myprofile-photo" action="profile" method="post" enctype="multipart/form-data">			
		<div>
			<input type="file" name="me_profile" onchange="imageChoose(this)">
			<button type="submit">변경하기</button>
		</div>
	</form>
</body>
</html>