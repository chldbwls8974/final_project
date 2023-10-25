<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원조회 검색</title>
</head>
<body>
<!-- 회원검색 기능 -->
	<form action="<c:url value='/admin/member'/>" method="get">
	<div class="input-group mb-3 mt-3">
		<div class="input-group-prepend">
		    <select class="form-control select-type" id="me_authority" name="t">
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
	    </div>
	    <input type="text" class="form-control input-search" name="s" id="me_title" placeholder="검색어를 입력하세요." value="${pm.cri.s}">
	    <button class="btn btn-outline-success btn-insert">찾기</button>
	</div>
	</form>
<!-- 회원정보 출력 -->
<div class="container">
  <table class="table table-hover">
    <thead>
      <tr>
      	<th>회원번호</th>
        <th>회원아이디</th>
        <th>닉네임</th>
        <th>이메일</th>
        <th>티어</th>
        <th>권한</th>
        <th>매치 정지상태</th>
        <th>커뮤니티 정지상태</th>
      </tr>
    </thead>
    <tbody>
   	 <c:forEach items="${list}" var="member" varStatus="vs">
	      <tr>
	      	<td>${pm.totalCount - vs.index}</td>
	        <td>${member.me_id}</td>
	        <td>${member.me_nickname}</td>
	        <td>${member.me_email}</td>
	        <td>${member.me_tr_name}</td>
	        <td>${member.me_authority}</td>
	        <td>
	        	<c:choose>
	        		<c:when test="${member.me_state1 == 0}">클린</c:when>
	        		<c:when test="${member.me_state1 == 1}">정지</c:when>
	        	</c:choose>
	        </td>
	        <td>
	        	<c:choose>
	        		<c:when test="${member.me_state2 == 0}">클린</c:when>
	        		<c:when test="${member.me_state2 == 1}">정지</c:when>
	        	</c:choose>
	        </td>
	        <td></td>
	      </tr>
      </c:forEach>
    </tbody>
  </table>
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
 <script type="text/javascript">
 	$(document).on('change', '.select-type', function() {
		if($(this).val() == 'fifth'){
			$('.input-search').prop('placeholder', '일반회원 검색 : 0, 정지회원 검색 : 1');
		}else{
			$('.input-search').prop('placeholder', '검색어를 입력하세요.');			
		}
	});
 </script>
</body>
</html>