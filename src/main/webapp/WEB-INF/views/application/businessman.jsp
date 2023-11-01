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
	<h1 class="display-3"><span style="color: skyblue; font-weight: bold;">사업자 신청</span></h1>
	<form action="<c:url value='/application/businessman'/>" method="post" enctype="multipart/form-data">
	  <div class="form-group" hidden="hidden">
	    <label for="bo_bt_num">게시글번호:</label>
	    <input type="text" class="form-control" id="bo_bt_num" name="bo_bt_num" value="7" readonly>
	  </div>
	  <br>
	  <div class="form-group" hidden="hidden">
	    <label for="bo_me_num">회원번호:</label>
	    <input type="text" class="form-control" id="bo_me_num" name="bo_me_num" value="${user.me_num}" readonly>
	  </div>
	  <br>
	  <div class="form-group">
		<h5><kbd>대표자명</kbd> / <kbd>대표 전화번호</kbd> / <kbd>대표 이메일</kbd>을 작성해주세요</h5>
	    <textarea class="form-control" id="bo_contents" name="bo_contents" rows="3">
	    [대표자명] : 
	    [대표 연락처] : 
	    [대표 이메일] : 
	    </textarea>
	  </div>
	  <br>
	  <br>
	  <div class="form-group">
	    <h5><kbd>사업자등록증</kbd> 첨부</h5>
	    <input type="file" class="form-control" name="files" required> <br>
		<input type="file" class="form-control" name="files"> <br>
	  </div>
  	  <a href="<c:url value='/'/>"><button type="submit" class="btn btn-secondary btn-block">신청하기</button></a>	
	</form>

</body>
</html>