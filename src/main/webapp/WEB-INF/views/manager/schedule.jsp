<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>일정 관리</title>
	<style type="text/css">
		.days-box{width: 100%; height: 50px; display: flex;}
		.day-box{
		height: 70px; background-color: window; flex: 1; border-right: 1px solid #c2c2c2;
		text-align: center;}
		.day-box:last-child{border-right: none}
		.btn-week{width: 20px;}
		.btn-week:hover{ font-weight:bolder; cursor: pointer;}
		.prev-week{height: 70px; border-right: 1px solid #c2c2c2; line-height: 70px;}
		.next-week{height: 70px; line-height: 70px;}
		.day-span{font-size: 30px;}
		.day_of_week-span{font-size: 15px;}
		.sat{color: #16537e;}
		.sun{color: #da8686}
		.select-circle{height: 70px; background-color: #f2f2f2;}
		.not-select-circle:hover{height: 70px; background-color: #dbfabf; cursor: pointer;}
		.match-box{height: 100px; border-bottom: 1px solid #c2c2c2;}
		.match-box::after{clear: both; content: ''; display: block;}
		.match-box:last-child{border-bottom: none}
		.match-time-box{font-size: 40px; display: inline-block; line-height: 100px}
		.match-info-box{display: inline-block;}
		.d-btn{float: right; margin-top: 40px;}
	</style>
</head>
<body>
	<p style="font-size: 35px; font-weight: bolder; margin:50px auto; border-bottom: 8px solid #c2f296;
	width: 16%; padding: 30px 0 10px 0; text-align: center;">일정 관리</p>
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
	<div class="print-match-box" style="margin: 30px 0 30px 0;">
		
	</div>
	<script type="text/javascript">
	let select_day = "${week[0].date_str}";
	let mt_num = 0;
	
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
	$(document).on('click', '.btn-manager', function() {
		mt_num = $(this).val();
		location.href = "<c:url value='/manager/manage/match?mt_num='/>" + mt_num;
	})
	function printManagerMatch() {
		let str = '';
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/manager/manage/schedule"/>',
			data : {mt_date:select_day},
			dataType : 'json',
			success : function(data) {
				for(match of data.matchList){
					str +=`
						<div class="match-box">
							<div class="match-time-box" style="margin-right: 10px;">
								<span class="match-time">\${match.ti_time_str}</span>
							</div>
							<div class="match-info-box">
								<span>\${match.rg_main} \${match.rg_sub}</span> \${match.fa_name} \${match.st_name}
					`;
					if(match.mt_type == 1){
						str += `
							<span>개인 경쟁전 \${match.mt_personnel} vs \${match.mt_personnel}</span>
						`;
					}
					if(match.mt_type == 2){
						str += `
							<span>클럽 경쟁전 \${match.mt_personnel} vs \${match.mt_personnel}</span>
						`;
					}
					str += `
						</div>
					`;
					if(match.mt_state1 == 0 && ${weekCount == 2}){
						str += `
							<button class="d-btn btn-delete btn-manager-match" 
								style="width: 120px; height: 40px; border: none; margin-left: 20px;
								border-radius: 5px; background-color: #f2f2f2; color: black;"
								value="\${match.mt_num}">취소</button> <br>
						`;
					}else if(match.mt_state1 == 0 && match.ready == 2){
						str += `
							<button class="btn btn-manager btn-manager-match" 
							style="width: 120px; height: 40px; border: none; height: auto; margin-left: 20px;
							border-radius: 5px; background-color: #f2f2f2; color: black;"
							value="\${match.mt_num}">매치 관리<br>\${match.entry_count}/\${match.mt_personnel * 3}</button> <br>
						`;
					}else if(match.mt_state1 == 0 && match.ready == 1){
						str += `
							<button class="btn btn-manager btn-manager-match" 
							style="width: 120px; height: 40px; border: none; height: auto; margin-left: 20px;
							border-radius: 5px; background-color: #c2f296; color: black;"
							value="\${match.mt_num}">매칭 완료<br>\${match.entry_count}/\${match.mt_personnel * 3}</button> <br>
						`;
					}else if(match.mt_state1 == 0 && ${weekCount >= 0}){
						str += `
							<button class="btn btn-manager btn-manager-match"
							style="width: 120px; height: 40px; border: none; height: auto; margin-left: 20px;
							border-radius: 5px; background-color: #e5f4d8; color: black;"
							value="\${match.mt_num}">매치 대기중<br>\${match.entry_count}/\${match.mt_personnel * 3}</button> <br>
						`;
					}else if(match.mt_state1 == 2){
						str += `
							<button class="btn btn-manager btn-manager-match" 
							style="width: 120px; height: 40px; border: none; height: auto; margin-left: 20px;
							border-radius: 5px; background-color: #e5f4d8; color: black;"
							value="\${match.mt_num}">관리 완료</button> <br>
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
			url : '<c:url value="/manager/delete/schedule"/>',
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
