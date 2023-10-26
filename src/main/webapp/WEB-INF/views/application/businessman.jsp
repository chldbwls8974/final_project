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
	<form action="<c:url value='/application/businessman'/>"  class="was-validated" method="post" enctype="multipart/form-data">
	  <div class="form-group" hidden="hidden">
	    <label for="bo_bt_num">게시글번호:</label>
	    <input type="text" class="form-control" id="bo_bt_num" name="bo_bt_num" value="7" readonly>
	  </div>
	  <div class="form-group">
	    <label for="bu_name">대표자명:</label>
	    <input type="text" class="form-control" id="bu_name" name="bu_name" placeholder="대표자명은 한글/영문 2자에서 10자이어야 합니다." required>
	  <div class="error-name" style="color:red"></div>
	  </div>
	  <div class="form-group">
	    <label for="bu_phone">대표 전화번호:</label>
	    <input type="text" class="form-control" id="bu_phone" name="bu_phone" placeholder="-를 제외하고 입력하세요" oninput="autoHyphen(this)" maxlength="14" required>
	  </div>
	  <div class="form-group" name="bu_email">
	    <label for="bu_email">대표 이메일:</label>
		<input class="form-control mb-2 mr-sm-2" id="bu_email" type="text">
		<select class="box" id="domain-list">
	  		<option value="type">직접 입력</option>
	  		<option value="naver.com">naver.com</option>
	  		<option value="google.com">google.com</option>
			<option value="hanmail.net">hanmail.net</option>
			<option value="nate.com">nate.com</option>
			<option value="kakao.com">kakao.com</option>
		</select> 
	  </div>
	  <br>
	  <div class="form-group">
	    <label>사업자 등록증 첨부</label> <br>
	    <input type="file" class="form-control" name="files" required> <br>
		<input type="file" class="form-control" name="files"> <br>
	  </div>
  	<a href="<c:url value='/'/>"><button type="submit" class="btn btn-primary">신청하기</button></a>
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
		
		$('[name=bu_name]').change(checkName);
		$('[name=bu_email]').change(checkEmail);

		$('form').submit(function(){
			let ok = true;

			if(!checkName()){
				ok = false;
			}
			if(!checkEmail()){
				ok = false;
			}

			return ok;
		});

		function checkName(){
			let name = $('[name=bu_name]').val();
			let regex = /^[가-힣a-zA-Z]{2,10}$/;
			if(regex.test(name)){
				$('.error-name').text('');
				return true;
			}else{
				$('.error-name').text('대표자명은 한글/영문 2자에서 10자이어야 합니다.');
				return false;
			}
		}
		
		function checkEmail(){
			let email = $('[name=bu_email]').val();
			// + : 1개이상. () : 패턴
			let regex = /^[a-zA-Z0-9_]+@[a-zA-Z0-9]+(.[a-zA-Z0-9]+)+$/;
			if(regex.test(email)){
				$('.error-email').text('');
				return true;
			}else{
				$('.error-email').text('이메일 형식에 맞지 않습니다.');
				return false;
			}
		}
			
	</script>

</body>
</html>