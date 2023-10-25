<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 신청</title>
</head>
<body>
	<h1>사업자 신청</h1>
	<form action="<c:url value='/application/businessman'/>"  class="was-validated">
	  <div class="form-group">
	    <label for="bo_bt_num">게시글번호:</label>
	    <input type="text" class="form-control" id="bo_bt_num" name="bo_bt_num" value="7" readonly>
	  </div>
	  <div class="form-group">
	    <label>사업자 등록증 첨부</label> <br>
	    <input type="file" class="form-control" name="files" required> <br>
		<input type="file" class="form-control" name="files"> <br>
	  </div>
  	<a href="<c:url value='/'/>"><button type="submit" class="btn btn-primary">신청하기</button></a>
	</form>
	
</body>
</html>