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
	<form action="<c:url value='/application/businessman'/>" method="post" class="was-validated" enctype="multipart/form-data">
	  <div class="form-group" hidden="hidden">
	    <label for="bo_bt_num">게시글번호:</label>
	    <input type="text" class="form-control" id="bo_bt_num" name="bo_bt_num" value="7" readonly>
	  </div>
	  <br>
	  <div class="form-group">
	  	<label for="bo_contents" style="font-weight: bold;">대표자명 / 대표 전화번호 / 대표 이메일을 작성해주세요</label>
	    <textarea class="form-control" id="bo_contents" name="bo_contents" rows="3">
	    [대표자명] : 
	    [대표 연락처] : 
	    [대표 이메일] : 
	    </textarea>
	  </div>
	  <br>
	  <div class="form-group">
	    <label style="font-weight: bold;">사업자 등록증 첨부</label> <br>
	    <input type="file" class="form-control" name="files" required> <br>
		<input type="file" class="form-control" name="files"> <br>
	  </div>
  	  <a href="<c:url value='/'/>"><button type="submit" class="btn btn-primary">신청하기</button></a>	
	</form>
	<a href="<c:url value='/'/>"><button type="button" class="btn btn-danger">뒤로가기</button></a>

</body>
</html>