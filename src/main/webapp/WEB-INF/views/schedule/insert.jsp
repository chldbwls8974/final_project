<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
	<style type="text/css">
		.schedule-box{width: 100%; height: 770px; background-color: lightblue; position : relative; border-radius: 5px}
		.schedule-box::after{clear: both; content: ''; display: block;}
		.time-bar{width: calc(10% - 10px); height: 750px; position: absolute; top: 25px;}
		.hour-bar{width: 100%; height: 30px; text-align: center; line-height: 30px; font: 20px bold;}
		.day-bar{width: 100%; height: 30px; background-color: gray; text-align: center; line-height: 30px; font: 20px bold; border-bottom: 1px solid black;}
		.week-box{
		width: 90%; height: 750px; background-color: yellow; display: flex;
		border: 1px solid black; border-left: none;
		float: right; position : absolute; right: 10px; bottom: 10px;
		border-radius: 5px; overflow: hidden;}
		.day-box{width: 100%; height: 100%; flex: 1; border-left: 1px solid black;}
		.hour-box{width: 100%; height: 30px;  border-bottom: 1px solid black; float:left;}
		.hour-box-abled{background-color: white; cursor: pointer;}
		.hour-box-abled:hover{background-color: yellow;}
		.hour-box-disabled{background-color: black;}
		.hour-box-select1{background-color: aqua; border-bottom: none;}
		.hour-box-select2{background-color: aqua;}
		.btn-box{float: right}
		.select-box{float: left}
		
	</style>
</head>
<body>
	<h1>스케줄 등록</h1>
	<div>
		<span>경기장 선택 : </span>
		<select class="select-stadium">
				<option value="0">선택</option>
			<c:forEach items="${stadiumList}" var="st">
				<option value="${st.st_num}">${st.st_name}</option>
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
			<c:forEach begin="0" end="6" var="i">
				<div class="day-box">
					<div class="day-bar">${timeList[i * 24].ti_day}</div>
					<c:forEach begin="0" end="23" var="j">
						<c:if test="${operatingList[i - 1 < 0 ? 6 : i - 1].op_open_time < operatingList[i - 1 < 0 ? 6 : i - 1].op_close_time}">
							<c:if test="${operatingList[i].op_open_time > timeList[j].ti_time}">
									<div class="hour-box hour-box-disabled"></div>
							</c:if>
							<c:if test="${operatingList[i].op_open_time < operatingList[i].op_close_time}">
								<c:if test="${operatingList[i].op_open_time <= timeList[j].ti_time && timeList[j].ti_time < operatingList[i].op_close_time}">
									<div class="hour-box hour-box-abled">
										<div class="select-box"></div>
										<div class="btn-box"></div>
										<span hidden="">${timeList[i * 24 + j].ti_num}</span>
									</div>
								</c:if>
								<c:if test="${timeList[j].ti_time >= operatingList[i].op_close_time}">
									<div class="hour-box hour-box-disabled"></div>
								</c:if>
							</c:if>
							<c:if test="${operatingList[i].op_open_time > operatingList[i].op_close_time}">
								<c:if test="${operatingList[i].op_open_time <= timeList[j].ti_time}">
									<div class="hour-box hour-box-abled">
										<div class="select-box"></div>
										<div class="btn-box"></div>
										<span hidden="">${timeList[i * 24 + j].ti_num}</span>
									</div>
								</c:if>
							</c:if>
						</c:if>
						<c:if test="${operatingList[i - 1 < 0 ? 6 : i - 1].op_open_time > operatingList[i - 1 < 0 ? 6 : i - 1].op_close_time}">
							<c:if test="${operatingList[i - 1 < 0 ? 6 : i - 1].op_close_time > timeList[j].ti_time}">
								<div class="hour-box hour-box-abled">
									<div class="select-box"></div>
										<div class="btn-box"></div>
									<span hidden="">${timeList[i * 24 + j].ti_num}</span>
								</div>
							</c:if>
							<c:if test="${operatingList[i - 1 < 0 ? 6 : i - 1].op_close_time <= timeList[j].ti_time && timeList[j].ti_time < operatingList[i].op_open_time}">
								<div class="hour-box hour-box-disabled"></div>
							</c:if>
							<c:if test="${operatingList[i].op_open_time < operatingList[i].op_close_time}">
								<c:if test="${operatingList[i].op_open_time <= timeList[j].ti_time && timeList[j].ti_time < operatingList[i].op_close_time}">
									<div class="hour-box hour-box-abled">
										<div class="select-box"></div>
										<div class="btn-box"></div>
										<span hidden="">${timeList[i * 24 + j].ti_num}</span>
									</div>
								</c:if>
								<c:if test="${timeList[j].ti_time >= operatingList[i].op_close_time}">
									<div class="hour-box hour-box-disabled"></div>
								</c:if>
							</c:if>
							<c:if test="${operatingList[i].op_open_time > operatingList[i].op_close_time}">
								<c:if test="${operatingList[i].op_open_time <= timeList[j].ti_time}">
									<div class="hour-box hour-box-abled">
										<div class="select-box"></div>
										<div class="btn-box"></div>
										<span hidden="">${timeList[i * 24 + j].ti_num}</span>
									</div>
								</c:if>
							</c:if>
						</c:if>
					</c:forEach>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<script type="text/javascript">
		let st_num;
		let max;
		let select = ``;
		$('.select-stadium').change(function() {
			st_num = $(this).val();
			reset();
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/select/stadium"/>',
				data : {st_num:st_num},
				dataType : 'json',
				success : function(data) {
					max = data.stadium.st_max;
					select = `
						<select class="select-personnel">`
					for(i = max; i >= 3; i--){
						select += `		
							<option value="\${i}">\${i}vs\${i}</option>
						`
					}
					select += `
						</select>
					`;
					for(schedule of data.scheduleList){
						printSchedule(schedule.sc_ti_num, schedule.sc_personnel);
					}
				}
			});
		});
		$(document).on('click', '.hour-box-abled', function() {
			if(st_num == null){
				alert("경기장을 선택해주세요.");
				return;
			}
			let num = $(this).children('span').text();
			
			let data = {
					sc_st_num : st_num,
					sc_ti_num : num,
					sc_personnel : max
			}
			if(insertSchedule(data)){
				printSchedule(num);
			}
		})
		$(document).on('click', '.btn-del', function() {
			let num = $(this).parents('div').siblings('span').text();
			let data = {
					sc_st_num : st_num,
					sc_ti_num : num
			}
			if(deleteSchedule(data)){
				eraseSchedule(num);
			}
		})
		function insertSchedule(data) {
			let res = false;
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/insert/schedule"/>',
				data : JSON.stringify(data),
				contentType : "application/json; charset=UTF-8",
				dataType : 'json',
				success : function(data) {
					if(data.res){
						alert('성공');
					}else{
						alert('실패');
					}
					res = data.res;
				}
			});
			return res;
		}
		function deleteSchedule(data) {
			let res = false;
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/delete/schedule"/>',
				data : JSON.stringify(data),
				contentType : "application/json; charset=UTF-8",
				dataType : 'json',
				success : function(data) {
					if(data.res){
						alert('성공');
					}else{
						alert('실패');
					}
					res = data.res;
				}
			});
			return res;
		}
		function reset() {
			for(i = 1; i <= 168; i++){
				eraseSchedule(i);
			}
		}
		function printSchedule(num) {
			let day = (num % 24 == 0 ? parseInt(num / 24) -1 : parseInt(num / 24));
			let time = (num % 24 == 0 ? 23 : num % 24 - 1);
			if(time != 23 && $('.day-box').eq(day).children('.hour-box').eq(time+1).attr('class') == 'hour-box hour-box-abled'){
				$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-abled');
				$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-select1');
				$('.day-box').eq(day).children('.hour-box').eq(time).children('.btn-box').html(`<button class="btn-del">삭제</button>`);
				$('.day-box').eq(day).children('.hour-box').eq(time).children('.select-box').html(select);
				$('.day-box').eq(day).children('.hour-box').eq(time + 1).toggleClass('hour-box-abled');
				$('.day-box').eq(day).children('.hour-box').eq(time + 1).toggleClass('hour-box-select2');
				return true;
			}
			if(time == 23){
				if(day == 6 && $('.day-box').eq(0).children('.hour-box').eq(0).attr('class') == 'hour-box hour-box-abled'){
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-abled');
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-select1');
					$('.day-box').eq(day).children('.hour-box').eq(time).children('.btn-box').html(`<button class="btn-del">삭제</button>`);
					$('.day-box').eq(day).children('.hour-box').eq(time).children('.select-box').html(select);
					$('.day-box').eq(0).children('.hour-box').eq(0).toggleClass('hour-box-abled')
					$('.day-box').eq(0).children('.hour-box').eq(0).toggleClass('hour-box-select2')
					return true;
				}
				if($('.day-box').eq(day+1).children('.hour-box').eq(0).attr('class') == 'hour-box hour-box-abled'){
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-abled');
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-select1');
					$('.day-box').eq(day).children('.hour-box').eq(time).children('.btn-box').html(`<button class="btn-del">삭제</button>`);
					$('.day-box').eq(day).children('.hour-box').eq(time).children('.select-box').html(select);
					$('.day-box').eq(day + 1).children('.hour-box').eq(0).toggleClass('hour-box-abled')
					$('.day-box').eq(day + 1).children('.hour-box').eq(0).toggleClass('hour-box-select2')
					return true;
				}
			}
			return false;
		}
		function eraseSchedule(num) {
			let day = (num % 24 == 0 ? parseInt(num / 24) -1 : parseInt(num / 24));
			let time = (num % 24 == 0 ? 23 : num % 24 - 1);
			if(time != 23 && $('.day-box').eq(day).children('.hour-box').eq(time).attr('class') == 'hour-box hour-box-select1'){
				$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-abled');
				$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-select1');
				$('.day-box').eq(day).children('.hour-box').eq(time).children('.btn-box').html(``);
				$('.day-box').eq(day).children('.hour-box').eq(time).children('.select-box').html(``);
				$('.day-box').eq(day).children('.hour-box').eq(time + 1).toggleClass('hour-box-abled');
				$('.day-box').eq(day).children('.hour-box').eq(time + 1).toggleClass('hour-box-select2');
				return true;
			}
			if(time == 23){
				if(day == 6 && $('.day-box').eq(day).children('.hour-box').eq(time).attr('class') == 'hour-box hour-box-select1'){
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-abled');
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-select1');
					$('.day-box').eq(day).children('.hour-box').children('.btn-box').html(``);
					$('.day-box').eq(day).children('.hour-box').children('.select-box').html(``);
					$('.day-box').eq(0).children('.hour-box').eq(0).toggleClass('hour-box-abled')
					$('.day-box').eq(0).children('.hour-box').eq(0).toggleClass('hour-box-select2')
					return true;
				}
				if($('.day-box').eq(day).children('.hour-box').eq(time).attr('class') == 'hour-box hour-box-select1'){
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-abled');
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-select1');
					$('.day-box').eq(day).children('.hour-box').eq(time).children('.btn-box').html(``);
					$('.day-box').eq(day).children('.hour-box').eq(time).children('.select-box').html(``);
					$('.day-box').eq(day + 1).children('.hour-box').eq(0).toggleClass('hour-box-abled')
					$('.day-box').eq(day + 1).children('.hour-box').eq(0).toggleClass('hour-box-select2')
					return true;
				}
			}
			return false;
		}
	</script>
</body>
</html>
