<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운영시간 등록</title>
</head>
<style>
	body {
        text-align: center;
    }
    .day-group {
        margin-bottom: 40px;
    }
    .time-label {
        display: inline-block;
        width: 280px;
    }
    .form-check-inline {
        margin-right: 20px;
    }
    .op_day, .op_open, .op_close{
    	 margin-right: 20px;
    }
 
</style>
<body>
	<h1 class="display-3"><span style="color: black; font-weight: bold;">운영시간 등록</span></h1> <br>
	<form action="<c:url value='/businessman/operatingInsert'/>" method="post">
	 	<div class="form-group" hidden="hidden">
			<label for="op_fa_num">시설 번호</label>
		    <input type="text" class="form-control" id="op_fa_num" name="fa_num" value="${fa_num}">
		</div>
		<br>
	    <div class="form-group">
			<c:forEach var="i" begin="1" end="7">
				<div class="form-check-inline day-group">
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
				    
				    <select class="form-control op_day" name="operatingList[${i-1 }].op_day" id="op_day_${i}">
				        <option value="${day}">${day}</option>
				    </select>
				    
					<label class="time-label">오픈시간 : </label>
					<select class="form-control op_open" name="operatingList[${i-1 }].op_open" id="op_open_${i}">
					    <c:forEach var="h" begin="0" end="23" step="1">
					        <option><c:out value="${h}" /></option>
					    </c:forEach>
					</select>
					
					<label class="time-label">종료시간 : </label>
					<select class="form-control op_close" name="operatingList[${i-1 }].op_close" id="op_close_${i}">
					    <c:forEach var="h" begin="0" end="23" step="1">
					        <option><c:out value="${h}" /></option>
					    </c:forEach>
					</select>
				</div>
			</c:forEach>
	    </div> 
   	    <button class="btn btn-secondary btn-block">등록</button><br>
	</form> 

</body>
</html>