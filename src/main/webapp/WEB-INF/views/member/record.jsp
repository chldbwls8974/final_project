<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기 전적</title>
<style type="text/css">

	.container-body{ 
		background-color: #f2f2f2;
	    border-radius: 20px;
	    padding: 20px;
	    height: auto;
	}
	.club-emblem{width: 20px; height: 20px; border-radius: 50%;}
	.member-profile{width: 20px; height: 20px; border-radius: 50%;}
	.team-box{display: flex;}
	.teamList-box{flex: 1}
	.quarter-box{width: 500px; height: 200px; margin-left: 15px;}
	.quarter-list-box{height: 400px; overflow: scroll;}
	.modal {
	display: none;
	position: fixed;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.3);
	justify-content: center;
	align-items: center;
	}
	.modal-content1 {
	background-color: white;
	padding: 20px;
	border-radius: 5px;
	width: 600px;
	margin: 50px auto;
	}
	.info-box{margin-bottom: 10px;
	border: 3px solid black; box-sizing: border-box;}
	.modal-content2 {
	background-color: white;
	padding: 20px;
	border-radius: 5px;
	max-width: 400px;
	margin: 200px auto;
	}
	tr, th{ text-align: center;}
	.table thead th{ border: none;}
	.btn{
		border-radius: 10px !important; width: 100px; height: 40px; border: none;
		background-color: #c2f296; color: black;
	}
	
	
	.report-select-sub{display: flex;}
</style>
</head>
<body>
		<div style="margin-top: 50px; text-align: center;">
			<p style="font-size: 35px; width: 30%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
			${win + draw + lose} 전 ${win} 승${draw} 무${lose} 패</p>
		</div>
	<div class="container-body">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>매치 일시</th>
					<th>매치 타입</th>
					<th>장소</th>
	        		<th>팀(클랜)</th>
					<th>매치 전적</th>
					<th>경기 결과</th>
				 </tr>
			</thead>
			<tbody>
				<c:forEach items="${matchList}" var="mt" >
					<tr>
						<td>${mt.mt_date_str}<br>${mt.ti_time_str}</td>
						<td>${mt.mt_type == 1 ? '개인' : '클럽'} ${mt.mt_rule == 0 ? '친선전' : '경쟁전'} (${mt.mt_personnel} vs ${mt.mt_personnel})</td>
						<td>${mt.fa_name} ${mt.st_name}</td>
						<td>
							<c:if test="${mt.te_type != 0}">
								${mt.te_type}팀
							</c:if>
							<c:if test="${mt.mt_type == 2}">
								(${mt.cl_name})
							</c:if>
							<c:if test="${mt.te_type == 0}">
								없음
							</c:if>
						</td>
						<td>
							<c:if test="${mt.mt_rule == 1}">
								${mt.win + mt.draw + mt.lose}전 ${mt.win}승 ${mt.draw}무 ${mt.lose}패
							</c:if>
						</td>
						<td>
							<input type="text" class="mt_num" value="${mt.mt_num}" hidden disabled>
							<input type="text" class="te_num" value="${mt.te_num}" hidden disabled>
							<input type="text" class="te_type" value="${mt.te_type}" hidden disabled>
							<input type="text" class="mt_personnel" value="${mt.mt_personnel}" hidden disabled>
							<c:if test="${mt.mt_rule == 1 && mt.mt_state1 == 2}">
								<button class="btn btn-record-open">경기 결과</button>
							</c:if>
							<c:if test="${mt.mt_rule == 1 && mt.mt_state1 == 0}">
								<button class="btn btn-record-open">경기 진행중</button>
							</c:if>
							<c:if test="${mt.mt_rule == 0}">
								<button class="btn btn-record-open">참가자</button>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="modal">
		<div class="modal-content1">
			<div class="match-record-box">
				<button type="button" class="close btn-record-close" data-dismiss="modal">&times;</button><br>
				<p style="font-size: 20px; font-weight: bolder; margin: 0 auto; border-bottom: 8px solid #c2f296;
				width: 20%; padding: 20px 0 10px 0; text-align: center;">참가자 리스트</p>
				<div class="team-box">
				</div>
				<div class="reportBtn-box" style="text-align: center; margin-top: 40px;">
				</div>
				<div class="record-content-box">
				</div>
			</div>
			<div class="match-report-box">
				<p style="font-size: 20px; font-weight: bolder; margin: 0 auto; border-bottom: 8px solid #c2f296;
				width: 20%; padding: 20px 0 10px 0; text-align: center;">신고하기</p>
				<div class="report-box" style="margin-top: 50px;">
				</div>
				<div style="text-align: center; margin-top: 40px;">
					<button type="button" style="background-color: black; color: white; border-radius: 10px; width: 80px;"
						class="btn btn-matchReport-close">닫기</button> 
					<button  style="background-color: black; color: white; border-radius: 10px; width: 80px;"
						class="btn btn-report-insert">신고</button> 
				</div>	
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	mt_num = 0;
	te_num = 0;
	te_type = 0;
	
	mt_personnel = 0;
	entry = ``;
	
	rp_rc_num = 0;
	rp_content = ``;
	rp_me_num2 = 0;
	
	
	$(document).ready(function() {
        $('.btn-record-open').click(function() {
        	mt_num = $(this).siblings('.mt_num').val();
        	te_num = $(this).siblings('.te_num').val();
        	te_type = $(this).siblings('.te_type').val();
        	mt_personnel = $(this).siblings('.mt_personnel').val();
        	
        	$('.match-record-box').show();
			$('.match-report-box').hide();
			
        	printTeam()
        	printQuarter()
        	
            showModal();
        });

        $('.btn-record-close').click(function() {
            closeModal();
        });

        function showModal() {
            $('.modal').fadeIn();
        }

        function closeModal() {
            $('.modal').fadeOut();
        }
    });
	$(document).on('click', '.btn-matchReport-open', function() {
		$('.match-record-box').hide();
		$('.match-report-box').show();
		
		$('.modal-content1').toggleClass('modal-content2')
		$('.modal-content1').toggleClass('modal-content1')
		
		printReport()
		$('.report-select-sub').html(entry);
	});
	$(document).on('click', '.btn-matchReport-close', function() {
		$('.match-record-box').show();
		$('.match-report-box').hide();

		$('.modal-content2').toggleClass('modal-content1')
		$('.modal-content2').toggleClass('modal-content2')

	});
	$(document).on('change', '.report-type-select', function() {
		re_type = $(this).val();
		reset = ``;
		if(re_type == 0){
			$('.report-select-sub').html(entry);
			rp_me_num2 = $('.entry_me_num').val();
			rp_rc_num = $('.entry_rc_num').val();
		}else if(re_type == 1){
			$('.report-select-sub').html(reset);
			rp_me_num2 = $('.manager_me_num').val();
			rp_rc_num = $('.manager_rc_num').val();
		}else if(re_type == 2){
			$('.report-select-sub').html(reset);
			rp_me_num2 = $('.business_me_num').val();
			rp_rc_num = $('.business_rc_num').val();
		}
	})
	$(document).on('change', '.entry_me_num', function() {
		rp_me_num2 = $(this).val();
	})
	$(document).on('change', '.entry_rc_num', function() {
		rp_rc_num = $(this).val();
	})
	$(document).on('keyup', '.rp_content', function() {
		rp_content = $(this).val();
	})
	$(document).on('click', '.btn-report-insert', function() {
		if(rp_rc_num == 0){
			alert("옵션을 선택하세요.")
		}else{
			if(confirm("신고하시겠습니까?")){
				$('.match-record-box').show();
				$('.match-report-box').hide();

				$('.modal-content2').toggleClass('modal-content1')
				$('.modal-content2').toggleClass('modal-content2')
				
				data = {
					rp_rc_num:parseInt(rp_rc_num),
					rp_content:rp_content,
					rp_me_num2:parseInt(rp_me_num2),
					rp_mt_num:parseInt(mt_num)
				}
				
				insertReport(data);
			}else{
				alert("신고취소");
			}
		}
	})
	function printTeam() {
		str = ``;
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/application/print/team"/>',
			data : {mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				if(data.manager != null){
					str = `
						<p style="font-size: 20px; font-weight: bolder; margin: 0 auto; border-bottom: 8px solid #c2f296; width: 20%; padding: 20px 0 10px 0; text-align: center;">
							경기 결과
						</p>
						<div class="quarter-list-box">
						</div>
					`;
				}
					
				$('.record-content-box').html(str);
				str = ``;
				i = 0;
				for(team of data.teamList){
					str += `
						<div class="teamList-box">
							<table>
								<thead>
									<tr>
										<th>
											\${team.te_type}팀
					`;
					if(team.cl_name != null){
						str += `
							: <img class="club-emblem" alt="팀엠블럼" src="<c:url value='/clubimg\${team.cl_emblem}'/>">\${team.cl_name}
						`;
					}
					if(team.te_type == te_type){
						str += `
							(나의 팀)
						`;
					}
					str += `
										</th>
									</tr>
								</thead>
								<tbody>
					`;
					for(entry of data.entryList){
						if(team.te_num == entry.en_te_num){
							str += `
								<tr>
									<td>
										<span class="entry-member">
											<input type="text" value="\${entry.en_me_num}" hidden disabled>
											<img class="member-profile" alt="멤버프로필" src="<c:url value='/memberimg\${entry.me_profile}'/>">\${entry.me_nickname}(\${entry.me_tr_name})
										</span>
									</td>
								</tr>
							`;
						}
					}
					str += `
								</tbody>
							</table>
						</div>
					`;
					i++;
				}
				if(i == 0){
					i = 0;
					for(entry of data.entryList){
						if(i == 0){
							str += `
								<div class="teamList-box">
							`;							
						}
						if(i < mt_personnel){
							str += `
								<span class="entry-member">
									<input type="text" value="\${entry.en_me_num}" hidden disabled>
									<img class="member-profile" alt="멤버프로필" src="<c:url value='/memberimg\${entry.me_profile}'/>">\${entry.me_nickname}(\${entry.me_tr_name}) <br>
								</span>
							`;
							i++;
						}
						if(i == mt_personnel){
							str += `
								</div>
							`;
							i = 0;
						}
					}
				}
			}
		});
		$('.team-box').html(str);
		str = `
			<button type="button" class="btn-matchReport-open"
				 style="background-color: black; color: white; border-radius: 10px; height: 40px; width: 120px; margin: 0 20px 30px 10px;"
				 data-value="${board.bo_num}">신고하기</button>
		`;
		$('.reportBtn-box').html(str);
	}
	function printQuarter() {
		str = ``;
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/match/quarter/list"/>',
			data : {mt_num:mt_num, te_num:te_num},
			dataType : 'json',
			success : function(data) {
				i = 0;
				for(quarter of data.quarterList){
					str += `
						<div class="info-box quarter-box">
							<h4>\${i + 1}경기</h4>
					`;
					str += `
							<input type="number" class="recored-team1" value="\${quarter.team1}" hidden disabled>
							<input type="number" class="recored-team2" value="\${quarter.team2}" hidden disabled>
							<input type="number" class="recored-te_num1" value="\${quarter.qu_te_num1}" hidden disabled>
							<input type="number" class="recored-te_num2" value="\${quarter.qu_te_num2}" hidden disabled>
							<input type="number" class="recored-goal1" value="\${quarter.qu_goal1}" hidden disabled>
							<input type="number" class="recored-goal2" value="\${quarter.qu_goal2}" hidden disabled>
							<br>
							\${quarter.team1}팀 : \${quarter.qu_goal1}
					`;
					if(quarter.qu_goal1 > quarter.qu_goal2){
						str += `
								<span>승리</span>
								<br>
								\${quarter.team2}팀 : \${quarter.qu_goal2}
								<span>패배</span>
							</div>
						`;
					}else if(quarter.qu_goal1 == quarter.qu_goal2){
						str += `
								<span>무승부</span>
								<br>
								\${quarter.team2}팀 : \${quarter.qu_goal2}
								<span>무승부</span>
							</div>
						`;
					}else if(quarter.qu_goal1 < quarter.qu_goal2){
						str += `
								<span>패배</span>
								<br>
								\${quarter.team2}팀 : \${quarter.qu_goal2}
								<span>승리</span>
							</div>
						`;
					}
					i++;
				}
			}
		});
		$('.quarter-list-box').html(str);
	}
	function printReport() {
		str = ``;
		manager = ``;
		entry = ``;
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/print/report/match"/>',
			data : {mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				entry += `
					<select class="entry_me_num form-control" style="flex: 1;">
				`;
				i = 0;
				for(en of data.entryList){
					if(i == 0){
						rp_me_num2 = en.en_me_num;
						rp_rc_num = 0;
						rp_content = ``;
					}
					entry += `
							<option value="\${en.en_me_num}">\${en.me_nickname}</option>
					`;
					i++;
				}
				entry += `
					</select>
					<select class="entry_rc_num form-control" style="flex: 1;">
						<option value="0">분류</option>
						<option value="1">폭행</option>
						<option value="2">욕설</option>
						<option value="3">지각</option>
						<option value="4">음주</option>
						<option value="5">비매너 플레이</option>
						<option value="14">기타</option>
					</select>
				`;
				
				str += `
					<div class="report-type-select-box">
						<select class="report-type-select form-control" style="margin-bottom: 5px;">
							<option value="0">회원</option>
				`;
				if(data.manager != null){
					str += `
						<option value="1">매니저</option>
					`;
				}
				str += `
					<option value="2">사업자</option>
				`;
				str += `
						</select>
				`;
				if(data.manager != null){
					str += `
						<input type="text" class="manager_me_num" value="\${data.manager.me_num}" hidden disabled>
						<input type="text" class="manager_rc_num" value="15" hidden disabled>
					`;
				}
				str += `
						<input type="text" class="business_me_num" value="\${data.business.me_num}" hidden disabled>
						<input type="text" class="business_rc_num" value="16" hidden disabled>
					</div>
					<div class="report-select-sub" style="margin-bottom: 5px; min-heigth: 38px;">
					</div>
					<div>
						<textarea class="rp_content" style="width: 360px; min-height: 200px;"></textarea>
					</div>
					
				`;
			}
		});
		$('.report-select-sub').html(entry);
		$('.report-box').html(str);
	}
	function insertReport(data){
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/member/matchReport/insert"/>',
			data : JSON.stringify(data),
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				console.log(data);
				alert(data.msg);
			}
		});
	}
	</script>
</body>
</html>