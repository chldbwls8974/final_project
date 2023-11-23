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
	li img, .myprofile-btn img{
		width: 30px; height: 30px; float: left;
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
	.body-right{
		background-color: #f2f2f2; border-radius: 20px; 
		width: 100%; height: auto; padding: 20px;
	}
	.myprofile-image-thumb{
		width: 70px; height: 70px; border-radius: 50%;
		 margin-right: 10px;}
	.myedit, .myprofile-detail{
		width: 140px; height: 40px; border-radius: 20px;
		padding: 0;
	}
	.btn-box{ display: inline-block;}
	
	
	.mypoint-thumb{
		width: 50%; height: 150px; border-radius: 20px; margin: 20px 20px 20px 0;
		padding: 20px; background-color: #d7fdb5; position: relative;
	}	
	.mytier-thumb{
		background-color: #f2f2f2; border-radius:20px; padding:20px;
		position: relative; margin: 20px 0 20px 0; width: 50%; height: 150px;
	}
	.mytier-title{
		display: flex; align-items: center; justify-content: flex-start;
		font-size:large; font-weight: bolder;
	}
	.mytier-box{
		display: flex; justify-content: flex-start; margin-top: 20px;
	}
	.myclub-thumb{
		width: 100%; height: auto; border-radius:30px;
		background-color: #f2f2f2; padding: 20px; margin: 0 20px 20px 0; 
	}
	.mymenu-list li{ text-align: left;}
	
	.memberlist-control, .leaderlist-control, .rookielist-control{ padding: 0;}
	.memberlist-link, .leaderlist-link, .rookielist-link{ padding: 0 0 5px 0;}
	.memberlist-box p, .leaderlist-box p, .rookielist-box p{ font-size: 14px; margin-left: 10px;}
	.club-btn{
		width: 40px; height: 30px; margin: 0 3px 0 0; border: none; font-size: 13px;
		border-radius: 5px; background-color: #c7efa2; color: black;
	}
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
	.modal-content {
	background-color: white;
	padding: 20px;
	border-radius: 5px;
	width: 600px;
	margin: 50px auto;
	}
</style>

</head>
<body>
<div class="body-double">
		<section class="my">
			<div class="body-left">
				<div class="left-one">
					<div style="background-color: #f0f0f0; padding: 15px; 
					border-radius: 20px; height:130px; padding: 30px 20px; display: flex; justify-content: space-between;">
						<div style="display: flex;">
								<div class="myprofile-image">
				                    <img src="<c:url value='/memberimg${user.me_profile}'/>" class="myprofile-image-thumb" alt="프로필 사진">
			              		 </div>
							<a href="<c:url value='/member/myprofile?me_num=${user.me_num}'/>" class="myprofile-info">
			              	 	<div style="margin-left: 10px;">
									<div class="myprofile-name" style="position: relative;">
										<div style="font-size: 24px; font-weight:800;">${user.me_name}</div>
									</div>
									<div class="myprofile-num">
										<p style="color:#606060;">${user.me_id}</p>
										<span class="myprofile-kakao"></span>
									</div>
								</div>
							</a>
						</div>
						<div class="btn-box">
							<div class="myprofile-detail">
								<a href="<c:url value='/member/myprofile?me_num=${user.me_num}'/>" class="myprofile-btn">
									<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_profile.svg"
										style="width: 22px; height: 22px; margin-left: 5px;" alt="내 프로필">
									<p style="margin: 0;">프로필 조회</p>
								</a>
							</div>	
							<div class="myedit">
								<a href="<c:url value='/member/myedit?me_num=${user.me_num}'/>" class="myprofile-btn">
									<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_setting_color.svg" alt="프로필 수정">
									<p>프로필 수정</p>
								</a>
							</div>
						</div>
					</div>
					<div style="display: flex;">
						<div class="mypoint-thumb">
						<p style="font-size:large; font-weight: bolder; margin-bottom: 20px;">내 포인트</p>
							<div style="display: flex; justify-content: space-between;">		
								<div style="width: 75%;">
									<p style="font-size:large; font-weight: bolder; margin-left: 3px;" class="point-information"></p>
								</div>
								<div style="width: 50%; position: relative;">
									<div style=" position: relative; bottom: 5px; right: 5px; text-align: center;
										 padding: 10px; border-radius: 10px; background-color: white;">
										<a href="<c:url value='/payment/main'/>"><p style="margin: 0 auto;">충전하기</p></a>
									</div>
								</div>
							</div>	
						</div>
						<div class="mytier-thumb">
							<p class="mytier-title">내 티어
							<button class="tier-tip btn-info-open" style="width: 20px; height: 20px; margin-left: 5px; background-color: black; color: white;
							font-weight: bold; text-align: center; line-height: 9px; padding-left: 6px;">!</button></p>
							<div class="mytier-box">
								<div style="padding:0px; width:23px; height:25px; border-radius:5px; background-color: black;">
										<c:if test="${user.me_tr_name == '스타터'}">
											<div style="text-align:center; font-size:15px; padding:0; color: white; font-weight: bolder;">0</div>
										</c:if>
										<c:if test="${user.me_tr_name == '브론즈'}">
											<div style="text-align:center; font-size:15px; padding:0; color: white; font-weight: bolder;">1</div>
										</c:if>
										<c:if test="${user.me_tr_name == '실버'}">
											<div style="text-align:center; font-size:15px; padding:0; color: white; font-weight: bolder;">2</div>
										</c:if>
										<c:if test="${user.me_tr_name == '골드'}">
											<div style="text-align:center; font-size:15px; padding:0; color: white; font-weight: bolder;">3</div>
										</c:if>
										<c:if test="${user.me_tr_name == '플래티넘'}">
											<div style="text-align:center; font-size:15px; padding:0; color: white; font-weight: bolder;">4</div>
										</c:if>
										<c:if test="${user.me_tr_name == '다이아'}">
											<div style="text-align:center; font-size:15px; padding:0; color: white; font-weight: bolder;">5</div>
										</c:if>
										<c:if test="${user.me_tr_name == '마스터'}">
											<div style="text-align:center; font-size:15px; padding:0 1 0 0; color: white; font-weight: bolder; line-height: center;">★</div>
										</c:if> 
								</div>
								<div style="margin-left:5px; font-weight: bolder; font-size: 15px; letter-spacing: 1px;">${user.me_tr_name}</div>
								<c:if test="${user.me_tr_name != '스타터'}"> 
									<div style="margin-left:5px; font-weight: bolder; font-size: 10px; letter-spacing: 1px;">${user.me_rating}점</div>	
								</c:if>
							</div>
						</div>
					</div>	
					<div class="myclub-thumb">
						<div style="display: flex; justify-content: space-between;">
							<p style="font-size:large; font-weight: bolder; margin-bottom: 20px;">소속 클럽</p>
							<div class="btn-group">
							    <button type="button" class="club-btn" name="member-tag">회원</button>
							    <button type="button" class="club-btn" name="leader-tag">리더</button>
							    <button type="button" class="club-btn" name="rookie-tag" style="width: 90px;">
							    	승인 대기중</button>
							</div>
						</div>	
						<div class="body-container">
							<div class="memberlist-box">
								<p class="title">‘MEMBER’ 등급인 클럽</p>
								<ul class="memberlist-control">
									<c:forEach items="${memberlist}" var="list">
										<li class="memberlist-link">
											<a href="<c:url value='/club/detail?cl_num=${list.cl_num}'/>">
												<div style="display: flex;">
													<div class="emblem">
														<img alt="엠블럼"
															src="<c:url value='/clubimg${list.cl_emblem }'/>"
															style="width: 60px; height: 60px; border-radius: 50%">
													</div>
													<div style="margin-top: 20px;">
														<span>${list.cl_name }</span> <span>${list.cl_rg_num }</span>
													</div>
												</div>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
							<div class="leaderlist-box">
								<p class="title">‘LEADER’ 등급인 클럽</p>
								<ul class="leaderlist-control">
									<c:forEach items="${leaderlist}" var="list">
										<li class="leaderlist-link">
											<a href="<c:url value='/club/detail?cl_num=${list.cl_num}'/>">
												<div style="display: flex;">
													<div class="emblem">
														<img alt="엠블럼"
															src="<c:url value='/clubimg${list.cl_emblem }'/>"
															style="width: 60px; height: 60px; border-radius: 50%">
													</div>
													<div style="margin-top: 20px;">
														<span>${list.cl_name }</span> <span>${list.cl_rg_num }</span>
													</div>
												</div>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
							<div class="rookielist-box">
								<p class="title">‘ROOKIE’ 등급인 클럽</p>
								<ul class="rookielist-control">
									<c:forEach items="${rookielist}" var="list">
										<li class="rookielist-link">
											<a href="<c:url value='/club/detail?cl_num=${list.cl_num}'/>">
												<div style="display: flex;">
													<div>
														<img alt="엠블럼"
															src="<c:url value='/clubimg${list.cl_emblem }'/>"
															style="width: 60px; height: 60px; border-radius: 50%">
													</div>
													<div style="margin-top: 20px;">
														<span>${list.cl_name }</span> <span>${list.cl_rg_num }</span>
													</div>
												</div>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
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
							<a href="<c:url value='/member/record'/>">
							<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_friend_match.svg" width="24px" height="24px" alt="나의 전적">
							<p>나의 전적</p>
							</a>
						</li>
						<li>
							<a href="<c:url value='/member/search'/>">
							<img src="	https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_friend.svg" width="24px" height="24px" alt="회원 조회">
							<p>회원 찾기</p>
							</a>
						</li>
						<li>
							<a href="<c:url value='/member/friendlist'/>">
							<img src="https://d31wz4d3hgve8q.cloudfront.net/media/ic_nav_team_recruit_guest.svg" width="24px" height="24px" alt="회원 조회">
							<p>즐겨찾기/차단 조회</p>
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
							<a href="<c:url value='/member/pointHistory'/>">
							<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_manner_card.svg" width="24px" height="24px" alt="포인트 환급">
							<p>포인트 내역</p>
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
	<div class="modal">
		<div class="modal-content">
			<div class="match-record-box">
				<button type="button" class="close btn-info-close" data-dismiss="modal">&times;</button><br>
				<p style="font-size: 20px; font-weight: bolder; margin: 0 auto; border-bottom: 8px solid #c2f296;
				width: 20%; padding: 20px 0 10px 0; text-align: center;">티어</p>
				<div class="tier-info-box">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>등급</th>
								<th>점수 범위</th>
								<th>승점 포인트</th>
								<th>실점 포인트</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>스타터</td>
								<td>없음</td>
								<td>200</td>
								<td>0</td>
							</tr>
							<tr>
								<td>브론즈</td>
								<td>0이상 1000미만</td>
								<td>200</td>
								<td>40</td>
							</tr>
							<tr>
								<td>실버</td>
								<td>1000이상 2000미만</td>
								<td>160</td>
								<td>80</td>
							</tr>
							<tr>
								<td>골드</td>
								<td>2000이상 3000미만</td>
								<td>120</td>
								<td>120</td>
							</tr>
							<tr>
								<td>플래티넘</td>
								<td>3000이상 4000미만</td>
								<td>80</td>
								<td>160</td>
							</tr>
							<tr>
								<td>다이아</td>
								<td>4000이상 5000미만</td>
								<td>40</td>
								<td>200</td>
							</tr>
							<tr>
								<td>마스터</td>
								<td>5000(최고점)</td>
								<td>0</td>
								<td>200</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

	$(document).ready(function() {
		getUserInformation()
	});
	
	//유저정보를 가져오는 ajax함수
	function getUserInformation() {
		let num = { me_num : ${user.me_num}}
		ajaxJsonToJson(false, 'post', "/member/information", num,(data)=>{
			$('.point-information').text(data.user.me_point);
			
		});
	}
	
	// 표 전환
	$('.rookielist-box').hide();
	$('.leaderlist-box').hide();
	
	$(document).on('click','[name = member-tag]',function(){
		$('.memberlist-box').show();
		$('.leaderlist-box').hide();
		$('.rookielist-box').hide();
	})
	$(document).on('click','[name=rookie-tag]',function(){
		$('.memberlist-box').hide();
		$('.rookielist-box').show();
		$('.leaderlist-box').hide();
		
	})
	$(document).on('click','[name=leader-tag]',function(){
		$('.memberlist-box').hide();
		$('.rookielist-box').hide();
		$('.leaderlist-box').show();
		
	})
	 $(document).ready(function() {
        $('.btn-info-open').click(function() {
            showModal();
        });

        $('.btn-info-close').click(function() {
            closeModal();
        });

        function showModal() {
            $('.modal').fadeIn();
        }

        function closeModal() {
            $('.modal').fadeOut();
        }
    });
</script>
</html>