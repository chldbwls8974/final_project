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
  	<p>현재 등록되어 있는 시설 리스트 입니다.</p>
	  <div class="table-responsive">
	    <table class="table table-bordered">
	      <thead>
	        <tr>
	          <th>시설 번호</th>
	          <th>사업자 번호</th>
	          <th>지역 번호</th>
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
	        </tr>
	      </thead>
		  <tbody>
	      	<c:forEach items="${list}" var="facility">
		        <tr>
		          <td>${facility.fa_num}</td>
		          <td><a href="">${facility.fa_bu_num}</a></td>
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
	         	 </tr>
		     </c:forEach>
	      </tbody>
	    </table>
	    <div>
			<c:if test="${pm.prev}">
				<a href="<c:url value='/board/list${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
			</c:if>
			<c:forEach begin="${pm.startPage }" end="${pm.endPage}" var="i">
				<a href="<c:url value='/board/list${pm.cri.getUrl(i) }'/>">${i}</a>
			</c:forEach>
			<c:if test="${pm.next}">
				<a href="<c:url value='/board/list${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
			</c:if>
		</div>
	  </div>
		
	    <div align="right" class="mt-3">
			<a class="btn btn-float-right btn-outline-dark mt-1 col-3 "
				href="/main/home" role="button">뒤로가기</a>
		</div>
		
		<div align="right" class="mt-3">
			<a class="btn btn-float-right btn-outline-dark mt-1 col-3 "
				href="/businessman/facilityInsert" role="button">시설 등록하기</a>
		</div>

</body>
</html>