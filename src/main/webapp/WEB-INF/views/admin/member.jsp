<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원조회 검색</title>
<style type="text/css">
	.searchType {
		width: 150px;
		padding: .8em .5em;
		border: 1px solid #999;
		font-family: inherit;
		background: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F99761B495C84AA8716') no-repeat 95% 50%;
		border-radius: 5px;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		margin-top: 20px;
	}
	.keyword{
		width: 500px;
		padding: .8em .5em;
		border-radius: 5px;
		border: 1px solid #999;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
	.search-btn{
		width: 80px;
		padding: .8em .5em;
		border-radius: 5px;
		border: 1px solid #999;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
	.main{
		padding: 40px; height: auto;
		background-color: #f2f2f2; border-radius: 20px;
	}
	.a{
		color : red;
	}
	.notice-thead{
		display: flex; padding: 20px; te
		border-bottom: 1px solid rgba(0,0,0,.1);
	}
 	.notice-tbody{ padding: 5px;}
	.tbody-box{ 
		display: flex; border-bottom: 1px solid rgba(0,0,0,.1);
		margin: 0; padding: 20px 20px 30px 20px;
	}
	.page-link {
	  color: #000; 
	  background-color: #fff;
	  border: 1px solid #ccc; 
	}
	.page-item.active .page-link {
	 z-index: 1;
	 color: #555;
	 background-color: #f1f1f1;
	 border-color: #ccc;
	 
	}
	.page-link:focus, .page-link:hover {
	  color: #000;
	  background-color: #fafafa; 
	  border-color: #ccc;
	}

</style>
</head>
<body>
<div class="member-search">
	<div class="member-search-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 17%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		회원 조회</p>
	</div>
	<!-- 회원검색 기능 -->
	<form action="<c:url value='/admin/member'/>" method="get">
		<div class="member-search-navigation" style="margin: 30px 0 30px 0; text-align: center;">
		    <select class="searchType" id="me_authority" name="t">
		      <option value="all" 
		      	<c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
		      <option value="second"
		      	<c:if test="${pm.cri.t == 'second'}">selected</c:if>>닉네임</option>
		      <option value="third"
		      	<c:if test="${pm.cri.t == 'third'}">selected</c:if>>아이디</option>
		      <option value="fourth"
		      	<c:if test="${pm.cri.t == 'fourth'}">selected</c:if>>권한</option>
		      <option value="fifth"
		      	<c:if test="${pm.cri.t == 'fifth'}">selected</c:if>>이용상태</option>
		    </select>
		    <input type="search" class="keyword" name="s" id="me_title" placeholder="검색할 회원을 입력하세요." value="${pm.cri.s}">
		    <button type="submit" class="search-btn">찾기</button>
	    </div>
	</form>
	<!-- 회원정보 출력 -->
	<div class="main">
	    <div class="table">
	    	<ul class="notice-thead">
		      	<li style="width: 8%">회원번호</li>
		        <li style="width: 21%">회원아이디</li>
		        <li style="width: 11%">닉네임</li>
		        <li style="width: 18%">이메일</li>
		        <li style="width: 10%">티어</li>
		        <li style="width: 15%">권한</li>
		        <li style="width: 12%">매치 정지상태</li>
		        <li style="width: 13%">커뮤니티 정지상태</li>
		  	</ul>
	    	<ul class="notice-tbody">
		   	 <c:forEach items="${list}" var="member" varStatus="vs">
			     <li>
					<div class="tbody-box">
				      	<div class="tbody-list" style="width: 8%">${member.me_num}</div>
				        <div class="tbody-list" style="width: 21%">${member.me_id}</div>
				        <div class="tbody-list" style="width: 11%">${member.me_nickname}</div>
				        <div class="tbody-list" style="width: 18%">${member.me_email}</div>
				        <div class="tbody-list" style="width: 10%">${member.me_tr_name}</div>
				        <div class="tbody-list" style="width: 15%">${member.me_authority}</div>
				        <div class="tbody-list" style="width: 13%">
				        	<c:choose>
				        		<c:when test="${member.me_state1 == 0}">클린</c:when>
				        		<c:when test="${member.me_state1 == 1}">정지</c:when>
				        	</c:choose>
				        </div>
				        <div class="tbody-list" style="width: 12%">
				        	<c:choose>
				        		<c:when test="${member.me_state2 == 0}">클린</c:when>
				        		<c:when test="${member.me_state2 == 1}">정지</c:when>
				        	</c:choose>
				        </div>
				    </div>
				  </li>
		      </c:forEach>
		    </ul>
		 </div>
	  <!-- 페이지네이션 적용 -->
	  <ul class="pagination justify-content-center">
			<c:if test="${pm.prev}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/admin/member${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
				<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
					<a class="page-link" 
						href="<c:url value='/admin/member${pm.cri.getUrl(i)}'/>">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pm.next}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/admin/member${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
</body>
</html>