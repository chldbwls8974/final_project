<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>
</head>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a class="navbar-brand" href="#">LOGO</a>
		<ul class="navbar-nav">
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
					<a class="nav-link" href="<c:url value='/member/mypage'/>">마이페이지</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">커뮤니티 게시판</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">개인매치</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">클럽매치</a>
				<li class="nav-item">
					<a class="nav-link" href="#">시설 조회</a>
				</li>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
					관리자
					</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="<c:url value='/admin/member'/>">회원 관리</a>
						<a class="dropdown-item" href="#">매니저 관리</a>
						<a class="dropdown-item" href="#">사업자 관리</a>
						<a class="dropdown-item" href="#">게시판 관리</a>
					</div>
				</li>
			<li class="nav-item">
					<a class="nav-link" href="#">매니저</a>
			</li>
			<li class="nav-item">
					<a class="nav-link" href="#">사업자</a>
			</li>
			<li class="nav-item">
					<a class="nav-link" href="<c:url value='/application/manager'/>">매니저 신청</a>
			</li>
			<li class="nav-item">
					<a class="nav-link" href="<c:url value='/application/businessman'/>">사업자 신청</a>
			</li>
		</ul>
	</nav>
</body>
</html>