<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<!-- Brand/logo -->
		<a class="navbar-brand" href="#">LOGO</a>
		<ul class="navbar-nav">
			<!-- <c:if test="${user == null}"> -->
				<li class="nav-item">
					<a class="nav-link " href="#">회원가입</a>
				</li>
				<li class="nav-item">
					<a class="nav-link " href="#">로그인</a>
				</li>
			<!-- </c:if> -->
			<!-- <c:if test="${user != null}" -->
				<li class="nav-item">
					<a class="nav-link " href="#">로그아웃</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">마이페이지</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">커뮤니티 게시판</a>
				</li>
			<!-- </c:if> -->
				<li class="nav-item">
					<a class="nav-link" href="#">개인매치</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">클럽매치</a>
				<li class="nav-item">
					<a class="nav-link" href="#">시설 조회</a>
				</li>
				</li>
			<!-- <c:if test="${user != null && user.me_authority == 'ADMIN'}"> -->
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
					관리자
					</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">회원 관리</a>
						<a class="dropdown-item" href="#">매니저 관리</a>
						<a class="dropdown-item" href="#">사업자 관리</a>
						<a class="dropdown-item" href="#">게시판 관리</a>
					</div>
				</li>
			<!-- </c:if> -->
			<!-- <c:if test="${user != null && user.me_authority == 'MANAGER'}"> -->
			<li class="nav-item">
					<a class="nav-link" href="#">매니저</a>
			</li>
			<!-- </c:if> -->
			<!-- <c:if test="${user != null && user.me_authority == 'BUSINESS'}"> -->
			<li class="nav-item">
					<a class="nav-link" href="#">사업자</a>
			</li>
			<!-- </c:if> -->
		</ul>
	</nav>
</body>
</html>