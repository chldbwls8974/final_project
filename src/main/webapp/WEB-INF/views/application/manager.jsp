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
	  <div class="form-group">
	    <label for="id">아이디:</label>
	    <input type="text" class="form-control" id="id" name="me_id" value="${user.me_id }" >
	  </div>
	  <div class="form-group">
	    <label for="name">이름:</label>
	    <input type="text" class="form-control" id="name" name="me_name" required>
	  </div>
	  <div class="form-group">
	    <label for="phone">전화번호:</label>
	    <input type="text" class="form-control" id="phone" name="me_phone" placeholder="-를 제외하고 입력하세요." oninput="autoHyphen(this)" maxlength="14" required>
	  </div>
	  <div class="form-group">
	    <label for="phone">자기소개서 & 이력서 첨부</label> <br>
	    <input type="file" name="files"> <br>
		<input type="file" name="files"> <br>
		<input type="file" name="files"> <br>
	  </div>
  	  <button type="submit" class="btn btn-primary">신청하기</button>
	</form>
	

	<script type="text/javascript">	
		//자동으로 하이픈(-)으로 구분된 전화번호 형식으로 변환하는 메서드
		function autoHyphen(target) {
			//target의 값을 자체로 다시 설정
   			target.value = target.value
	   			//대괄호 안에서 ^는 '부정'을 의미. g 플래그는 전체 문자열에서 모든 일치 항목을 찾음. 따라서, 숫자가 아닌 모든 문자를 제거. 
        		.replace(/[^0-9]/g, '')
        		//숫자만 남은 문자열을 전화번호 형식으로 변환
        		.replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
		}
	</script>
</body>
</html>