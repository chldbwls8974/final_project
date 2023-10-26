<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 게시판</title>
<style>
	.btn-info{
		
	}
</style>
</head>
<body>
<h1>공지게시판</h1>
<button type="button" class="btn btn-outline-info btn-info">공지글 쓰기</button>
<!-- 공지게시판 검색 기능 -->
	<form action="<c:url value='/board/notice'/>" method="get">
	<div class="input-group mb-3 mt-3">
		<div class="input-group-prepend">
		    <select class="form-control select-type" id="me_authority" name="t">
		      <option value="all" 
		      	<c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
		      <option value="second"
		      	<c:if test="${pm.cri.t == 'second'}">selected</c:if>>닉네임</option>
		      <option value="third"
		      	<c:if test="${pm.cri.t == 'third'}">selected</c:if>>제목</option>
	    </div>
	    <input type="text" class="form-control input-search" name="s" id="me_title" placeholder="검색어를 입력하세요." value="${pm.cri.s}">
	    <button class="btn btn-outline-success btn-insert">찾기</button>
	</div>
	</form>
<!-- 공지게시판 출력 -->
<div class="container">
  <table class="table table-hover">
    <thead>
      <tr>
      	<th>게시글번호</th>
      	<th>제목</th>
        <th>작성자 닉네임</th>
        <th>작성일</th>
        <th>조회수</th>
        <th>댓글수</th>
      </tr>
    </thead>
    <tbody>
   	 <c:forEach items="${list}" var="bo">
	      <tr>
	      	<td>${bo.bo_num}</td>
	      	<td><a href="#">${bo.bo_title}</a></td>
	        <td>${bo.me_nickname}</td>
	        <td>${bo.bo_reg_date}</td>
	        <td>${bo.bo_count}</td>
	        <td>${bo.bo_comment}</td>
	      </tr>
      </c:forEach>
    </tbody>
  </table>
  <!-- 페이지네이션 적용 -->
  <ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
			<li class="page-item">
				<a class="page-link" 
					href="<c:url value='/board/notice${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
			</li>
		</c:if>
		<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
				<a class="page-link" 
					href="<c:url value='/board/notice${pm.cri.getUrl(i)}'/>">${i}</a>
			</li>
		</c:forEach>
		<c:if test="${pm.next}">
			<li class="page-item">
				<a class="page-link" 
					href="<c:url value='/board/notice${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
			</li>
		</c:if>
	</ul>
 </div>
 <script type="text/javascript">

 </script>
</body>
</html>