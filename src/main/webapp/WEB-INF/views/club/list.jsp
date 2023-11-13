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

.title{ font-size: 30px; font-weight: bolder; text-align: center;
		 letter-spacing: -3px;
}
.clublist-control{
	padding: 20px; background-color: #f0f0f0; border-radius: 40px;
	margin-bottom: 30px;
}
.clublist-link{ display: inline-block; }

</style>
</head>
<body>
<div class="container">
<p class="title">모든 클럽 조회</p>
  <ul class="clublist-control">
  <c:forEach items="${list}" var="list">
  	<li class="clublist-link">
  		<a href="<c:url value='/club/detail?cl_num=${list.cl_num}'/>">
		  	<div>
		  		<img alt="팀엠블럼" src="<c:url value='https://ifh.cc/g/v9LAF1.jpg'/>"
		  			style="width: 70px; height: 70px; border-radius: 50%">
		  	</div>
		  	<div>
			  	<span>${list.cl_name }</span> 
	  	</a>
  	</li>
  </c:forEach>
  </ul>
</div>
</body>
</html>