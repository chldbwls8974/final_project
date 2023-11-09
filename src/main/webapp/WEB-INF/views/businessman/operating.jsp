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
  	<h1 class="display-3"><span style="color: black; font-weight: bold;">운영시간</span></h1>
	<br>
	<form action="<c:url value='/businessman/operating'/>" method="get">
  	  <div class="table-responsive">
	    <table class="table table-light table-striped">
	      <thead>
	        <tr class="table-Info">
	          <th>운영시간 번호</th>
	          <th>요일</th>
	          <th>오픈시간</th>
	          <th>마감시간</th>
	          <th hidden="hideen">시설번호</th>
	        </tr>
	      </thead>
		  <tbody>
	      	<c:forEach items="${operatingList}" var="operating">
		        <tr>
		          <td>${operating.op_num}</td>
		          <td>${operating.op_day}</td>
		          <td>${operating.op_open}시</td>
		          <td>${operating.op_close}시</td>
		          <td hidden="hideen">${operating.op_fa_num}</td>
	         	</tr>
		     </c:forEach>
	       </tbody>
	     </table>
	   </div>
	</form>
	  
	   <div align="right" class="mt-3">
		   <a class="btn btn-secondary btn-block" role="button" href="<c:url value='/businessman/operatingUpdate/${facility.fa_num}'/>">수정하기</a>
	   </div>
	   <br>
</body>
</html>