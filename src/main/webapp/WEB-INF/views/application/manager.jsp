<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매니저 신청</title>
</head>
<body>
	<h1>매니저 신청</h1>
	<form action="<c:url value='/application/manager'/>"  class="was-validated" method="post" enctype="multipart/form-data">
	  <div class="form-group" hidden="hidden">
	    <label for="bo_bt_num">게시글번호:</label>
	    <input type="text" class="form-control" id="bo_bt_num" name="bo_bt_num" value="6" readonly>
	  </div>
	  
	  <div class="form-group" >
	    <label for="bo_me_num">회원번호</label>
	    <input type="text" class="form-control" id="bo_me_num" name="bo_me_num" value="${user.me_num}" readonly>
	  </div>
	  
	  <div class="form-group">
	    <label>자기소개서 & 이력서 첨부</label> <br>
	    <input type="file" class="form-control" name="files" required> <br>
		<input type="file" class="form-control" name="files"> <br>
		<input type="file" class="form-control" name="files"> <br>
	  </div>
  	<a href="<c:url value='/'/>"><button type="submit" class="btn btn-primary">신청하기</button></a>
	</form>
	
</body>
</html>