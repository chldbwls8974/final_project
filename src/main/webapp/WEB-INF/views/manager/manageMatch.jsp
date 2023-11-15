<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>매치 관리</title>
	<style type="text/css">
	nav{width: 100%; display: flex;}
	input{text-align: right;}
	.left-box{flex: 2;}
	.right-box{flex: 1; height: 500px; padding-left: 10px}
	.contents-box{padding-top: 10px}
	.info-box{
	width: 100%; background-color: white; height: 300px; margin-bottom: 10px;
	border: 3px solid black; box-sizing: border-box;
	}
	.right-side-box{
	width: 100%; height: 200px; float: right; margin-bottom: 10px;
	border: 3px solid black; box-sizing: border-box;
	}
	.team-box{display: flex; background-color: black;}
	.teamList-box{flex: 1; margin-right: 3px; background-color: white;}
	.teamList-box:last-child {margin-right: 0;}
	.club-list-box{display: flex;}
	.club-member-box{flex: 1; border-right: 3px solid black; overflow: scroll;}
	.club-entry-box{flex: 1; overflow: scroll;}
	.entry-member::after{clear: both; content: ''; display: block;}
	.entry-btn{float: left;}
	.member-list{border-bottom: 1px solid black;}
	.member-list:last-child{border-bottom: none;}
	.entry-list-box{height: auto;}
	.entry-btn-box{float: right;}
	.quarter-box{width: 500px; height: 200px; margin-left: 15px;}
	</style>
</head>
<body>
	<h1>매치 관리</h1>
	<nav class="container">
		<div class="contents-box left-box">
			<div class="info-box match-box">
			${match}
			</div>
			<c:if test="${match.team_count != 0}">
				<div class="info-box team-box">
				</div>
			</c:if>
		</div>
		<div class="contents-box right-box">
			<div class="entry-list-box right-side-box">
				<h4>참가자 리스트</h4>
				<c:if test="${match.team_count != 0 && match.list_team == 0}">
					<button class="btn-reset">초기화</button>
					<button class="btn-auto-balance">자동 밸런스</button>
					<button class="btn-team-complete">팀 확정</button>
				</c:if>
				<c:forEach items="${entryList}" var="el">
					<div class="entry-member member-list">${el.me_nickname}(${el.me_tr_name})
						<c:if test="${el.te_type != 0}">
							${el.te_type}팀
						</c:if>
						<input hidden disabled value="${el.en_num}">
						<c:if test="${match.ready == 1 && el.te_type == 0}">
							<div class="entry-btn-box">
								<c:forEach items="${teamList}" var="tl">
									<c:if test="${tl.club_entry_count < match.mt_personnel}">
										<button class="entry-btn" value="${tl.te_num}">${tl.te_type}팀</button>
									</c:if>
									<c:if test="${tl.club_entry_count == match.mt_personnel}">
										<button class="entry-btn" value="${tl.te_num}" disabled>${tl.te_type}팀</button>
									</c:if>
								</c:forEach>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
	</nav>
	<c:if test="${match.ready ==  2}">
		<div class="insert-quarter-box">
		</div>
	</c:if>
	<div class="quarter-list-box">
		
	</div>
	<script type="text/javascript">
	let mt_num = ${match.mt_num};
	let str = ``;
	
	printTeam()
	printInsertQuarter()
	printQuarter()
	
	$(document).on('click', '.entry-btn', function() {
		te_num = $(this).val();
		en_num = $(this).parents('.entry-btn-box').siblings('input').val();
		
		entryToTeam(en_num, te_num)
	})
	$(document).on('click', '.btn-reset', function() {
		entryReset()
	})
	$(document).on('click', '.btn-auto-balance', function() {
		autoBalance()
	})
	$(document).on('click', '.btn-team-complete', function() {
		if(confirm("팀 확정시 변경할 수 없습니다.\n변경하시겠습니까?")){
			teamComplete()
		}else{
			alert("취소되었습니다.");
		}
	})
	$(document).on('change', '.quarter-type', function() {
		type = $(this).val();
		
		selectType(type);
	})
	$(document).on('click', '.btn-insert-quarter', function() {
		qu_te_num1 = $(this).siblings('.qu_te_num1').val();
		qu_te_num2 = $(this).siblings('.qu_te_num2').val();
		qu_goal1 = $(this).siblings('.qu_goal1').val();
		qu_goal2 = $(this).siblings('.qu_goal2').val();
		
		data = {
				qu_mt_num : mt_num,
				qu_te_num1 : qu_te_num1,
				qu_te_num2 : qu_te_num2,
				qu_goal1 : qu_goal1,
				qu_goal2 : qu_goal2
		}
		
		insertQuarter(data);
		printInsertQuarter();
	})
	
	$(document).on('click', '.btn-update-quarter', function() {
		qu_num = $(this).val();
		team1 = $(this).siblings('.recored-team1').val();
		team2 = $(this).siblings('.recored-team2').val();
		te_num1 = $(this).siblings('.recored-te_num1').val();
		te_num2 = $(this).siblings('.recored-te_num2').val();
		goal1 = $(this).siblings('.recored-goal1').val();
		goal2 = $(this).siblings('.recored-goal2').val();
		
		printUpdateQuarter(qu_num, team1, team2, te_num1, te_num2, goal1, goal2);
		$(this).parents('.quarter-box').html(str);
	})
	$(document).on('click', '.btn-update-complete', function() {
		qu_num = $(this).val();
		qu_te_num1 = $(this).siblings('.qu_te_num1').val();
		qu_te_num2 = $(this).siblings('.qu_te_num2').val();
		qu_goal1 = $(this).siblings('.qu_goal1').val();
		qu_goal2 = $(this).siblings('.qu_goal2').val();
		
		data = {
				qu_num : qu_num,
				qu_mt_num : mt_num,
				qu_te_num1 : qu_te_num1,
				qu_te_num2 : qu_te_num2,
				qu_goal1 : qu_goal1,
				qu_goal2 : qu_goal2
		}
		updateQuarter(data);
		printQuarter();
	})
	$(document).on('click', '.btn-update-cansel', function() {
		printQuarter();
	})
	$(document).on('click', '.btn-delete-quarter', function() {
		qu_num = $(this).val();
		
		deleterQuarter(qu_num);
		printQuarter();
		printInsertQuarter();
	})
	function entryToTeam(en_num, te_num) {
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/update/entry/team"/>',
			data : {en_num:en_num, te_num:te_num},
			dataType : 'json',
			success : function(data) {
				if(data.res){
					alert("등록 성공");
					location.href='<c:url value="/manager/manage/match?mt_num="/>'+ mt_num;
				}else{
					alert("등록 실패");
				}
			}
		});
	}
	function entryReset() {
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/reset/entry/team"/>',
			data : {mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				if(data.res){
					location.href='<c:url value="/manager/manage/match?mt_num="/>'+ mt_num;
				}
			}
		});
	}
	function autoBalance() {
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/auto/Balance"/>',
			data : {mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				if(data.res){
					location.href='<c:url value="/manager/manage/match?mt_num="/>'+ mt_num;
				}
			}
		});
	}
	function teamComplete() {
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/complete/team"/>',
			data : {mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				if(data.res){
					location.href='<c:url value="/manager/manage/match?mt_num="/>'+ mt_num;
				}
			}
		});
	}
	function insertQuarter(data) {
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/insert/quarter"/>',
			data : JSON.stringify(data),
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				if(data.res){
					alert("등록 성공");
				}
			}
		});
		printQuarter();
	}
	function printTeam() {
		str = `
			<c:forEach items="${teamList}" var="tl">
				<div class="teamList-box">
					<table>
						<thead>
							<tr>
								<th>
									${tl.te_type}팀:${tl.cl_name} ${tl.club_entry_count}/${match.mt_personnel}
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${entryList}" var="el">
								<c:if test="${tl.te_num == el.en_te_num}">
									<tr>
										<td>
											<span>
												${el.me_nickname}(${el.me_tr_name})
											</span>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:forEach>
		`;
		$('.team-box').html(str);
	}
	function printInsertQuarter() {
		str = ``;
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/count/quarter"/>',
			data : {mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				if(data.count < 9){
					str += `
						<div class="info-box quarter-box">
							<h4>경기 등록</h4>
							<select class="quarter-type">
								<option value="1">1팀 vs 2팀</option>
								<option value="2">1팀 vs 3팀</option>
								<option value="3">2팀 vs 3팀</option>
							</select>
							<br>
							<span class="team1">1</span>팀
							<input type="text" class="input-team qu_te_num1" value="${teamList[0].te_num}" hidden disabled>
							<input type="number" class="input-goal qu_goal1" value="0" min="0">
							<span>골</span>
							<br>
							<span class="team2">2</span>팀
							<input type="text" class="input-team qu_te_num2" value="${teamList[1].te_num}" hidden disabled>
							<input type="number" class="input-goal qu_goal2" value="0" min="0">
							<span>골</span>
							<br>
							<button class="btn-insert-quarter">등록</button>
						</div>
					`;
				}
			}
		});
		$('.insert-quarter-box').html(str);
	}
	function printQuarter() {
		str = ``;
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/select/quarter"/>',
			data : {mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				quarterList = data.quarterList
				if(${match.ready ==  2 || match.ready == 3}){
					let i = 0
					for(quarterList of data.quarterList){
						str += `
							<div class="info-box quarter-box">
								<h4>\${i + 1}경기</h4>
								<button class="btn-update-quarter" value="\${quarterList.qu_num}">수정</button>
								<button class="btn-delete-quarter" value="\${quarterList.qu_num}">삭제</button>
								<input type="number" class="recored-team1" value="\${quarterList.team1}" hidden disabled>
								<input type="number" class="recored-team2" value="\${quarterList.team2}" hidden disabled>
								<input type="number" class="recored-te_num1" value="\${quarterList.qu_te_num1}" hidden disabled>
								<input type="number" class="recored-te_num2" value="\${quarterList.qu_te_num2}" hidden disabled>
								<input type="number" class="recored-goal1" value="\${quarterList.qu_goal1}" hidden disabled>
								<input type="number" class="recored-goal2" value="\${quarterList.qu_goal2}" hidden disabled>
								<br>
								\${quarterList.team1}팀 : \${quarterList.qu_goal1}
						`;
						if(quarterList.qu_goal1 > quarterList.qu_goal2){
							str += `
									<span>승리</span>
									<br>
									\${quarterList.team2}팀 : \${quarterList.qu_goal2}
									<span>패배</span>
								</div>
							`;
						}else if(quarterList.qu_goal1 == quarterList.qu_goal2){
							str += `
									<span>무승부</span>
									<br>
									\${quarterList.team2}팀 : \${quarterList.qu_goal2}
									<span>무승부</span>
								</div>
							`;
						}else if(quarterList.qu_goal1 < quarterList.qu_goal2){
							str += `
									<span>패배</span>
									<br>
									\${quarterList.team2}팀 : \${quarterList.qu_goal2}
									<span>승리</span>
								</div>
							`;
						}
						i++;
					}
				}
			}
		});
		$('.quarter-list-box').html(str);
	}
	function selectType(type) {
		if(type == 1){
			$('.team1').text(1);
			$('.team2').text(2);
			$('.qu_te_num1').val(${teamList[0].te_num})
			$('.qu_te_num2').val(${teamList[1].te_num})
		}else if(type == 2){
			$('.team1').text(2);
			$('.team2').text(3);
			$('.qu_te_num1').val(${teamList[0].te_num})
			$('.qu_te_num2').val(${teamList[2].te_num})
		}else if(type == 3){
			$('.team1').text(2);
			$('.team2').text(3);
			$('.qu_te_num1').val(${teamList[1].te_num})
			$('.qu_te_num2').val(${teamList[2].te_num})
		}
	}
	function printUpdateQuarter(qu_num, team1, team2, te_num1, te_num2, goal1, goal2) {
		str = ``;
		type = 0;
		if(team1 == 1){
			if(team2 == 2){
				type = 1;
			}else{
				type = 2;
			}
		}else{
			type = 3;
		}
		str += `
			<h4>경기 수정</h4>
			<input type="number" class="recored-qu_num" value="\${qu_num}" hidden disabled>
			<input type="number" class="recored-team1" value="\${team1}" hidden disabled>
			<input type="number" class="recored-team2" value="\${team1}" hidden disabled>
			<input type="number" class="recored-te_num1" value="\${te_num1}" hidden disabled>
			<input type="number" class="recored-te_num2" value="\${te_num2}" hidden disabled>
			<input type="number" class="recored-goal1" value="\${goal1}" hidden disabled>
			<input type="number" class="recored-goal2" value="\${goal2}" hidden disabled>
			<select class="quarter-type">
		`;
		if(type == 1){
			str += `
					<option value="1" selected>1팀 vs 2팀</option>
					<option value="2">1팀 vs 3팀</option>
					<option value="3">2팀 vs 3팀</option>
			`;
		}else if(type == 2){
			str += `
					<option value="1">1팀 vs 2팀</option>
					<option value="2" selected>1팀 vs 3팀</option>
					<option value="3">2팀 vs 3팀</option>
			`;
		}else if(type == 3){
			str += `
					<option value="1">1팀 vs 2팀</option>
					<option value="2">1팀 vs 3팀</option>
					<option value="3" selected>2팀 vs 3팀</option>
			`;
		}
		str += `
				</select>
			<br>
			<span class="team1">\${team1}</span>팀
			<input type="text" class="input-team qu_te_num1" value="\${te_num1}" hidden disabled>
			<input type="number" class="input-goal qu_goal1" value="\${goal1}" min="0">
			<span>골</span>
			<br>
			<span class="team2">\${team2}</span>팀
			<input type="text" class="input-team qu_te_num2" value="\${te_num2}" hidden disabled>
			<input type="number" class="input-goal qu_goal2" value="\${goal2}" min="0">
			<span>골</span>
			<br>
			<button class="btn-update-complete" value="\${qu_num}">수정 완료</button>
			<button class="btn-update-cansel">수정 취소</button>
		`;
	}
	function updateQuarter(){
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/update/quarter"/>',
			data : JSON.stringify(data),
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				if(data.res){
					alert("수정 성공");
				}else{
					alert("수정 실패");
				}
			}
		});
	}
	function deleterQuarter(qu_num) {
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/delete/quarter"/>',
			data : {qu_num:qu_num},
			dataType : 'json',
			success : function(data) {
				if(data.res){
					alert("삭제 성공");
				}else{
					alert("삭제 실패");
				}
			}
		});
	}
	function test() {
		str += `
		<div class="info-box quarter-box">
			<h4>경기 등록</h4>
			<select class="quarter-type">
				<option value="1">1팀 vs 2팀</option>
				<option value="2">1팀 vs 3팀</option>
				<option value="3">2팀 vs 3팀</option>
			</select>
			<br>
			<span class="team1">1</span>팀
			<input type="text" class="input-team qu_te_num1" value="${teamList[0].te_num}" hidden disabled>
			<input type="number" class="input-goal qu_goal1" value="0" min="0">
			<span>골</span>
			<br>
			<span class="team2">2</span>팀
			<input type="text" class="input-team qu_te_num2" value="${teamList[1].te_num}" hidden disabled>
			<input type="number" class="input-goal qu_goal2" value="0" min="0">
			<span>골</span>
			<br>
			<button class="btn-insert-quarter">등록</button>
		</div>
		`;
	}
	</script>
</body>
</html>
