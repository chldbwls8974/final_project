<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 프로필 수정</title>
</head>
<body>
	<form class="myprofile-photo" action="profile" method="post" enctype="multipart/form-data">			
		<div>
			<input type="file" name="me_profile" onchange="imageChoose(this)">
			<button type="submit">변경하기</button>
			아이디 : <input type = "text" name = "userId"/><br>
	        비밀번호 : <input type = "password" name = "userPwd"/><br>
	        닉네임 : <input type = "text" name = "userNick"/><br>
	        나이 : <input type = "number" min="0" name = "userAge"/><br>
		</div>
	</form>
</body>
</html>