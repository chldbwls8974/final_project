<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소속 클럽 조회</title>
</head>
<body>
	<h3>나의 소속 클럽 조회</h3>
			<input type="button" value="내 클럽 설정" class="mb-10">
	<section>
<%-- 		<c:forEach items="${clublist}" var="club"> --%>
		<div class="club">
			<div>
				<div class="clubview-list">
					<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_venue.svg">
<!-- 					<p>클럽 엠블럼</p> -->
					<p>${club.cl_emblem}</p>
				</div>
				<div class="clubview-list">
					<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_venue.svg">
<!-- 					<p>클럽 이름</p> -->
					<p>${club.cl_name}</p>
				</div>
				<div class="clubview-list">
					<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_venue.svg">
<!-- 					<p>활동 지역</p> -->
					<p>${club.cl_rg_num}</p>
				</div>
				<div class="clubview-list">
					<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_time.svg">
					<p>선호 시간</p>
					<p>${club.tt_num}</p>
				</div>
				<div class="clubview-list">
					<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_time.svg">
<!-- 					<p>선호 지역</p> -->
					<p>${club.pr_num}</p>
				</div>
				<div class="clubview-list">
					<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_my.svg">
<!-- 					<p>클럽 멤버</p> -->
					<p>${club.cm_num}</p>
				</div>
			</div>
		</div>
<%-- 		</c:forEach> --%>
	</section>
</body>
</html>