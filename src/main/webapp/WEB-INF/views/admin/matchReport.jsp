<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<title>매치 신고 관리</title>
</head>
<style>
	.btn-info{
		color : outline-info;
		background-color : white;
		border : 1px solid outline-info;
	}
	.btn-info:hover{
		background-color : outline-info;
		color : white;
	}
	h1{
		text-align : center
	}
	.error {
		color: #f00;
		display: block;
	}
</style>
<body>
	<h1>매치 신고 관리</h1>
	<br>
	<hr>
	<div class="btn-group btn-group">
	  <button type="button"
				    class="btn btn-outline-info btn-info" onclick="location.href='<c:url value='/admin/boardReport'/>'">커뮤니티 신고</button>
	  <button type="button"
				    class="btn btn-outline-info btn-info" onclick="location.href='<c:url value='/admin/matchReport'/>'">매치 신고</button>
	</div>
</body>

<script type="text/javascript">
</script>
</html>