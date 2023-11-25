<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>스케줄 관리</title>
	<style type="text/css">
		.schedule-box{
			background-color: #f2f2f2; position : relative; border-radius: 20px;
			margin-top: 20px; width: 100%; height: 800px;
		}
		.schedule-box::after{clear: both; content: ''; display: block;}
		.time-bar{width: calc(10% - 10px); height: 750px; position: absolute; top: 25px;}
		.hour-bar{width: 100%; height: 30px; text-align: center; line-height: 30px; font: 17px bold;}
		.day-bar{width: 100%; height: 30px; background-color: #c2f296; text-align: center; line-height: 30px; font: 20px bold;}
		.week-box{
/*  		background-color: yellow; bottom: 10px; */ /*진용쓰가 해둔거 일단 주석*/
		width: 90%; height: 750px;display: flex;
		border-left: none; float: right; position : absolute; right: 10px;
		border-radius: 5px; overflow: hidden;
		margin: 25px;
		}
		.day-box{width: 100%; height: 100%; flex: 1; border-left: 1px solid #b9b9b9;}
		.hour-box{width: 100%; height: 30px;  border-bottom: 1px solid #b9b9b9; float:left;}
		.hour-box-abled{background-color: white; cursor: pointer;}
		.hour-box-abled:hover{background-color: #defac5;}
		.hour-box-disabled{background-color: #999999;}
		.hour-box-select1{background-color: #f8f2e1; border-bottom: none; display: flex;}
		.hour-box-select2{background-color: #f8f2e1;}
		.select-box{flex: 1}
		.select-personnel{
			float: left; text-align: center;
  		  	margin-left: 35px;
    	}
		.btn-box{flex: 1}
		.btn-del{
			float: right; border: none; background-color: #ffffff; border-radius: 5px;
			margin-right: 20px;
		}
		
	</style>
</head>
<body>
	<div class="stadiumInsert-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 20%; font-weight: bolder; margin: 40px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		스케쥴 관리</p>
	</div>
	<div>
		<span style="margin-right: 10px; font-weight: bold;">시설 선택 </span>
		<select class="select-facility" style="margin-right: 30px;">
				<option value="0">선택</option>
			<c:forEach items="${facilityList}" var="fa">
				<c:if test="${fa.fa_num == fa_num}">
					<option selected="selected" value="${fa.fa_num}">${fa.fa_name}</option>
				</c:if>
				<c:if test="${fa.fa_num != fa_num}">
					<option value="${fa.fa_num}">${fa.fa_name}</option>
				</c:if>
			</c:forEach>
		</select>
		<span style="margin-right: 10px; font-weight: bold;">경기장 선택 </span>
		<select class="select-stadium">
				<option value="0">선택</option>
			<c:forEach items="${stadiumList}" var="st">
				<option value="${st.st_num}">${st.st_name}</option>
			</c:forEach>
		</select>
	</div>
	<div class="schedule-box">
		<c:if test="${fa_num == 0}">
			<span style="display: block;
						text-align: center;
					    padding-top: 50px;
					    font-size: 25px;
					    font-weight: 600;">
			경기장을 선택해주세요.</span>
		</c:if>
		<c:if test="${fa_num != 0}">
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
		</c:if>
	</div>
	
	<script type="text/javascript">
		let st_num;
		let max;
		let min = 3;
		let select = ``;
		$('.select-facility').change(function() {
			faNum = $(this).val();
			location.href= '<c:url value="/buisnessman/manage/schedule?fa_num="/>' + faNum;
		});
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
			if(printSchedule(num, max)){
				if(!insertSchedule(data)){
					eraseSchedule(num);
				}
			}else{
				alert('등록 불가능한 일정입니다.');
			}
		})
		$(document).on('click', '.btn-del', function() {
			let num = $(this).parents('.btn-box').siblings('span').text();
			let personnel = $(this).parents('.btn-box').siblings('.select-box').children('.select-personnel').val();
			let data = {
					sc_st_num : st_num,
					sc_ti_num : num
			}
			if(eraseSchedule(num)){
				if(!deleteSchedule(data)){
					printSchedule(num, personnel);
				}
			}
		})
		$(document).on('change', '.select-personnel', function() {
			let num = $(this).parents('.select-box').siblings('span').text();
			let personnel = $(this).val();
			let data = {
					sc_st_num : st_num,
					sc_ti_num : num,
					sc_personnel : personnel
			}
			updateSchedule(data);
		})
		function selectPersonnel(personnel) {
			select = `
				<select class="select-personnel" value="personnel">`
			for(i = max; i >= min; i--){
				if(i != personnel){
					select += `		
						<option value="\${i}">\${i}vs\${i}</option>
					`					
				}
				if(i == personnel){
					select += `		
						<option value="\${i}" selected>\${i}vs\${i}</option>
					`					
				}
			}
			select += `
				</select>
			`;
		};
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
					/*
					if(data.res){
						alert('등록 성공');
					}else{
						alert('등록 실패');
					}*/
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
					/*
					if(data.res){
						alert('삭제 성공');
					}else{
						alert('삭제 실패');
					}*/
					res = data.res;
				}
			});
			return res;
		}
		function updateSchedule(data) {
			let res = false;
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/update/schedule"/>',
				data : JSON.stringify(data),
				contentType : "application/json; charset=UTF-8",
				dataType : 'json',
				success : function(data) {
					/*
					if(data.res){
						alert('수정 성공');
					}else{
						alert('수정 실패');
					}*/
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
		function printSchedule(num, personnel) {

			selectPersonnel(personnel);

			let day = (num % 24 == 0 ? parseInt(num / 24) -1 : parseInt(num / 24));
			let time = (num % 24 == 0 ? 23 : num % 24 - 1);
			if(time != 23 && $('.day-box').eq(day).children('.hour-box').eq(time+1).attr('class') == 'hour-box hour-box-abled'){
				$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-abled');
				$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-select1');
				$('.day-box').eq(day).children('.hour-box').eq(time).children('.btn-box').html(`<button class="btn-del">X</button>`);
				$('.day-box').eq(day).children('.hour-box').eq(time).children('.select-box').html(select);
				$('.day-box').eq(day).children('.hour-box').eq(time + 1).toggleClass('hour-box-abled');
				$('.day-box').eq(day).children('.hour-box').eq(time + 1).toggleClass('hour-box-select2');
				return true;
			}
			if(time == 23){
				if(day == 6 && $('.day-box').eq(0).children('.hour-box').eq(0).attr('class') == 'hour-box hour-box-abled'){
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-abled');
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-select1');
					$('.day-box').eq(day).children('.hour-box').eq(time).children('.btn-box').html(`<button class="btn-del">X</button>`);
					$('.day-box').eq(day).children('.hour-box').eq(time).children('.select-box').html(select);
					$('.day-box').eq(0).children('.hour-box').eq(0).toggleClass('hour-box-abled')
					$('.day-box').eq(0).children('.hour-box').eq(0).toggleClass('hour-box-select2')
					return true;
				}
				if($('.day-box').eq(day+1).children('.hour-box').eq(0).attr('class') == 'hour-box hour-box-abled'){
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-abled');
					$('.day-box').eq(day).children('.hour-box').eq(time).toggleClass('hour-box-select1');
					$('.day-box').eq(day).children('.hour-box').eq(time).children('.btn-box').html(`<button class="btn-del">X</button>`);
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
