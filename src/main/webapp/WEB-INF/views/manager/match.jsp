<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>매치 조회</title>
	<style type="text/css">
		.days-box{width: 100%; height: 50px; display: flex;}
		.day-box{
		height: 70px; background-color: window; flex: 1; border-right: 3px solid black;
		text-align: center;}
		.day-box:nth-child(7){border-right: none}
		.day-span{font-size: 30px;}
		.day_of_week-span{font-size: 15px;}
		.sat{color: blue;}
		.sun{color: red}
		.select-circle{height: 70px; border-radius: 20%; background-color: cyan;}
		.not-select-circle:hover{height: 70px; border-radius: 20%; background-color: yellow; cursor: pointer;}
	</style>
</head>
<body>
	<h1>매치 조회</h1>
	<div class="days-box">
		<c:forEach items="${thirdWeek}" var="day">
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
	</div>
	<br>
	<div class="main-region-box">
		<span>지역 : </span>
		<select class="select-main">
			<option value="0">선택 없음</option>
			<c:forEach items="${mainRegion}" var="mr">
				<option value="${mr.rg_main}">${mr.rg_main}</option>
			</c:forEach>
		</select>
	</div>
	<div class="sub-region-box">
		
	</div>
	<div class="select-match-box">
		
	</div>
	<script type="text/javascript">
	let select_day = "${thirdWeek[0].date_str}"
	
	
	$('.day-box').eq(0).children('.not-select-circle').toggleClass('select-circle');
	$('.day-box').eq(0).children('.not-select-circle').toggleClass('not-select-circle');
	printSelectMatch();
	
	$(document).on('click', '.not-select-circle', function() {
		select_day = $(this).children('.select-date-str').val();
		$(this).toggleClass('not-select-circle');
		$(this).toggleClass('select-circle');
		$(this).parents('.day-box').siblings('.day-box').children('.select-circle').toggleClass('not-select-circle');
		$(this).parents('.day-box').siblings('.day-box').children('.select-circle').toggleClass('select-circle');
		
		printSelectMatch();
	});
	
	$(document).on('change', '.select-main', function() {
		mainSelect($(this).val());
	});
	
	function printSelectMatch() {
		let data = {
				mt_date : select_day
		}
		let str = '';
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/manager/select/date"/>',
			data : JSON.stringify(data),
			contentType : "application/json; charset=UTF-8",
			dataType : 'json',
			success : function(data) {
				for(match of data.matchList){
					for(time of data.PTList){
						if(match.mt_ti_num == time.pt_ti_num)
							for(region of data.PRList){
								if(match.fa_rg_num == region.pr_rg_num){
									str +=`
									<span>\${match.ti_time_str}</span>
									<span>\${match.mt_num}</span>
									<span>\${match.fa_name}</span>
									<span>\${match.fa_add}</span>
									<span>\${match.fa_add_detail}</span>
									<span>\${match.fa_phone}</span>
									<span>\${match.st_name}</span>
									<span>\${match.st_locate}</span>
									<span>\${match.st_max}vs\${match.st_max}</span>
									<span>\${match.fa_note}</span><br>
									`
							}
						}
					}
				}
				$('.select-match-box').html(str)
			}
		});
	}
	function mainSelect(val) {
		let str = ``;
		if(val != 0){
			str += `
				<select class="select-sub">
					<option>\${val}</option>
				</select>
			`;
		}
		$('.sub-region-box').html(str);
	}
	</script>
</body>
</html>
