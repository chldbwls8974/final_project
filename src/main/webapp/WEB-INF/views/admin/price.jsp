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

<!-- 데이트피커 디자인 -->	
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<style type="text/css">

.container-body{ 
	background-color: #f0f0f0; width: 100%; height: auto; padding: 70px 0 70px 0;
	border-radius: 30px; margin: 50px 0 50px 0;
}
.container-inner{
	background-color: white; border-radius: 50px; width: 600px;
	margin: 0 auto; padding: 20px;
}

.form-control{border-radius: 30px; width: 300px;}
.form-group input, .form-group .btn{ display: block; margin: 0 auto; margin-bottom: 30px;}
.form-group label{ text-align: center; display: block; margin: 0 auto;}
.btn{border-radius: 3px; width: 300px; height: 45px; border: none;
	background-color: #0c0c0c; color: white; font-weight: 900; margin: 50px 0 50px 0;}
.table{ text-align: center; width: 50%; margin: 0 auto;}
.table thead th{ border-bottom: none;}
.table td{ border-top: none; }

</style>
</head>
<body>
<div class="container-body">
	<p style="font-size: 40px; font-weight: bolder; text-align: center;
		margin-bottom: 50px; letter-spacing: -3px;">이용가격 수정</p>
	<form action="<c:url value=''/>" method="post" id="myForm">
		<div class="form-group">
			<label>평일 개인</label>
			<input type="number" class="form-control" name="price" placeholder="${list[0].ex_price }">
			<label>주말 개인</label>
			<input type="number" class="form-control" name="price" placeholder="${list[1].ex_price }">
			<label>평일 클랜</label>
			<input type="number" class="form-control" name="price" placeholder="${list[2].ex_price }">
			<label>주말 클랜</label>
			<input type="number" class="form-control" name="price" placeholder="${list[3].ex_price }">
			<label>변경 적용일</label>
			 <input type="text" class="form-control" name="date" id="date"
			 	 placeholder="적용일을 선택하세요." style="text-align: center;" required>
			<button class="btn">제출</button>
		</div>
	</form>
	
	<c:if test="${list[0].ex_pre > 0}">
	
		<div class="container-inner">
			<p style="font-weight: bolder; text-align: center; color: #97c76b;">
				변경 예정일은 ${list[0].ex_date } 입니다</p>
		
			<table class="table">
		    <thead>
		      <tr>
		        <th>구분</th>
		        <th>변경 예정 금액</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		        <td>평일 개인</td>
		        <td>${list[0].ex_pre }</td>
		      </tr>
		      <tr>
		        <td>주말 개인</td>
		        <td>${list[1].ex_pre }</td>
		      </tr>
		      <tr>
		        <td>평일 클랜</td>
		        <td>${list[2].ex_pre }</td>
		      </tr>
		      <tr>
		        <td>주말 클랜</td>
		        <td>${list[3].ex_pre }</td>
		      </tr>
		    </tbody>
		  </table>
		</div>
	</c:if>
	
</div>	
	
<script type="text/javascript">

	 // 데이트피커
	 $(document).ready(function(){
		$("#date").flatpickr({
			  showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
             // buttonImage: "/application/db/jquery/images/calendar.gif", // 버튼 이미지
             //buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
             locale: 'ko',
             altInput: true, // 선택한 날짜를 입력란에 보여주도록 설정
             altFormat: "yy-mm-dd", // 입력란에 표시될 날짜 형식 설정
             changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
             changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
             minDate: '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.
             maxDate: 'today',
             nextText: '다음 달', // next 아이콘의 툴팁.
             prevText: '이전 달', // prev 아이콘의 툴팁.
             numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
             stepMonths: 1, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
             yearRange: 'c-100:c+100', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
             showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. ( ...으로 표시되는부분이다.) 
             closeText: '닫기',  // 닫기 버튼 패널
             showAnim: "slide", //애니메이션을 적용한다.  
             showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
	        })
		})
		
	$( function() {
   $( "#date" ).flatpickr({ 
       onSelect: function() { 
           var date = $.flatpickr.formatDate("yymmdd",$("#datepicker").flatpickr("getDate")); 
           alert(date);
       }
	    });                    
	});
		
</script>
</body>
</html>