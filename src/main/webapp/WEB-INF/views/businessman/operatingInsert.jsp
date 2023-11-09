<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운영시간</title>
</head>
<body>
	<h1 class="display-3"><span style="color: black; font-weight: bold;">운영시간</span></h1> <br>
	<form action="<c:url value='/businessman/operatingInsert'/>" method="post">
	 	<div class="form-group" hidden="hidden">
			<label for="op_fa_num">시설 번호</label>
		    <input type="text" class="form-control" id="op_fa_num" name="op_fa_num" value="${fa_num}">
		</div>
		
	    <div class="form-group">
			<c:forEach var="i" begin="1" end="7">
				<div class="form-check-inline">
	            	<input type="checkbox" class="day_checkbox" id="checkbox_${i}" data-target="${i}">
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
				    <select class="form-control op_day" name="op_day" id="op_day_${i}" disabled>
				        <option value="${day}">${day}</option>
				    </select>
				    
					<label >오픈시간:</label>
					<select class="form-control op_open" name="op_open" id="op_open_${i}" disabled>
					    <c:forEach var="h" begin="0" end="23" step="1">
					        <option><c:out value="${h < 10 ? '0' : ''}${h}:00" /></option>
					    </c:forEach>
					</select>
					
					<label>종료시간:</label>
					<select class="form-control op_close" name="op_close" id="op_close_${i}" disabled>
					    <c:forEach var="h" begin="0" end="23" step="1">
					        <option><c:out value="${h < 10 ? '0' : ''}${h}:00" /></option>
					    </c:forEach>
					</select>
				</div>
			</c:forEach>
	    </div> 
   	    <button class="btn btn-secondary btn-block">등록</button><br>
	</form> 



	<script type="text/javascript">	
		//체크박스에 체크하지 않은 요일은 비활성화(체크한 것만 활성화)
		 $(document).on('click', '.day_checkbox', function() {
			    var target = $(this).data('target');
			    var op_day_select = $('#op_day_' + target);
			    var op_open_select = $('#op_open_' + target);
			    var op_close_select = $('#op_close_' + target);
				
			    //체크박스에 체크가 되면 활성화
			    if ($(this).is(':checked')) {
			        op_day_select.prop('disabled', false);
			        op_open_select.prop('disabled', false);
			        op_close_select.prop('disabled', false);
			    } else {//체크박스에 체크가 해제되면 비활성화
			        op_day_select.prop('disabled', true);
			        op_open_select.prop('disabled', true);
			        op_close_select.prop('disabled', true);
			    }
			});

		
	</script>

</body>
</html>