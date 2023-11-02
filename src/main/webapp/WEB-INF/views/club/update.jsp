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
<div class="container">
<h1>클럽 조회</h1>
  <ul>
  <c:forEach items="${list}" var="list">
  	<li>
  		<a href="<c:url value='/club/detail?cl_num=${list.cl_num}'/>">
		  	<div>
		  		<img alt="팀프로필넣고싶어" src="<c:url value='/resource/profile/basic'/>">
		  	</div>
		  	<div>
			  	<span>${list.cl_name }</span> 
			  	<span>${list.cl_rg_num }</span>
		  	</div>
	  	</a>
  	</li>
  </c:forEach>
  </ul>
</div>
</body>
</html>