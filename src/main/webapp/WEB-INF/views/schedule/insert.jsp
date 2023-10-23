<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
	<style type="text/css">
		.schedule-box{width: 100%; height: 765px; background-color: green; position : relative}
		.schedule-box::after{clear: both; content: ''; display: block;}
		.week-box{
		width: 90%; height: 750px; background-color: yellow; display: flex;
		border: 1px solid black; border-left: none; border-bottom: none;
		float: right; position : absolute; right: 10px; bottom: 10px}
		.day-box{width: 100%; height: 100%; flex: 1; border-left: 1px solid black;}
		.hour-box{width: 100%; height: 30px; display: flex; border-bottom: 1px solid black; float:left;}
		.time-bar{width: calc(10% - 10px); height: 750px; position: absolute; top: 15px;}
		.hour-bar{width: 100%; height: 30px; text-align: center; line-height: 30px; font: 20px bold;}
		.day-bar{width: 100%; height: 30px; background-color: gray; text-align: center; line-height: 30px; font: 20px bold; border-bottom: 1px solid black;}
	</style>
</head>
<body>
	<h1>스케줄 등록</h1>
	<div>
		<span>경기장 선택 : </span>
		<select class="select-stadium">
				<option>선택</option>
			<c:forEach items="${stadiumList}" var="i">
				<option>${i.st_name}</option>
			</c:forEach>
		</select>
	</div>
	<div class="schedule-box">
		<div class="time-bar">
			<c:forEach begin="0" end="24" var="t">
						<div class="hour-bar">
						${t}
						</div>
					</c:forEach>
		</div>
		<div class="week-box">
			<c:forEach begin="1" end="7" var="i">
				<div class="day-box">
					<div class="day-bar">${timeList[(i - 1) * 24].ti_day}</div>
					<c:forEach begin="0" end="23" var="j">
						<div class="hour-box">
							<span hidden="">${timeList[(i - 1) * 24 + j].ti_num}</span>
						</div>
					</c:forEach>
				</div>
			</c:forEach>
		</div>
	</div>
	<script type="text/javascript">
		$('.select-stadium').change(function() {
			
		});
	</script>
</body>
</html>
