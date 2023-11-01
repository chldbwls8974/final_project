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
	<h1>이용가격 수정</h1>
	<form action="<c:url value=''/>" method="post" id="myForm">
		<div class="form-group">
			<label>평일개인</label>
			<input type="number" class="form-control" name="price" placeholder="${list[0].ex_price }">
			<label>주말개인</label>
			<input type="number" class="form-control" name="price" placeholder="${list[1].ex_price }">
			<label>평일클랜</label>
			<input type="number" class="form-control" name="price" placeholder="${list[2].ex_price }">
			<label>주말클랜</label>
			<input type="number" class="form-control" name="price" placeholder="${list[3].ex_price }">
			<label>변경적용일</label>
			 <input type="text" class="form-control" name="date" id="date" required>
			<button class="btn btn-outline-warning col-12">제출</button>
		</div>
	</form>
	
	<c:if test="${list[0].ex_pre > 0}">
	
	<div class="container">
		<h1>변경예정</h1>
		<p>변경예정일은 ${list[0].ex_date } 입니다</p>
	
		<table class="table">
	    <thead>
	      <tr>
	        <th>구분</th>
	        <th>변경예정금액</th>
	      </tr>
	    </thead>
	    <tbody>
	      <tr>
	        <td>평일개인</td>
	        <td>${list[0].ex_pre }</td>
	      </tr>
	      <tr>
	        <td>주말개인</td>
	        <td>${list[1].ex_pre }</td>
	      </tr>
	      <tr>
	        <td>평일클랜</td>
	        <td>${list[2].ex_pre }</td>
	      </tr>
	      <tr>
	        <td>주말클랜</td>
	        <td>${list[3].ex_pre }</td>
	      </tr>
	    </tbody>
	  </table>
	</div>
	</c:if>
	
	
	
	<script type="text/javascript">
	 // 데이트피커
	 $(document).ready(function(){
		$("#date").datepicker({
			  showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
              // buttonImage: "/application/db/jquery/images/calendar.gif", // 버튼 이미지
              //buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
              changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
              changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
              minDate: 'today',
              nextText: '다음 달', // next 아이콘의 툴팁.
              prevText: '이전 달', // prev 아이콘의 툴팁.
              numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
              stepMonths: 1, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
              yearRange: ':c+100', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
              showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. ( ...으로 표시되는부분이다.) 
              closeText: '닫기',  // 닫기 버튼 패널
              dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
              showAnim: "slide", //애니메이션을 적용한다.  
              showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
              dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
              monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
	        })
	        
		})
		
	</script>
</body>
</html>