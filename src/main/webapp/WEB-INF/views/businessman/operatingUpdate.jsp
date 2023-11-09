<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운영시간 수정</title>
</head>
<body>
	<h1 class="display-3"><span style="color: black; font-weight: bold;">운영시간 수정</span></h1> <br>
	<form action="<c:url value='/businessman/operatingUpdate'/>" method="post">
	<input name="op_num" value="${operating.op_num}" hidden="hidden">
	 	<div class="form-group" hidden="hidden">
			<label for="op_fa_num">시설 번호</label>
		    <input type="text" class="form-control" id="op_fa_num" name="fa_num" value="${fa_num}">
		</div>
		
	    <div class="form-group">
			<c:forEach var="i" begin="1" end="7">
				<div class="form-check-inline">
					<c:choose>
				        <c:when test="${i == 1}">
				            <c:set var="day" value="월" />
				        </c:when>
				        <c:when test="${i == 2}">
				            <c:set var="day" value="화" />
				        </c:when>
				        <c:when test="${i == 3}">
				            <c:set var="day" value="수" />
				        </c:when>
				        <c:when test="${i == 4}">
				            <c:set var="day" value="목" />
				        </c:when>
				        <c:when test="${i == 5}">
				            <c:set var="day" value="금" />
				        </c:when>
				        <c:when test="${i == 6}">
				            <c:set var="day" value="토" />
				        </c:when>
				        <c:when test="${i == 7}">
				            <c:set var="day" value="일" />
				        </c:when>
				    </c:choose>
				    
				    <label for="op_day_${i}" >요일 선택:</label>
				    <select class="form-control op_day" name="operatingList[${i-1 }].op_day" id="op_day_${i}">
				        <option value="${day}">${day}</option>
				    </select>
				    
					<label >오픈시간:</label>
					<select class="form-control op_open" name="operatingList[${i-1 }].op_open" id="op_open_${i}">
					    <c:forEach var="h" begin="0" end="23" step="1">
					        <option><c:out value="${h}" /></option>
					    </c:forEach>
					</select>
					
					<label>종료시간:</label>
					<select class="form-control op_close" name="operatingList[${i-1 }].op_close" id="op_close_${i}">
					    <c:forEach var="h" begin="0" end="23" step="1">
					        <option><c:out value="${h}" /></option>
					    </c:forEach>
					</select>
				</div>
			</c:forEach>
	    </div> 
   	    <button class="btn btn-secondary btn-block">수정완료</button><br>
	</form> 


	<script type="text/javascript">	
		//숫자만 입력되도록 하는 메서드
		function numOnly(target) {
	        //입력값이 5자리 이상인 경우 마지막 5자리만 유지
   			target.value = target.value.slice(0, 5);
		}
		function numOnly2(target) {
	        //입력값이 2자리 이상인 경우 마지막 2자리만 유지
   			target.value = target.value.slice(0, 2);
		}
	</script>
	
</body>
</html>