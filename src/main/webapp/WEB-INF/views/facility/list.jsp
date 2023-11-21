<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 조회</title>
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
	
	.btn-group{
		margin-bottom:10px;
	}
	.btn2{
		background-color:#c2f296; border:0; 
		color:white;
	}
  .btn2:hover {
        background-color: #28a745; /* 진한 초록색으로 변경 */
    }
    .btn2.active {
        background-color: #28a745; 
    }
</style>
</head>
<body>

<div class="member-search">
	<div class="member-search-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 17%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		시설 조회</p>
	</div>
	<!-- 검색  -->
		<form action="<c:url value='/admin/facilitylist'/>" method="get">
		<div class="facility-navigation" style="margin: 30px 0 30px 0; text-align: center;">
			<select class="searchType" name="t">
				<option value="all" <c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
				<option value="businessman" <c:if test="${pm.cri.t == 'businessman'}">selected</c:if>>사업자번호</option>
				<option value="total" <c:if test="${pm.cri.t == 'total'}">selected</c:if>>시설명 + 주소</option>
				<option value="phone" <c:if test="${pm.cri.t == 'phone'}">selected</c:if>>전화번호</option>
			</select>
			<input type="text" class="keyword" name="s" value="${pm.cri.s}">
			<button class="search-btn">검색</button>
		</div>
	</form>
	
	
		<!-- 시설 출력 -->
	<div class="main">
	    <div class="table available-table">
	    	<ul class="notice-thead">
		      	<li style="width: 8%">사업자 번호</li>
		        <li style="width: 21%">시설명</li>
		        <li style="width: 18%">전화번호</li>
		        <li style="width: 8%">경기장 수</li>
		        <li style="width: 20%">특이사항</li>
		        <li style="width: 13%">상태</li>
		  	</ul>
	    	<ul class="notice-tbody available">
					<c:forEach items="${list}" var="facility" varStatus="vs">
						<c:if test="${facility.fa_deleted == 0 }">
							<li>
								<div class="tbody-box">
									<div class="tbody-list" style="width: 8%">${facility.fa_bu_num}</div>
									<div class="tbody-list" style="width: 21%">
										<a
											href="<c:url value='/facility/detail/${facility.fa_num}'/>"
											style="text-align: left; color: #1179b1f5;">${facility.fa_name}</a>
									</div>
									<div class="tbody-list" style="width: 18%">${facility.fa_phone}</div>
									<div class="tbody-list" style="width: 8%">${facility.st_count}</div>
									<div class="tbody-list" style="width: 20%">${facility.fa_note}</div>
									<div class="tbody-list" style="width: 13%">
										<c:choose>
											<c:when test="${facility.fa_deleted == 0}">이용 중</c:when>
											<c:when test="${facility.fa_deleted == 1}">삭제</c:when>
										</c:choose>
									</div>
								</div>
							</li>
						</c:if>
					</c:forEach>
				</ul>
		 </div>
	  <!-- 페이지네이션 적용 -->
		<ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
			<li class="page-item">
				<a class="page-link" 
					href="<c:url value='/admin/facilitylist${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
			</li>
		</c:if>
		<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
				<a class="page-link" 
					href="<c:url value='/admin/facilitylist${pm.cri.getUrl(i)}'/>">${i}</a>
			</li>
		</c:forEach>
		<c:if test="${pm.next}">
			<li class="page-item">
				<a class="page-link" 
					href="<c:url value='/admin/facilitylist${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
			</li>
		</c:if>
	</ul>
	</div>
</div>

</body>
</html>