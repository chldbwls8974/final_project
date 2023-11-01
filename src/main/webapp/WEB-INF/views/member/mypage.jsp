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
	
	body{color:black; font-family: Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, 'Helvetica Neue', 'Segoe UI', 'Apple SD Gothic Neo', 'Noto Sans KR', 'Malgun Gothic', sans-serif;}
	.body-double{ display: flex; margin-top: 50px;}
	.my{
		position: relative; width: 60%; margin-right: 10px;
	}
	.menu{
		width: 100%;
	}
	img{ width: 24px; height: 24px; }
	li{ list-style-type: none; padding: 12px 0;}
	a{ text-decoration: none; color: black;}
	a:hover { text-decoration: none; color: navy;}
	img{float: left; padding-right: 0;}
	.myprofile-image-thumb{ width: 70px; height: 70px; border-radius: 50%;
	 margin-right: 10px;}
	.mytier{background-color:#F8FAFB; border-radius:20px; padding:20px;
	position: relative; width: 150px;}
	.mytier-title{display: flex; align-items: center; justify-content: flex-end;
	font-weight: bolder; text-align: center;}
	.mytier-box{display: flex; align-items: center; justify-content: flex-end;}
	
</style>

</head>
<body>
<div class="body-double">
		<section class="my">
			<div class="body-left">
				<div style="background-color: #F8FAFB; padding: 15px; border-radius: 30px; margin-bottom: 20px;">
					<div class="myprofile-image">
	                  <c:if test="${user.me_profile ==null}">
	                     <img src="${pageContext.request.contextPath}/resources/images/basic.jpg" class="myprofile-image-thumb" alt="프로필 사진">
	                  </c:if>
               		</div>
					<div class="myprofile-name" style="position: relative;">
						<div style="font-size: 24px; font-weight:800;">${user.me_name}</div>
					</div>
					<div class="myprofile-num">
						<p style="color:#606060;">${user.me_id}</p>
						<span class="myprofile-kakao"></span>
					</div>
				</div>
				<div class="mytier">
					<p class="mytier-title">내 티어</p>
					<div class="mytier-box">
						<div style="padding:3px; width:23px; height:27px; border-radius:5px; background-color: black;">
							<div style="text-align:center; font-size:15px; padding:0; color: white; font-weight: bolder;">1</div>
						</div>
							<div style="margin-left:5px; font-weight: bolder; font-size: 15px; letter-spacing: 1px;">스타터</div>	
					</div>
				</div>
				<div style="padding:20px; border-radius: 20px; background-color:#F8FAFB; margin:10px 0 20px 0;">
					<a href="<c:url value='/member/myedit'/>" class="myprofile-btn">
					<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_setting_color.svg" alt="나의 포인트">
					<p>내 프로필 수정</p>
					</a>
				</div>
				<div style="padding:30px; border-radius: 30px; background-color: #F8FAFB; position: relative;">
					<p style="font-size:15px; font-weight: bold;">내 포인트</p>
					<p style="font-size:18px; font-weight: bolder;">${user.me_point}원</p>
					<div style="padding:20px; border-radius: 10px; background-color:#E9F6FF; float: right; position: absolute; right: 10px; top: 40px;">
						<a href="<c:url value='/payment/main'/>">충전하기</a>
					</div>
				</div>
			</div>
		</section>
		<section class="menu">
			<div class="body-right" style="background-color: #F8FAFB; border-radius: 30px;">
				<div style="font-size: 18px; font-weight: bolder; margin-left:15px; padding: 20px;">나의 메뉴</div>
				<div class="mymenu">
					<ul class="mymenu-list">
						<li>
							<a href="<c:url value='/member/mymatch'/>">
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
							<a href="<c:url value='/member/myCoupon'/>">
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
			</div>	
		</section>
</div>	
</body>
</html>