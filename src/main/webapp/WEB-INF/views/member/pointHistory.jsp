<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트 내역</title>
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
<div>
	<div style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 17%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		포인트 내역 조회</p>
	</div>
	<!-- 회원검색 기능 -->
	<form action="<c:url value='/member/pointHistory'/>" method="get">
		<div style="margin: 30px 0 30px 0; text-align: center;">
		    <select class="searchType" name="t">
		      <option value="all" 
		      	<c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체 기간</option>
		      <option value="second"
		      	<c:if test="${pm.cri.t == 'second'}">selected</c:if>>1개월</option>
		      <option value="third"
		      	<c:if test="${pm.cri.t == 'third'}">selected</c:if>>3개월</option>
		      <option value="fourth"
		      	<c:if test="${pm.cri.t == 'fourth'}">selected</c:if>>6개월</option>
		      <option value="fifth"
		      	<c:if test="${pm.cri.t == 'fifth'}">selected</c:if>>1년</option>
		    </select>
		    <select class="searchType" name="s">
		      <option value="all" 
		      	<c:if test="${pm.cri.s == 'all'}">selected</c:if>>분류</option>
		      <option value="second"
		      	<c:if test="${pm.cri.s == 'second'}">selected</c:if>>포인트 획득</option>
		      <option value="third"
		      	<c:if test="${pm.cri.s == 'third'}">selected</c:if>>포인트 차감</option>
		    </select>
		    <button type="submit" class="search-btn">조회</button>
	    </div>
	</form>
	<!-- 회원정보 출력 -->
	<div class="main">
	    <div class="table">
	    	<ul class="notice-thead">
		      	<li style="width: 33%">금액</li>
		        <li style="width: 33%">용도</li>
		        <li style="width: 33%">날짜</li>
		  	</ul>
	    	<ul class="notice-tbody">
		   	 <c:forEach items="${list}" var="item" varStatus="vs">
			     <li>
					<div class="tbody-box">
				        <div class="tbody-list" style="width: 33%">${item.ph_price}</div>
				        <c:if test="${item.ph_source == 0}">
					        <div class="tbody-list" style="width: 33%">포인트 충전</div>
				        </c:if>
				        <c:if test="${item.ph_source == 1}">
					        <div class="tbody-list" style="width: 33%">매치 신청</div>
				        </c:if>
				        <c:if test="${item.ph_source == 2}">
					        <div class="tbody-list" style="width: 33%">매치 취소</div>
				        </c:if>
				        <c:if test="${item.ph_source == 3}">
					        <div class="tbody-list" style="width: 33%">매치 취소</div>
				        </c:if>
				        <c:if test="${item.ph_source == 4}">
					        <div class="tbody-list" style="width: 33%">환급 대기</div>
				        </c:if>
				        <c:if test="${item.ph_source == 5}">
					        <div class="tbody-list" style="width: 33%">환급 완료</div>
				        </c:if>
				        <div class="tbody-list" style="width: 33%">
                        	<fmt:formatDate value="${item.ph_date}" pattern="yyyy년 MM월 dd일"/>
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
						href="<c:url value='/member/pointHistory${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
				<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
					<a class="page-link" 
						href="<c:url value='/member/pointHistory${pm.cri.getUrl(i)}'/>">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pm.next}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/member/pointHistory${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
</body>
</html>