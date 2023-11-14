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
	.entry-btn{float: right;}
	.member-list{border-bottom: 1px solid black;}
	.member-list:last-child{border-bottom: none;}
	.entry-list-box{height: auto;}
	.entry-btn-box{float: right;}
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
				<c:forEach items="${entryList}" var="el">
					<div class="entry-member member-list">${el.me_nickname}(${el.me_tr_name})
						<c:if test="${el.te_type != 0}">
							${el.te_type}팀
						</c:if>
						<input hidden disabled value="${el.en_num}">
						<c:if test="${match.ready == 1 && el.te_type == 0}">
							<div class="entry-btn-box">
								<button class="entry-btn" value="3">3팀</button>
								<button class="entry-btn" value="2">2팀</button>
								<button class="entry-btn" value="1">1팀</button>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
	</nav>
	<script type="text/javascript">
	printTeam();
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
	</script>
</body>
</html>
