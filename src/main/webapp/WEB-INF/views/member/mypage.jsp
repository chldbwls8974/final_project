<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<title>마이페이지</title>
</head>
<body>
	<h1>My page</h1>
	<div>
		<section>
			<div>
				<div>
				<div class="myprofile-name">
					<h2>${user.me_name}</h2>
				</div>
				<div class="myprofile-num">
					<p>번호16156</p>
					<span class="myprofile-kakao"></span>
				</div>
				</div>
				<div>
					<a href="#" class="myprofile-btn">내 프로필</a>
				</div>
			</div>
		</section>
		<section>
			<h3>나의 메뉴</h3>
			<div class="mymenu">
				<ul class="mymenu-list">
					<li>
						<a href="#">
						<img src="" alt="신청 경기">
						<p></p>
						</a>
					</li>	
					<li>
						<a href="#">
						<img src="" alt="나의 전적">
						<p></p>
						</a>
					</li>
					<li>
						<a href="#">
						<img src="" alt="나의 티어">
						<p></p>
					</a>
					</li>
					<li>
						<a href="#">
						<img src="" alt="소속 클럽">
						<p></p>
						</a>
					</li>
					<li>
						<a href="#">
						<img src="" alt="회원 조회">
						<p></p>
						</a>
					</li>
					<li>
						<a href="#">
						<img src="" alt="나의 포인트">
						<p></p>
						</a>
					</li>
					<li>
						<a href="#">
						<img src="" alt="나의 쿠폰">
						<p></p>
						</a>
					</li>
				</ul>
			</div>
		</section>
	</div>
</body>
</html>