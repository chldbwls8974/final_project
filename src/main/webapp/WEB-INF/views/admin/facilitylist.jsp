<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 조회</title>
<style type="text/css">

	.btn-info{
		color : outline-info;
		border : 2px solid yellow;
	}
	.btn-info:hover{
		background-color : outline-info;
		color : white;
	}

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
		display: flex; padding: 0 0 16px 0;
		border-bottom: 1px solid rgba(0,0,0,.1);
	}
 	.select-manager{padding: 5px;}
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
	<div class="facility-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 18%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		시설 목록</p>
	</div>
	
		<form action="<c:url value='/admin/facilitylist'/>" method="get">
		<div class="facility-navigation" style="margin: 30px 0 30px 0; text-align: center;">
			<select class="searchType" name="t">
				<option value="all" <c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
				<option value="total" <c:if test="${pm.cri.t == 'total'}">selected</c:if>>시설명 + 주소</option>
				<option value="phone" <c:if test="${pm.cri.t == 'phone'}">selected</c:if>>전화번호</option>
			</select>
			<input type="text" class="keyword" name="s" value="${pm.cri.s}">
			<button class="search-btn">검색</button>
		</div>
	</form>
  	
  	<div class="table-responsive">
		<table class="table">
	      <thead class="thead-dark">
	        <tr>
	          <th hidden="hidden">시설 번호</th>
	          <th>사업자 번호</th>
	          <th hidden="hidden">지역</th>
	          <th>시설명</th>
	          <th>주소</th>
	          <th>상세주소</th>
	          <th>전화번호</th>
	          <th>경기장 수</th>
	          <th>특이사항</th>
	          <th>상태</th>
	          <th>운영시간</th>
	          <th>수정</th>
	          <th>삭제</th>
	        </tr>
	      </thead>
		  <tbody>
	      	<c:forEach items="${list}" var="facility">
			        <tr>
			          <td hidden="hidden">${facility.fa_num}</td>
			          <td>${facility.fa_bu_num}</td>
			          <td hidden="hidden">${facility.fa_rg_num}</td>
			          <td><a href="<c:url value='/admin/stadiumlist/${facility.fa_num}'/>"
			          style="text-align: left; color: #1179b1f5;">${facility.fa_name}</a></td>
			          <td>${facility.fa_add}</td>
			          <td>${facility.fa_add_detail}</td>
			          <td>${facility.fa_phone}</td>
			          <td>${facility.st_count}</td>
			          <td>${facility.fa_note}</td>
			          <td>
			            <c:choose>
			                <c:when test="${facility.fa_deleted == 0}">이용 중</c:when>
			                <c:when test="${facility.fa_deleted == 1}">삭제</c:when>
			            </c:choose>
			          </td>
			       	  <td><a href="<c:url value='/admin/operatinglist/${facility.fa_num}'/>"
								class="btn btn-outline-info" role="button">운영시간</a></td>
			          <td><a href="<c:url value='/admin/facilitylistUpdate?fa_num=${facility.fa_num}'/>"
								class="btn btn-outline-secondary" role="button">수정</a></td>
					  <td><a href="<c:url value='/businessman/facilityDelete?fa_num=${facility.fa_num}'/>"
						    	class="btn btn-outline-secondary" role="button">삭제</a></td>
		           </tr>
		    </c:forEach>
	     </tbody>
	   </table>
	</div>
	
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


</body>
</html>