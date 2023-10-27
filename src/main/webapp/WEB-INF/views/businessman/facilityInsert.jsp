<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 등록</title>
</head>
<body>
	<h1>시설 등록</h1>
	<form action="<c:url value='/businessman/facilityInsert'/>" method="post">
	  <div class="form-group">
	    <label for="fa_bu_num">사업자 번호:</label>
	    <input type="text" class="form-control" id="fa_bu_num" name="fa_bu_num" value="${business.bu_num}" readonly>
	  </div>
	  
	  <div class="form-group">
	    <label for="fa_rg_num">지역 번호:</label>
	    <input type="text" class="form-control" id="fa_rg_num" name="fa_rg_num" >
	  </div>
	  
	  <div class="form-group">
	    <label for="fa_name">시설명:</label>
	    <input type="text" class="form-control" placeholder="시설명을 입력하세요" id="fa_name">
	  </div>
	  <div class="form-group">
		<label for="fa_add">주소:</label>
		  <input type="text" class="form-control" placeholder="주소를 입력하세요" id="fa_add">
	  </div>
	  <div class="form-group">
		  <label for="fa_add_detail">상세주소:</label>
		  <input type="text" class="form-control" placeholder="상세 주소를 입력하세요" id="fa_add_detail">
	  </div>
	 
	  <div class="form-group">
	    <label for="fa_phone">전화번호:</label>
	    <input type="text" class="form-control" id="fa_phone" placeholder="-를 제외하고 입력하세요" oninput="autoHyphen(this)" maxlength="14">
	  </div>
	  
	  <h3>부대시설</h3>
	  <div class="form-group">
	    <label for="fa_pay">주차장</label>
	    <div class="form-check-inline">
		  <label class="form-check-label">
		  	<input type="radio" class="form-check-input" name="fa_pay" value="0">없음
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="fa_pay" value="1">무료
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="fa_pay" value="2">유료
		  </label>
		</div>
	  </div>
	  <div class="form-group">
	    <label for="fa_locker">탈의실</label>
	    <div class="form-check-inline">
		  <label class="form-check-label">
		  	<input type="radio" class="form-check-input" name="fa_locker" value="0">없음
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="fa_locker" value="1">있음
		  </label>
		</div>
	  </div>
	  <div class="form-group">
	    <label for="fa_toilet">화장실</label>
	    <div class="form-check-inline">
		  <label class="form-check-label">
		  	<input type="radio" class="form-check-input" name="fa_toilet" value="0">없음
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="fa_toilet" value="1">있음
		  </label>
		</div>
	  </div>
	  <div class="form-group">
	    <label for="fa_shower">샤워실</label>
	    <div class="form-check-inline">
		  <label class="form-check-label">
		  	<input type="radio" class="form-check-input" name="fa_shower" value="0">없음
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="fa_shower" value="1">있음
		  </label>
		</div>
	  </div>
	  <div class="form-group">
	    <label for="fa_smoking">흡연장</label>
	    <div class="form-check-inline">
		  <label class="form-check-label">
		  	<input type="radio" class="form-check-input" name="fa_smoking" value="0">없음
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="fa_smoking" value="1">있음
		  </label>
		</div>
	  </div>
	  <div class="form-group">
	    <label for="fa_machine">자판기</label>
	    <div class="form-check-inline">
		  <label class="form-check-label">
		  	<input type="radio" class="form-check-input" name=fa_machine value="0">없음
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="fa_machine" value="1">있음
		  </label>
		</div>
	  </div>
	  
	  <div class="form-group">
		  <label for="fa_note">특이사항:</label>
		  <textarea class="form-control" rows="5" id="fa_note" name="fa_note"></textarea>
	  </div>
	  <button class="btn btn-outline-dark col-12">등록</button>

	</form>
	  <div align="right" class="mt-3">
			<a class="btn btn-float-left btn btn-danger mt-1 col-3 "
				role="button" href="<c:url value='/'/>">취소</a>
	  </div>


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