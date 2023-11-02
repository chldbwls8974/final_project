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
	<br>
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
	        </tr>
	      </thead>
		  <tbody>
	      	<c:forEach items="${list}" var="facility">
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
	         	</tr>
		     </c:forEach>
	      </tbody>
	    </table>
	  </div>
	  
		<div align="right" class="mt-3">
			<a class="btn btn-secondary btn-block" role="button" href="<c:url value='/businessman/facilityInsert'/>">시설 등록하기</a>
		</div>

</body>
</html>