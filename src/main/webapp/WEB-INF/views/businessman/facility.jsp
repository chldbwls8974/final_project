<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 리스트</title>
</head>
<body>
  	<h1>시설 리스트</h1>
  	  <div class="table-responsive">
	    <table class="table table-bordered">
	      <thead>
	        <tr>
	          <th>시설 번호</th>
	          <th>사업자 번호</th>
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
		        <tr>
		          <td><a href="<c:url value='/businessman/stadium/${facility.fa_num}'/>">${facility.fa_num}</a></td>
		          <td>${facility.fa_bu_num}</td>
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
							class="btn btn-outline-secondary" role="button">수정</a></td>
			      <td>
					<form action="<c:url value='/businessman/facilityDelete'/>" method="post">
						<button class="btn btn-outline-dark btn-businessman-facilityDelete">삭제</button>
						<input type="hidden" name="fa_num" value="${facility.fa_num}">
					</form>
				  </td>
	         	</tr>
		     </c:forEach>
	      </tbody>
	    </table>
	  </div>
	  
		<div align="right" class="mt-3">
			<a class="btn btn-float-right btn btn-primary mt-1 col-3 "
				 role="button" href="<c:url value='/businessman/facilityInsert'/>">시설 등록하기</a>
		</div>
	    <div align="right" class="mt-3">
			<a class="btn btn-float-left btn btn-danger mt-1 col-3 "
				role="button" href="<c:url value='/'/>">뒤로가기</a>
		</div>
</body>
</html>