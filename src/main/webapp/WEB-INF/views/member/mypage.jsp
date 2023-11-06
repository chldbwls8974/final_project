<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<style type="text/css">
	
	body{font-family: Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, 'Helvetica Neue', 'Segoe UI', 'Apple SD Gothic Neo', 'Noto Sans KR', 'Malgun Gothic', sans-serif;
		color:black;
	}
	.body-double{ display: flex; margin-top: 10px; padding: 20px;
	}
	li img, .myprofile-btn img{ width: 30px; height: 30px; float: left;
		padding-right: 0; margin-right: 10px;
	}
	li{ list-style-type: none; padding: 12px 0;
	}
	a{ text-decoration: none; color: black;
	}
	a:hover { text-decoration: none; color: navy;
	}
	.my{
		position: relative; margin-right: 10px; width: 100%;
	}
	.menu{
		width: 100%;
	}
	.body-double{ }
	.body-right{ background-color: #f0f0f0; border-radius: 20px; 
		width: 100%; height: auto; padding: 20px;
	}
	.myprofile-image-thumb{ width: 70px; height: 70px; border-radius: 50%;
		 margin-right: 10px;}
	.myedit{ width: 170px; height: 50px; border-radius: 20px;
		padding:20px;
	}
	
	
	.mypoint-thumb{
		width: 50%; height: 150px; border-radius: 20px; margin: 20px 20px 20px 0;
		padding: 20px; background-color: #f0f0f0; position: relative;
	}	
	.mytier-thumb{ background-color: #f0f0f0; border-radius:20px; padding:20px;
		position: relative; margin: 20px 0 20px 0; width: 50%; height: 150px;
	}
	.mytier-title{ display: flex; align-items: center; justify-content: flex-start;
		font-size:large; font-weight: bolder;
	}
	.mytier-box{
		display: flex; justify-content: flex-start; margin-top: 20px;
	}
	.myclub-thumb{ width: 100%; height: auto; border-radius:20px;
		background-color: #f0f0f0; padding: 20px; margin: 0 20px 20px 0; 
	}
	.mymenu-list li{ text-align: left;}
	
</style>

</head>
<body>
<div class="body-double">
		<section class="my">
			<div class="body-left">
				<div class="left-one">
					<div style="background-color: #f0f0f0; padding: 15px; border-radius: 20px; height:130px; padding: 30px 20px; display: flex;  justify-content: space-between;">
						<div style="display: flex;">
							<div class="myprofile-image">
			                  <c:if test="${user.me_profile ==null}">
			                     <img src="${pageContext.request.contextPath}/resources/images/basic.jpg" class="myprofile-image-thumb" alt="프로필 사진">
			                  </c:if>
		               		</div>
		               		<div>
								<div class="myprofile-name" style="">
									<div style="font-size: 24px; font-weight:800;">${user.me_name}</div>
								</div>
								<div class="myprofile-num">
									<p style="color:#606060;">${user.me_id}</p>
									<span class="myprofile-kakao"></span>
								</div>
							</div>
						</div>
						<div class="myedit">
							<a href="<c:url value='/member/myedit'/>" class="myprofile-btn">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_setting_color.svg" alt="나의 포인트">
								<p>프로필 수정</p>
							</a>
						</div>
					</div>
					<div style="display: flex;">
						<div class="mypoint-thumb">
							<p style="font-size:large; font-weight: bolder; margin-bottom: 20px;">내 포인트</p>
							<div style="width: 25%;">
								<p style="font-size:large; font-weight: bolder;">${user.me_point}원</p>
							</div>
							<div style="width: 75%;">
							<div style="width: 110px; padding:20px; border-radius: 10px; background-color:#c2f296;">
								<a href="#"><p>충전하기</p></a>
							</div>
							</div>
						</div>
						<div class="mytier-thumb">
							<p class="mytier-title">내 티어</p>
							<div class="mytier-box">
								<div style="padding:0px; width:23px; height:25px; border-radius:5px; background-color: black;">
									<div style="text-align:center; font-size:15px; padding:0; color: white; font-weight: bolder;">1</div>
								</div>
									<div style="margin-left:5px; font-weight: bolder; font-size: 15px; letter-spacing: 1px;">스타터</div>	
							</div>
						</div>
					</div>	
					<div class="myclub-thumb">
						<p style="font-size:large; font-weight: bolder; margin-bottom: 20px;">소속 클럽</p>
						<c:forEach items="${list}" var="list">
							<a href="<c:url value='/club/detail?cl_num=${list.cl_num}'/>" class="myclub-link" style="display: flex;">
								<img src="" alt="나의 클럽" style="width: 30px; height: 30px; border-radius: 10px;">
								<p style="font-weight: bolder; font-size: 15px;">${list.cl_name }</p>
							</a>
						</c:forEach>
					</div>
				</div>	
			</div>
		</section>
		<section class="menu">
			<div class="body-right">
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