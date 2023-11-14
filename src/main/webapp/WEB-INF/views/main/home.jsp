<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Home</title>
	<style>
	.box{
		diplay : flex;
		justify-content : flex-end;
		height : 100vh;
		align-items :flex-start;
	}
    .image-container {
      display: flex;
      flex-direction : column;
      align-items:flex-end;
    }

    .item {
      max-width: 100%; /* 이미지 크기 조절 */
      height: auto; /* 비율 유지를 위해 */
    }

	</style>
</head>
<body>
	<h1>메인</h1>
	${user}
	
	<div class="box">
		<div class="image-container">
		  <img class="item" src="<c:url value='/resources/main/main1.png'/>" alt="Image 1">
		  <img class="item" src="<c:url value='/resources/main/main2.png'/>" alt="Image 2">
		  <img class="item" src="<c:url value='/resources/main/main3.png'/>" alt="Image 3">
		</div>
	</div>
<script>

  
</script>
</body>
</html>
