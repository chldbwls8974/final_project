<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기장 리스트</title>
</head>
<body>
	<h1>경기장 리스트</h1>
	${facility}
	  <div class="table-responsive">
	  	<input type = "text" class="form-control" readonly value="${stadium}">
	    <table class="table table-bordered">
	      <thead>
	        <tr>
	          <th>경기장 번호</th>
	          <th>이름</th>
	          <th>위치</th>
	          <th>실내/외</th>
	          <th>바닥종류</th>
	          <th>가로</th>
	          <th>세로</th>
	          <th>최대인원</th>
	          <th>이용가능여부</th>
	          <th>특이사항</th>
	          <th>시설번호</th>
	          <th>수정</th>
	          <th>삭제</th>
	        </tr>
	      </thead>
		  <tbody>
	      	<c:forEach items="${stadiumList}" var="stadium">
		        <tr>
		          <td>${stadium.st_num}</td>
		          <td>${stadium.st_name}</td>
		          <td>${stadium.st_locate}</td>
		          <td>${stadium.st_door}</td>
		          <td>${stadium.st_floortype}</td>
		          <td>${stadium.st_width}</td>
		          <td>${stadium.st_height}</td>
		          <td>${stadium.st_max}</td>
		          <td>${stadium.st_available}</td>
		          <td>${stadium.st_note}</td>
		          <td>${stadium.st_fa_num}</td>
		          <td><a href="<c:url value='/businessman/stadiumUpdate?st_num=${stadium.st_num}'/>"
							class="btn btn-outline-secondary" role="button">수정</a></td>
			      <td>
					<form action="<c:url value='/businessman/stadiumDelete'/>" method="post">
						<button class="btn btn-outline-dark btn-businessman-stadiumDelete">삭제</button>
						<input type="hidden" name="st_num" value="${stadium.st_num}">
					</form>
	         	 </tr>
		     </c:forEach>
	      </tbody>
	    </table>
	  
		<div align="right" class="mt-3">
			<a class="btn btn-float-right btn btn-primary mt-1 col-3 "
				 role="button" href="<c:url value='/businessman/stadiumInsert/${facility.fa_num}'/>">경기장 등록하기</a>		
		</div>
	  
	  </div>

</body>
</html>