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
	<div>
		<section>
			<div class="section-title">
				<h3>나의 경기 전적</h3>
			</div>
			<div>
				<div class="record-filter">
					<ul>
						<li>
							<span>내 지역</span>
							<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_filter_arrow_selected.svg">
						</li>
						<li>
							<span>날짜</span>
							<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_filter_arrow_selected.svg">
						</li>
						<li>
							<span>시간</span>
							<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_filter_arrow_selected.svg">
						</li>
					</ul>
				</div>
			</div>
			<div class="recordview-list">
				<p>참여한 경기 횟수</p>
				<p></p>
			</div>
			<div class="recordview-list">
				<p>획득한 점수 합산</p>
				<p>${member.me_rating}</p>
			</div>
		</section>
	</div>
</body>
</html>