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
			<input type="number" class="form-control" name="price" placeholder="${list[0].ex_price }원">
			<label>주말 개인</label>
			<input type="number" class="form-control" name="price" placeholder="${list[1].ex_price }원">
			<label>평일 클랜</label>
			<input type="number" class="form-control" name="price" placeholder="${list[2].ex_price }원">
			<label>주말 클랜</label>
			<input type="number" class="form-control" name="price" placeholder="${list[3].ex_price }원">
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
		        <td>${list[0].ex_pre } 원</td>
		      </tr>
		      <tr>
		        <td>주말 개인</td>
		        <td>${list[1].ex_pre } 원</td>
		      </tr>
		      <tr>
		        <td>평일 클랜</td>
		        <td>${list[2].ex_pre } 원</td>
		      </tr>
		      <tr>
		        <td>주말 클랜</td>
		        <td>${list[3].ex_pre } 원</td>
		      </tr>
		    </tbody>
		  </table>
		</div>
	</c:if>
	
</div>	
	
<script type="text/javascript">

// 데이트피커
$( function() {
    var today = new Date();
    // 한 달을 더합니다.
    today.setMonth(today.getMonth() + 1);
$( "#date" ).flatpickr({ 
	minDate: today, // 오늘 이후의 날짜만 선택 가능
    format: "yy-mm-dd",
    onSelect: function() { 
        var date = $.flatpickr.formatDate("yy-mm-dd",$("#datepicker").flatpickr("getDate")); 
        alert(date);
    }
    });                    
});

		
</script>
</body>
</html>