<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 목록</title>
</head>
<body>
  	<h1 class="display-3"><span style="color: black; font-weight: bold;">시설 목록</span></h1>
	<br>
	<form action="<c:url value='/businessman/facility'/>" method="get">
		<div class="input-group mb-3">
			<select class="form-control" name="t">
				<option value="all" <c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
				<option value="total" <c:if test="${pm.cri.t == 'total'}">selected</c:if>>시설명 + 주소</option>
				<option value="phone" <c:if test="${pm.cri.t == 'phone'}">selected</c:if>>전화번호</option>
			</select>
			<input type="text" class="form-control" name="s" value="${pm.cri.s}">
			<button class="btn btn-outline-dark">검색</button>
		</div>
	</form>
  	
  	<h5 style="color:blue;">[시설번호] 클릭 시, 경기장 목록으로 이동됩니다.</h5>
  	  <div class="table-responsive">
	    <table class="table table-light table-striped">
	      <thead>
	        <tr class="table-Info">
	          <th>시설 번호</th>
	          <th hidden="hidden">사업자 번호</th>
	          <th>지역</th>
	          <th>시설명</th>
	          <th>주소</th>
	          <th>상세주소</th>
	          <th>전화번호</th>
	          <th>주차장</th>
	          <th>탈의실</th>
	          <th>화장실</th>
	          <th>샤워실</th>
	          <th>흡연장</th>
	          <th>자판기</th>
	          <th>특이사항</th>
	          <th>수정</th>
	          <th>삭제</th>
	        </tr>
	      </thead>
		  <tbody>
	      	<c:forEach items="${list}" var="facility">
	      		<c:if test="${facility.fa_deleted != 1}">
			        <tr>
			          <td><a href="<c:url value='/businessman/stadium/${facility.fa_num}'/>">${facility.fa_num}</a></td>
			          <td hidden="hidden">${facility.fa_bu_num}</td>
			          <td>${facility.fa_rg_num}</td>
			          <td>${facility.fa_name}</td>
			          <td>${facility.fa_add}</td>
			          <td>${facility.fa_add_detail}</td>
			          <td>${facility.fa_phone}</td>
			          <td>${facility.fa_pay}</td>
			          <td>${facility.fa_locker}</td>
			          <td>${facility.fa_toilet}</td>
			          <td>${facility.fa_shower}</td>
			          <td>${facility.fa_smoking}</td>
			          <td>${facility.fa_machine}</td>
			          <td>${facility.fa_note}</td>
			          <td><a href="<c:url value='/businessman/facilityUpdate?fa_num=${facility.fa_num}'/>"
								class="btn btn-dark" role="button">수정</a></td>
					  <td><a href="<c:url value='/businessman/facilityDelete?fa_num=${facility.fa_num}'/>"
						    	class="btn btn-danger" role="button">삭제</a></td>
		         	</tr>
	         	</c:if>
		     </c:forEach>
	       </tbody>
	     </table>
	   </div>
	   <ul class="pagination justify-content-center">
			<c:if test="${pm.prev}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/businessman/facility${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
				<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
					<a class="page-link" 
						href="<c:url value='/businessman/facility${pm.cri.getUrl(i)}'/>">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pm.next}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/businessman/facility${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
				</li>
			</c:if>
	   </ul>
	   <div align="right" class="mt-3">
		   <a class="btn btn-secondary btn-block" role="button" href="<c:url value='/businessman/facilityInsert'/>">시설 등록하기</a>
	   </div>

</body>
</html>