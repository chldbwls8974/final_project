<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>매치 페이지</title>
	<style type="text/css">
	nav{width: 100%; display: flex;}
	.left-box{flex: 2;}
	.right-box{flex: 1; height: 500px; padding-left: 10px}
	.contents-box{padding-top: 10px}
	.info-box{
	width: 100%; background-color: white; height: 300px; margin-bottom: 10px;
	border: 3px solid black; box-sizing: border-box;
	}
	.application-box{
	width: 100%; height: 500px; float: right;
	border: 3px solid black; box-sizing: border-box;
	}
	</style>
</head>
<body>
	<h1>매치 페이지</h1>
	${match}
	<nav class="container">
		<div class="contents-box left-box">
			<div class="info-box match-box"></div>
			<div class="info-box factility-box"></div>
		</div>
		<div class="contents-box right-box">
			<div class="application-box">
				<span>가격 : </span>
			</div>
		</div>
	</nav>
	<script type="text/javascript">
	
	</script>
</body>
</html>
