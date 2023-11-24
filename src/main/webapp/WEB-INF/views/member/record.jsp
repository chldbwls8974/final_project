<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기 전적</title>
</head>
<body>
	<div class="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>매치 일시</th>
					<th>매치 타입</th>
					<th>장소</th>
	        		<th>소속</th>
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
						<td></td>
						<td>
							<c:if test="${mt.mt_rule == 1}">
								${mt.win + mt.draw + mt_lose}전 ${mt.win}승 ${mt.draw}무 ${mt.lose}패
							</c:if>
						</td>
						<td>
							<c:if test="${mt.mt_rule == 1}">
								<button class="btn">경기 결과</button>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>