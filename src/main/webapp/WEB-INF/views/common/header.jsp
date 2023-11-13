<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>
<style type="text/css">
	
	.navbar{ background-color: black; height: 100px;}
	.navbar-brand{ font-weight: bolder; color: white; padding: 10px;}
	.navbar-nav a{color: white; font-size: 15px; margin-right: 20px;}
	.navbar-nav a:hover {color: white;}
	.dropdown-menu a{background-color: black; color: white;}
	
</style>
</head>
<body>
	<nav class="navbar navbar-expand-sm">
		<a class="navbar-brand" href="/final_project">LOGO</a>
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="<c:url value='/club/make'/>">클럽만들기</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value='/club/list'/>">클럽조회</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">개인매치</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">클럽매치</a>
			<li class="nav-item">
				<a class="nav-link" href="#">시설 조회</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value='/admin/price'/>">가격수정</a>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
				커뮤니티
				</a>
				<div class="dropdown-menu">
					<c:if test="${user != null && user.me_authority == 'ADMIN'}">
						<a class="dropdown-item" 
						   href="<c:url value='/board/notice'/>">공지게시판</a>
					</c:if>	
						<a class="dropdown-item" href="<c:url value='/board/free'/>">자유게시판</a>
						<a class="dropdown-item" href="<c:url value='/board/individual'/>">개인 매칭</a>
						<a class="dropdown-item" href="<c:url value='/board/club'/>">클럽 매칭</a>
						<a class="dropdown-item" href="<c:url value='/board/inquiry'/>">문의게시판</a>
					<c:if test="${user != null && user.me_authority == 'ADMIN'}">
						<a class="dropdown-item" href="/board/block">게시판 관리</a>
					</c:if>
				</div>
			</li>
			<c:if test="${user != null && user.me_authority == 'ADMIN'}">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
					관리자
					</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="<c:url value='/admin/member'/>">회원 관리</a>
						<a class="dropdown-item" href="<c:url value='/admin/manager'/>">매니저 관리</a>
						<a class="dropdown-item" href="<c:url value='/admin/business'/>">사업자 관리</a>
						<a class="dropdown-item" href="<c:url value='/admin/refund'/>">포인트 환급 관리</a>
						<a class="dropdown-item" href="<c:url value='/admin/boardReport'/>">신고 관리</a>
					</div>
				</li>
			</c:if>
			<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
					매니저
					</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="<c:url value='/manager/select/match'/>">매치 신청</a>
						<a class="dropdown-item" href="<c:url value='/manager/manage/schedule'/>">일정 관리</a>
					</div>
			</li>
			<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
					사업자
					</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="<c:url value='/businessman/facilityInsert'/>">시설 등록</a>
						<a class="dropdown-item" href="<c:url value='/businessman/facility'/>">시설 관리</a>
						<a class="dropdown-item" href="<c:url value='/buisnessman/manage/schedule'/>">스케줄 관리</a>
						<a class="dropdown-item" href="#">일정 관리</a>
					</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
				신청하기
				</a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="<c:url value='/application/manager'/>">매니저 신청</a>
					<a class="dropdown-item" href="<c:url value='/application/businessman'/>">사업자 신청</a>
				</div>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value='/member/mypage'/>">마이페이지</a>
			</li>
			<li class="nav-item">
				<a class="nav-link " href="<c:url value='/member/signup'/>">회원가입</a>
			</li>
			<li class="nav-item">
				<a class="nav-link " href="<c:url value='/member/login'/>">로그인</a>
			</li>
			<li class="nav-item">
				<a class="nav-link " href="<c:url value='/member/logout'/>">로그아웃</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="email-signout" href="<c:url value='/member/signout'/>">회원탈퇴</a>
			</li>
		</ul>	
	</nav>
	
	<script type="text/javascript">
		//member 정보를 불러와서 변수에 저장(서버에서 JSP로 넘어오는 멤버 정보)
		var member = "${member}";
		//각각의 url을 변수로 저장
		<c:url value="/kakao/signout" var="kakaoSignoutUrl" />
		<c:url value="/member/signout" var="emailSignoutUrl" />
		
		// 이메일인증 회원인지 확인
		$('#email-signout').click(function () {		
		    // 아이디 형식에 맞으면 카카오인증 탈퇴페이지로 이동 or 이메일인증 탈퇴페이지로 이동
		    if (member != null && member.me_id != null && member.me_id.match(/^\\d+.*k$/)) {
		        // 카카오인증 회원의 탈퇴페이지로 이동
		        alert("카카오인증 회원탈퇴 페이지로 이동됩니다");
	            location.href = '${kakaoSignoutUrl}';
		    } else {
		        // 이메일 인증 회원의 탈퇴페이지로 이동
		        alert("이메일인증 회원탈퇴 페이지로 이동됩니다.");
	            location.href = '${emailSignoutUrl}';
		    }
		});
	</script>
	
</body>
</html>
