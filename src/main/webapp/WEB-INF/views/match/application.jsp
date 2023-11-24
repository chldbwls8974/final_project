<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>매치 페이지</title>
	<style type="text/css">
	nav{width: 100%;}
	input{text-align: right;}
	.left-box{}
	.right-box{ display: flex; height: 500px; padding-left: 10px}
	.contents-box{padding: 10px}
	.info-box{
		width: 100%; background-color: #f2f2f2; height: 300px; margin-bottom: 10px;
		border-radius: 20px; box-sizing: border-box;
	}
	.right-side-box{
		width: 100%; height: auto; float: right; margin: 0 10px 10px 10px;
		border-radius: 20px; background-color: #e5f4d8;  box-sizing: border-box;
	}
	.right-side-box p{
		font-size: 20px; font-weight: bolder; margin: 0 auto;
		padding: 50px 0 30px 0; text-align: center;
	}
	.right-side-box div{ text-align: center;}
	.team-box{display: flex; background-color: black;}
	.teamList-box{flex: 1; margin-right: 3px; background-color: white; text-align: center;}
	.teamList-box:last-child {margin-right: 0;}
	.club-list-box{display: flex;}
	.club-member-box{flex: 1; border-right: 3px solid black; overflow: scroll;}
	.club-entry-box{flex: 1; overflow: scroll;}
	.entry-member::after{clear: both; content: ''; display: block;}
	.entry-btn{float: right}
	.member-list{border-bottom: 1px solid black}
	.member-list:last-child{border-bottom: none;}
	.entry-list-box{height: auto;}
	.total-price{
	    width: 100px;
	    height: 40px;
	    border-radius: 10px;
	    border: none;
	    background-color: #ffff;
	    text-align: center;
	    margin: 20px auto 0 auto;
	}
	.club-emblem{width: 20px; height: 20px; border-radius: 50%;}
	.member-profile{width: 20px; height: 20px; border-radius: 50%;}
	</style>
</head>
<body>
	<p style="font-size: 35px; font-weight: bolder; margin: 50px auto; border-bottom: 8px solid #c2f296;
	width: 20%; padding: 30px 0 10px 0; text-align: center;">매치 페이지</p>
	<nav class="container-body">
		<div class="contents-box left-box">
			<div class="info-box match-box">
			${match}
			</div>
			<c:if test="${cl_num != 0 && match.team_count != 0}">
				<div class="info-box team-box">
				</div>
			</c:if>
		</div>
		<div class="contents-box right-box">
			<c:if test="${(match.mt_type == 0 && cl_num == 0) || (match.mt_type == 1 && cl_num == 0)}">
				<c:if test="${match.entry_res == 0}">
					<div class="application-box right-side-box">
						<div style="margin-top: 60px;">
							<p>개인 매치 신청</p>
							<div style="display: inline-grid;">
								<span> ${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre}포인트/2시간</span>
								<p style="font-size: 15px; font-weight: 400; padding: 0;">차감 예정입니다.</p>
								<input type="text" class="total-price" disabled value="${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre}P"> <br>
							</div>
							<div>
								<button class="btn btn-application"
										style="width: 100px; height: 40px; border: none; margin-top: 20px;
										border-radius: 5px; background-color: black; color: white;">
									신청</button>
							</div>	
						</div>
					</div>
					<div class="coupon-box right-side-box">
						<div style="margin-top: 60px;">
							<p>보유 쿠폰</p>
							<div>
								<c:forEach items="${couponList}" var="co">
									<div style="padding: 10px;">
										<input type="radio" name="coupon" value="${co.hp_num}">${co.cp_source}(${co.cp_sale}) <br>
										<input type="text" class="sale-point" value="${co.cp_sale}" hidden>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${match.entry_res != 0}">
					<div class="cansel-box right-side-box">
						<div>
							<p>취소</p>
							<button class="btn btn-cansel"
									style="width: 100px; height: 40px; border: none; 
									border-radius: 5px; background-color: black; color: white;">
								취소</button>
						</div>	
					</div>
					<c:if test="${match.entry_res == 1 && match.ready==1}">
						<div class="entry-list-box right-side-box">
							<div>
								<p>참가자 리스트</p>
								<c:forEach items="${entryList}" var="el">
									<span><img class="member-profile" alt="멤버프로필" src="<c:url value='/memberimg${el.me_profile}'/>">${el.me_nickname}(${el.me_tr_name})</span> <br>
								</c:forEach>
							</div>
						</div>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${(match.mt_type == 0 && cl_num != 0) || (match.mt_type == 2 && cl_num != 0)}">
				<c:if test="${match.entry_res == 0}">
					<div class="application-box right-side-box">
						<div>
							<p>클럽 매치 신청</p>
							<span>비용 : ${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre}포인트/2시간</span>
							<input type="text" class="total-price" disabled value="${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre}Point"> <br>
							<button class="btn btn-application"
									style="width: 100px; height: 40px; border: none; 
									border-radius: 5px; background-color: black; color: white;">
								신청</button>
						</div>
					</div>
				</c:if>
				<c:if test="${match.entry_res != 0}">
					<div class="cansel-box right-side-box">
						<div>
							<p>취소</p>
							<button class="btn btn-cansel"
									style="width: 100px; height: 40px; border: none;
									border-radius: 5px; background-color: black; color: white;">
								취소</button>
						</div>	
					</div>
					<div class="club-list-box right-side-box">
						
					</div>
				</c:if>
			</c:if>
			<c:if test="${(match.mt_type == 1 && cl_num != 0) || (match.mt_type == 2 && cl_num == 0)}">
				<h1>잘못된 접근입니다.</h1>			
			</c:if>
		</div>
	</nav>
	<script type="text/javascript">
	let cl_num = ${cl_num};
	let hp_num = 0;
	let total_price = ${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre};
	let mt_num = ${match.mt_num};
	
	printTeam()
	if(cl_num != 0){
		printClubMemberState()		
	}
	
	$(document).on('click', '[name=coupon]', function() {
		hp_num = $(this).val();
		total_price = ${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre} - $(this).siblings('.sale-point').val();

		$('.total-price').val(total_price+"P");
	});
	$(document).on('click', '.btn-application', function() {
		application()
	});
	$(document).on('click', '.btn-cansel', function() {
		cansel()
	});
	$(document).on('click', '.entry-add-btn', function() {
		if(${match.mt_personnel == match.club_entry_count}){
			alert("참가자를 모두 선택하였습니다.");
		}else{
			me_num = $(this).siblings('input').val();
			entryAdd(me_num);
		}
	});
	$(document).on('click', '.entry-unable-btn', function() {
		alert("이미 스케줄이 있는 회원입니다. \n다른 회원을 선택해주세요.");
	});
	$(document).on('click', '.entry-del-btn', function() {
		en_num = $(this).siblings('input').val();
		entryDel(en_num);
	});
	function application() {
		if(cl_num == 0){
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/match/application/solo"/>',
				data : {mt_num:mt_num, total_price:total_price, hp_num:hp_num},
				dataType : 'json',
				success : function(data) {
					if(data.res){
						alert(data.msg);
						location.href='<c:url value="/match/application?mt_num="/>'+ mt_num + '&cl_num=' + cl_num;
					}else{
						alert(data.msg);
					}
				}
			});
		}else if(cl_num != 0){
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/match/application/club"/>',
				data : {mt_num:mt_num, total_price:total_price, cl_num:cl_num},
				dataType : 'json',
				success : function(data) {
					if(data.res){
						alert(data.msg);
						location.href='<c:url value="/match/application?mt_num="/>'+ mt_num + '&cl_num=' + cl_num;
					}else{
						alert(data.msg);
					}
				}
			});
		}
	}
	function cansel() {
		if(cl_num == 0){
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/match/cansel/solo"/>',
				data : {mt_num:mt_num},
				dataType : 'json',
				success : function(data) {
					if(data.res){
						alert(data.msg);
						location.href='<c:url value="/match/application?mt_num="/>'+ mt_num + '&cl_num=' + cl_num;
					}else{
						alert(data.msg);
					}
				}
			});
		}else if(cl_num != 0){
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/match/cansel/club"/>',
				data : {mt_num:mt_num, cl_num:cl_num},
				dataType : 'json',
				success : function(data) {
					if(data.res){
						alert(data.msg);
						location.href='<c:url value="/match/application?mt_num="/>'+ mt_num + '&cl_num=' + cl_num;
					}else{
						alert(data.msg);
					}
				}
			});
		}
	}
	function entryAdd(me_num) {
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/club/entry/add"/>',
			data : {me_num:me_num, cl_num:cl_num, mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				if(data.res){
					alert("등록 성공");
					printTeam()
					printClubMemberState()
				}else{
					alert("등록 실패")	;			
				}
			}
		});
	}
	function entryDel(en_num) {
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/club/entry/del"/>',
			data : {en_num:en_num},
			dataType : 'json',
			success : function(data) {
				if(data.res){
					alert("삭제 성공");
					printTeam()
					printClubMemberState()
				}else{
					alert("삭제 실패")	;			
				}
			}
		});
	}
	function printTeam() {
		str = ``;
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/application/print/team"/>',
			data : {mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				count = 0;
				for(team of data.teamList){
					str += `
						<div class="teamList-box">
							<table>
								<thead>
									<tr>
										<th>
											\${team.te_type}팀 : <img class="club-emblem" alt="팀엠블럼" src="<c:url value='/clubimg\${team.cl_emblem}'/>">\${team.cl_name}
											(\${team.club_entry_count}/${match.mt_personnel})
										</th>
									</tr>
								</thead>
								<tbody>
					`;
					if(team.ct_cl_num == cl_num || ${match.ready == 1}){
						for(entry of data.entryList){
							if(team.te_num == entry.en_te_num){
								str += `
									<tr>
										<td>
											<span>
												<img class="member-profile" alt="멤버프로필" src="<c:url value='/memberimg\${entry.me_profile}'/>">\${entry.me_nickname}(\${entry.me_tr_name})
											</span>
										</td>
									</tr>
								`;
							}
						}
					}
					str += `
								</tbody>
							</table>
						</div>
					`;
					count++;
				}
				if(${match.mt_type = 2}){
					for(;count < ${match.mt_rule == 0 ? 2 : 3}; count++){
						str += `
							<div class="teamList-box">
								참가 클럽 대기중
							</div>
						`;
					}
				}
			}
		});
		$('.team-box').html(str);
	}
	function printClubMemberState() {
		str = ``;
		str += `
			
		`;
		$.ajax({
			async : false,
			method : 'post',
			url : '<c:url value="/application/print/club"/>',
			data : {cl_num:cl_num, mt_num:mt_num},
			dataType : 'json',
			success : function(data) {
				console.log(data)
				str += `
					<div class="club-member-box">
				`;
				for(cm of data.CMList){
					if(cm.en_num == 0){
						if(cm.entry_able == 1){
							str += `
								<div class="entry-able-member member-list">
									<img class="member-profile" alt="멤버프로필" src="<c:url value='/memberimg\${cm.me_profile}'/>">\${cm.me_nickname}
							`;
							if(${authority == 'LEADER'}){
								str += `
									<button class="entry-btn btn btn-primary entry-add-btn">등록</button>
								`;
							}
							str += `
									<br>
									(\${cm.me_tr_name})
									<input hidden disabled value="\${cm.cm_me_num}">
								</div>
							`;
						}
						if(cm.entry_able != 1){
							str += `
								<div class="entry-disable-member member-list">
									<img class="member-profile" alt="멤버프로필" src="<c:url value='/memberimg\${cm.me_profile}'/>">\${cm.me_nickname}
							`;
							if(cm.entry_able != 1){
								str += `
									<button class="entry-btn btn btn-secondary entry-unable-btn">등록</button>
								`;
							}
							str += `
									<br>
									(\${cm.me_tr_name})
									<input hidden disabled value="\${cm.cm_me_num}">
								</div>
							`;
						}
					}
				}
				str += `
					</div>
					<div class="club-entry-box">
				`;
				for(cm of data.CMList){
					if(cm.en_num != 0){
						str += `
							<div class="entry-member member-list">
								<img class="member-profile" alt="멤버프로필" src="<c:url value='/memberimg\${cm.me_profile}'/>">\${cm.me_nickname}
						`;
						if(${authority == 'LEADER' && match.ready == 0}){
							str += `
								<button class="entry-btn btn btn-danger entry-del-btn">삭제</button>
							`;
						}
						str += `
								<br>
								(\${cm.me_tr_name})
								<input hidden disabled value="\${cm.en_num}">
							</div>
						`;
					}
				}
				str += `
					</div>
				`;
			}
		});
		$('.club-list-box').html(str);
	}
	</script>
</body>
</html>
