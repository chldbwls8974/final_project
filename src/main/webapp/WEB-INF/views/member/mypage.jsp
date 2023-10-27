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

<style type="text/css">
	img{ width: 24px; height: 24px; }
	li{ list-style-type: none;}
	a{ text-decoration: none; color: black;}
	a:hover { text-decoration: none; color: navy;}
	img{float: left; padding-right: 5px;}
	section.my{
		width: 100%;
		height: auto;
	}
	section.menu{
		width: 50%;
		height: auto;
		float: left;
	}
</style>

</head>
<body>
	<h1>My page</h1>
	<div>
		<section class="my">
			<div>
				<div>
					<div class="myprofile-image">
						<img src="" alt="프로필 사진">
					</div>
					<div class="myprofile-name">
						<h2>${user.me_name}</h2>
					</div>
					<div class="myprofile-num">
						<p>임시번호16156</p>
						<span class="myprofile-kakao"></span>
					</div>
				</div>
				<div>
					<a href="<c:url value='/member/myedit'/>" class="myprofile-btn">
					<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_setting_color.svg" alt="나의 포인트">
					<p>내 프로필 수정</p>
					</a>
				</div>
			</div>
		</section>
		<section class="menu">
			<h3>나의 메뉴</h3>
			<div class="mymenu">
				<ul class="mymenu-list">
					<li>
						<a href="#">
						<img width="24px" height="24px" src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_myplab_color.svg" alt="신청 경기">
						<p>신청 경기</p>
						</a>
					</li>	
					<li>
						<a href="#">
						<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_friend_match.svg" width="24px" height="24px" alt="나의 전적">
						<p>나의 전적</p>
						</a>
					</li>
					<li>
						<a href="#">
						<img src="	https://d31wz4d3hgve8q.cloudfront.net/media/ic_crown.svg" width="24px" height="24px" alt="나의 티어">
						<p>나의 티어</p>
					</a>
					</li>
					<li>
						<a href="<c:url value='/member/clublist'/>">
						<img src="https://cdn.icon-icons.com/icons2/2556/PNG/512/team_friends_partners_partner_icon_153084.png" width="24px" height="24px" alt="소속 클럽">
						<p>소속 클럽</p>
						</a>
					</li>
					<li>
						<a href="">
						<img src="https://d31wz4d3hgve8q.cloudfront.net/media/ic_nav_team_recruit_member.svg" width="24px" height="24px" alt="승인 대기 중 클럽">
						<p>승인 대기 중 클럽</p>
						</a>
					</li>
					<li>
						<a href="<c:url value='/member/search'/>">
						<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_profile.svg" width="24px" height="24px" alt="회원 조회">
						<p>회원 조회</p>
						</a>
					</li>
					<li>
						<a href="#">
						<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_point_color.svg" width="24px" height="24px" alt="나의 포인트">
						<p>나의 포인트</p>
						</a>
					</li>
					<li>
						<a href="#">
						<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_coupon_color.svg" width="24px" height="24px" alt="나의 쿠폰">
						<p>나의 쿠폰</p>
						</a>
					</li>
					<li>
						<a href="<c:url value='/account/insert'/>">
						<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_new_team.svg" width="24px" height="24px" alt="환급 계좌 등록">
						<p>환급 계좌 등록</p>
						</a>
					</li>
					<li>
						<a href="<c:url value='/member/refund'/>">
						<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_manner_card.svg" width="24px" height="24px" alt="포인트 환급">
						<p>포인트 환급</p>
						</a>
					</li>
				</ul>
			</div>
		</section>
	</div>
</body>
</html>