<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>클럽 매치 조회</title>
	<style type="text/css">
		.days-box{width: 100%; height: 50px; display: flex;}
		.day-box{
		height: 70px; background-color: window; flex: 1; border-right: 1px solid #c2c2c2;
		text-align: center;}
		.day-box:last-child{border-right: none}
		.btn-week{width: 20px;}
		.btn-week:hover{ font-weight: bolder; cursor: pointer;}
		.prev-week{height: 70px; border-right: 1px solid #c2c2c2; line-height: 70px;}
		.next-week{height: 70px; line-height: 70px;}
		.day-span{font-size: 30px;}
		.day_of_week-span{font-size: 15px;}
		.sat{color: #16537e;}
		.sun{color: #da8686}
		.select-circle{height: 70px; background-color: #f2f2f2;}
		.not-select-circle:hover{height: 70px;  background-color: #dbfabf; cursor: pointer;}
		.main-region-box{display: inline;}
		.sub-region-box{display: inline;}
		.match-box{height: 100px; border-bottom: 1px solid #c2c2c2;}
		.match-box::after{clear: both; content: ''; display: block;}
		.match-box:last-child{border-bottom: none}
		.match-time-box{font-size: 40px; display: inline-block; line-height: 100px; margin-right: 10px;}
		.match-info-box{display: inline-block;}
		.btn{float: right; margin-top: 30px;}
		.club-emblem{width: 20px; height: 20px; border-radius: 50%;}
	</style>
</head>
<body>
	<p style="font-size: 35px; font-weight: bolder; margin:50px auto;
	width: 25%; padding: 30px 0 10px 0; text-align: center;">클럽 매치 조회</p>
	<div class="days-box">
		<c:if test="${weekCount != 0}">
			<div class="prev-week btn-week"><</div>
		</c:if>
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
		<c:if test="${weekCount != 1}">
			<div class="next-week btn-week">></div>
		</c:if>
	</div>
	<br>
	<div class="club-select-box" style="margin: 10px 0 10px 0;">
		<span>클럽 </span>
		<select class="select-club" style="margin-left: 10px;">
			<option value="0">선택</option>
			<c:forEach items="${clubList}" var="cl">
				<option value="${cl.cl_num}">${cl.cl_name}</option>
			</c:forEach>
		</select>
	</div>
	<div class="select-match-box">
		
	</div>
	<script type="text/javascript">
	let type = 1;
	let select_day = "${week[0].date_str}";
	let cl_num = 0;
	
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
	$('.prev-week').click(function() {
		location.href = "<c:url value='/match/search/club?weekCount='/>" + ${weekCount - 1};
	});
	$('.next-week').click(function() {
		location.href = "<c:url value='/match/search/club?weekCount='/>" + ${weekCount + 1};
	});
	$(document).on('change', '.select-club', function() {
		cl_num = $(this).val();

		printSelectMatch();
	})
	$(document).on('click', '.btn-matchPage', function() {
		let mt_num = $(this).val();
		
		location.href='<c:url value="/match/application?mt_num="/>'+ mt_num + '&cl_num=' + cl_num;
	});
	$(document).on('click', '.btn-matchPage-x', function() {
		alert("신청이 마감된 경기입니다.")
	});
	function printSelectMatch() {
		let str = ``;
		if(cl_num == 0){
			str += `<p style="font-size: larger;
			   				font-weight: 600;
			   				text-align: center;
							margin-top: 50px;">
			   				현재 선택된 클럽이 없습니다. 클럽을 선택해주세요</p>`;
		}else{
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/match/searchList/club"/>',
				data : {mt_date:select_day, cl_num:cl_num},
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
									<span>클럽 `;
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
									<button class="btn btn-matchPage"
									style="width: 120px; height: 40px; border: none;
									border-radius: 5px; background-color: #f76c6c; color: black;"
									value="\${match.mt_num}">신청 완료</button> <br>
								</div>
								`;					
							}else if(match.team_count == (match.mt_rule == 0 ? 2 : 3)){
								str +=	`
									<button class="btn btn-matchPage-x"
									style="width: 120px; height: 40px; border: none;
									border-radius: 5px; background-color: black; color: white;"
									value="\${match.mt_num}">신청 마감</button> <br>
								</div>
								`;					
							}else if(match.application_able == 1){
								str +=	`
									<button class="btn btn-matchPage"
									style="width: 120px; height: 40px; border: none;
									border-radius: 5px; background-color: #c2f296; color: black;"
									value="\${match.mt_num}">신청 가능</button> <br>
								</div>
								`;
							}else if(match.application_able == 0 && match.application == 0){
								str +=	`
									<button class="btn btn-matchPage"
									style="width: 120px; height: 40px; border: none;
									border-radius: 5px; background-color: #cac5c5; color: black;"
									value="\${match.mt_num}">신청 불가</button> <br>
								</div>
								`;					
							}
						}
					}
				}
			});
		}
		$('.select-match-box').html(str)
	}
	</script>
</body>
</html>
