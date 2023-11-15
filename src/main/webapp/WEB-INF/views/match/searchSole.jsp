<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>개인 매치 조회</title>
	<style type="text/css">
		.days-box{width: 100%; height: 50px; display: flex;}
		.day-box{
		height: 70px; background-color: window; flex: 1; border-right: 1px solid #c2c2c2;
		text-align: center;}
		.day-box:last-child{border-right: none}
		.day-span{font-size: 30px;}
		.day_of_week-span{font-size: 15px;}
		.sat{color: #16537e;}
		.sun{color: #da8686}
		.select-circle{height: 70px; background-color: #f2f2f2;}
		.not-select-circle:hover{height: 70px; background-color: #dbfabf; cursor: pointer;}
		.main-region-box{display: inline;}
		.sub-region-box{display: inline;}
		.match-box{height: 100px; border-bottom: 1px solid #c2c2c2;}
		.match-box::after{clear: both; content: ''; display: block;}
		.match-box:last-child{border-bottom: none}
		.match-time-box{font-size: 40px; display: inline-block; line-height: 100px}
		.match-info-box{display: inline-block;}
		.btn{float: right; margin-top: 30px;}
	</style>
</head>
<body>
	<p style="font-size: 35px; font-weight: bolder; margin:50px auto; border-bottom: 8px solid #c2f296;
	width: 20%; padding: 30px 0 10px 0; text-align: center;">개인 매치 조회</p>
	<div class="days-box">
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
	</div>
	<br>
	<div class="preferred-time-box">
		<span>선호시간 : </span>
		<input class="preferred-time-check" type="checkbox" checked="checked">
	</div>
	<div class="main-region-box">
		<span>지역 : </span>
		<select class="select-main">
			<option value="0">선호지역</option>
			<c:forEach items="${mainRegion}" var="mr">
				<option value="${mr.rg_num}">${mr.rg_main}</option>
			</c:forEach>
		</select>
	</div>
	<div class="sub-region-box">
		
	</div>
	<div class="select-match-box">
		
	</div>
	<script type="text/javascript">
	let type = 0;
	let select_day = "${week[0].date_str}";
	let cl_num = 0;
	let rg_num = 0;
	let check = true;
	
	
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
		rg_num = $(this).val();
		printSubSelect(rg_num);
		printSelectMatch();
	});
	$(document).on('change', '.select-sub', function() {
		rg_num = $(this).val();
		printSelectMatch();
	});
	$(document).on('change', '.preferred-time-check', function() {
		check = !check;
		printSelectMatch()
	});
	$(document).on('click', '.btn-matchPage', function() {
		let mt_num = $(this).val();
		
		location.href='<c:url value="/match/application?mt_num="/>'+ mt_num + '&cl_num=' + cl_num;
	});
	function printSelectMatch() {
		let str = '';
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/match/searchList/solo"/>',
			data : {mt_date:select_day, rg_num:rg_num, check:check},
			dataType : 'json',
			success : function(data) {
				for(match of data.matchList){
					if((match.application_able == 0 && match.application == 1) || match.ready == 0){
						str +=`
						<div class="match-box">
							<div class="match-time-box">
								<span class="match-time">\${match.ti_time_str}</span>
							</div>
							<div class="match-info-box">
								<span>\${match.rg_main} \${match.rg_sub} \${match.fa_name} \${match.st_name} </span> <br>
								<span>개인 `;
						if(match.mt_rule == 0){
							str +=	`친선전 \${match.mt_personnel} vs \${match.mt_personnel} \${match.entry_count}/\${match.mt_personnel * 2}</span>
								</div>
							`;
						}else if(match.mt_rule == 1){
							str +=	`경쟁전 \${match.mt_personnel} vs \${match.mt_personnel} \${match.entry_count}/\${match.mt_personnel * 3}</span>
								</div>
							`;						
						}
						if(match.application_able == 0 && match.application == 1){
							str +=	`
								<button class="btn btn-outline-danger btn-matchPage" value="\${match.mt_num}">참가 취소</button> <br>
							</div>
							`;					
						}else if(match.entry_count == (match.mt_rule == 0 ? match.mt_personnel * 2 : match.mt_personnel * 3)){
							str +=	`
								<button class="btn btn-dark" value="\${match.mt_num}" disabled>참가 마감</button> <br>
							</div>
							`;					
						}else if(match.application_able == 1){
							str +=	`
								<button class="btn btn-outline-primary btn-matchPage" value="\${match.mt_num}">참가 신청</button> <br>
							</div>
							`;
						}else if(match.application_able == 0 && match.application == 0){
							str +=	`
								<button class="btn btn-outline-secondary" value="\${match.mt_num}" disabled>참가 불가</button> <br>
							</div>
							`;					
						}
					}
				}
				$('.select-match-box').html(str)
			}
		});
	}
	
	function printSubSelect(rg_num) {
		let str = ``;
		if(rg_num != 0){
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/manager/select/region"/>',
				data : {rg_num : rg_num},
				dataType : 'json',
				success : function(data) {
					str += `
						<select class="select-sub">
					`
					for(sr of data.subRegion){
						str += `
								<option value="\${sr.rg_num}">\${sr.rg_sub}</option>
						`
					}
					str += `
						</select>
					`;
				}
			});
		}
		$('.sub-region-box').html(str);
	}
	</script>
</body>
</html>
