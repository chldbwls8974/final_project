<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>일정 관리</title>
	<style type="text/css">
		.days-box{width: 100%; height: 50px; display: flex;}
		.day-box{
		height: 70px; background-color: window; flex: 1; border-right: 3px solid black;
		text-align: center;}
		.day-box:last-child{border-right: none}
		.btn-week{width: 20px;}
		.btn-week:hover{background-color: yellow; cursor: pointer;}
		.prev-week{height: 70px; border-right: 3px solid black; line-height: 70px;}
		.next-week{height: 70px; line-height: 70px;}
		.day-span{font-size: 30px;}
		.day_of_week-span{font-size: 15px;}
		.sat{color: blue;}
		.sun{color: red}
		.select-circle{height: 70px; border-radius: 20%; background-color: cyan;}
		.not-select-circle:hover{height: 70px; border-radius: 20%; background-color: yellow; cursor: pointer;}
		.match-box{height: 100px; border-bottom: 2px solid black;}
		.match-box::after{clear: both; content: ''; display: block;}
		.match-box:last-child{border-bottom: none}
		.match-time-box{font-size: 40px; display: inline-block; line-height: 100px}
		.match-info-box{display: inline-block;}
		.btn-manager-match{float: right; margin-top: 30px;}
	</style>
</head>
<body>
	<h1>일정 관리</h1>
	<div class="days-box">
		<div class="prev-week btn-week"><</div>
		<c:forEach items="${week}" var="day">
			<div class="day-box">
				<div class="not-select-circle">
					<input class="select-date-str" value="${day.date_str}" disabled hidden>
					<c:if test="${day.day_of_week != '토' && day.day_of_week != '일'}">
						<span class="day-span">${day.month}/${day.day}</span>
						<br>
						<span class="day_of_week-span">${day.day_of_week}</span>
					</c:if>
					<c:if test="${day.day_of_week == '토'}">
						<span class="day-span sat">${day.month}/${day.day}</span>
						<br>
						<span class="day_of_week-span sat">${day.day_of_week}</span>
					</c:if>
					<c:if test="${day.day_of_week == '일'}">
						<span class="day-span sun">${day.month}/${day.day}</span>
						<br>
						<span class="day_of_week-span sun">${day.day_of_week}</span>
					</c:if>
				</div>
			</div>
		</c:forEach>
		<c:if test="${weekCount != 2}">
			<div class="next-week btn-week">></div>
		</c:if>
	</div>
	<div class="print-match-box">
		
	</div>
	<script type="text/javascript">
	let select_day = "${week[0].date_str}";
	
	$('.day-box').eq(0).children('.not-select-circle').toggleClass('select-circle');
	$('.day-box').eq(0).children('.not-select-circle').toggleClass('not-select-circle');
	printManagerMatch();
	
	$(document).on('click', '.not-select-circle', function() {
		select_day = $(this).children('.select-date-str').val();
		
		$(this).toggleClass('not-select-circle');
		$(this).toggleClass('select-circle');
		$(this).parents('.day-box').siblings('.day-box').children('.select-circle').toggleClass('not-select-circle');
		$(this).parents('.day-box').siblings('.day-box').children('.select-circle').toggleClass('select-circle');
		
		 printManagerMatch()
	});
	$('.prev-week').click(function() {
		location.href = "<c:url value='/manager/manage/schedule?weekCount='/>" + ${weekCount - 1};
	});
	$('.next-week').click(function() {
		location.href = "<c:url value='/manager/manage/schedule?weekCount='/>" + ${weekCount + 1};
	});
	$(document).on('click', '.btn-delete', function() {
		mt_num = $(this).val();
		
		deleteManagerMatch(mt_num);
		printManagerMatch();
	})
	function printManagerMatch() {
		let str = '';
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/manager/manage/schedule?weekCount="/>' + ${weekCount},
			data : {mt_date:select_day},
			dataType : 'json',
			success : function(data) {
				for(match of data.matchList){
					str +=`
					<div class="match-box">
						<div class="match-time-box">
							<span class="match-time">\${match.ti_time_str}</span>
						</div>
						<div class="match-info-box">
							<span>\${match.rg_main} \${match.rg_sub}</span> <br>
							<span>\${match.fa_name} \${match.st_name} \${match.st_max} vs \${match.st_max}</span>
						</div>
					`;
					if(${weekCount == 2}){
						str += `
							<button class="btn btn-outline-danger btn-delete btn-manager-match" value="\${match.mt_num}">취소</button> <br>
						`;
					}else if(${weekCount >= 0}){
						str += `
							<button class="btn btn-outline-warning btn-wait btn-manager-match" value="\${match.mt_num}">매칭 대기중<br>0/\${match.mt_personnel * 3}</button> <br>
						`;
					}else if(${weekCount < 0}){
						str += `
							<button class="btn btn-outline-success btn-search btn-manager-match" value="\${match.mt_num}">경기 종료</button> <br>
						`;
					}
					str += `
					</div>
					`;
				}
				$('.print-match-box').html(str)
			}
		});
	}
	function deleteManagerMatch(mt_num) {
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/manager/delete/schedule?weekCount="/>' + ${weekCount},
			data : {mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				if(data.res){
					alert('취소 성공');
				}else{
					alert('취소 실패');
				}
			}
		});
	}
	</script>
</body>
</html>
