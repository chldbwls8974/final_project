<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기장 목록</title>
</head>
<style type="text/css">
	.btn:hover{
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
	
	.title-detail{ margin: 50px auto; background-color: #f2f2f2; border-radius: 30px;
	padding: 30px; width: 42%;}

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
<body>
	<div class="stadium-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 38%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		[${facility.fa_name}] 경기장 목록</p>
	</div>
	
	<form action="<c:url value='/businessman/stadium/${facility.fa_num}'/>" method="get">
		<div class="stadium-navigation" style="margin: 30px 0 30px 0; text-align: center;">
			<select class="searchType" name="t">
				<option value="all" <c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
				<option value="name" <c:if test="${pm.cri.t == 'name'}">selected</c:if>>경기장 이름</option>
				<option value="locate" <c:if test="${pm.cri.t == 'locate'}">selected</c:if>>경기장 위치</option>
			</select>
			<input type="text" class="keyword" name="s" value="${pm.cri.s}">
			<button class="search-btn">검색</button>
		</div>
	</form>
	
	<div style="text-align: left; margin-right: 10px;">
		<div class="btn-group btn-group">	    
				<a class="btn" role="button" 
				 style="
						border-radius: 10px; width: 130px; height: 40px; border: none;
						background-color: #c2f296; color: black; margin: 10px 10px 10px 0;"
						href="<c:url value='/businessman/stadiumInsert/${facility.fa_num}'/>"
						>경기장 등록하기</a>		
				<a class="btn" role="button" 
				 style="
						border-radius: 10px; width: 150px; height: 40px; border: none;
						background-color: #c2f296; color: black; margin: 10px 10px 10px 0;"
						href="<c:url value='/businessman/facility'/>"
						>시설 목록으로 이동</a>		
		</div>
	</div>		
	
	
	<div class="table-responsive" style="color: green;">
	  	<input type = "text" class="form-control" hidden="hidden" value="${stadium}">
	    <table class="table">
	      <thead class="thead-dark">
	        <tr class="table-Info">
	          <th hidden="hidden">경기장 번호</th>
	          <th>이름</th>
	          <th>위치</th>
	          <th>실내/외</th>
	          <th>바닥종류</th>
	          <th>가로</th>
	          <th>세로</th>
	          <th>최대인원</th>
	          <th>이용가능여부</th>
	          <th>특이사항</th>
	          <th hidden="hidden">시설번호</th>
	          <th>수정</th>
	        </tr>
	      </thead>
		  <tbody>
	      	<c:forEach items="${stadiumList}" var="stadium">
		      	<!-- st_available 값이 '2(삭제)'아닌것만 화면에 보이게 함 -->
		      	<c:if test="${stadium.st_available != 2}">
			        <tr>
			          <td hidden="hidden">${stadium.st_num}</td>
			          <td>${stadium.st_name}</td>
			          <td>${stadium.st_locate}</td>
			          <td>
			            <c:choose>
			                <c:when test="${stadium.st_door == 0}">실외</c:when>
			                <c:when test="${stadium.st_door == 1}">실내</c:when>
			            </c:choose>
				      </td>
			          <td>
			            <c:choose>
			                <c:when test="${stadium.st_floortype == 0}">인조잔디</c:when>
			                <c:when test="${stadium.st_floortype == 1}">천연잔디</c:when>
			                <c:when test="${stadium.st_floortype == 2}">모래</c:when>
			                <c:when test="${stadium.st_floortype == 3}">인도어</c:when>
			            </c:choose>
				      </td>
			          <td>${stadium.st_width}m</td>
			          <td>${stadium.st_height}m</td>
			          <td>${stadium.st_max}명</td>
			          <td>
			            <c:choose>
			                <c:when test="${stadium.st_available == 0}">가능</c:when>
			                <c:when test="${stadium.st_available == 1}">불가능</c:when>
			            </c:choose>
				      </td>
			          <td>${stadium.st_note}</td>
			          <td hidden="hidden">${stadium.st_fa_num}</td>
			          <td><a href="<c:url value='/businessman/stadiumUpdate?st_num=${stadium.st_num}'/>"
								class="btn btn-outline-secondary" role="button">수정</a></td>
		         	 </tr>
    	         </c:if>
		     </c:forEach>
	      </tbody>
	    </table>
	    
	    <ul class="pagination justify-content-center">
			<c:if test="${pm.prev}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/businessman/stadium/${facility.fa_num}${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
				<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
					<a class="page-link" 
						href="<c:url value='/businessman/stadium/${facility.fa_num}${pm.cri.getUrl(i)}'/>">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pm.next}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/businessman/stadium/${facility.fa_num}${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
				</li>
			</c:if>
	    </ul>
	</div>

</body>
</html>