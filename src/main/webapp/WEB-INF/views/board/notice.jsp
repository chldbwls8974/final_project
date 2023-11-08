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
		color : outline-info;
		background-color : white;
		border : 1px solid outline-info;
	}
	.btn-info:hover{
		background-color : outline-info;
		color : white;
	}
	h1{
		text-align : center;
	}
	.a{
		color : red;
	}
	.notice-thead{
		display: flex; justify-content: space-between; padding: 0 0 16px 0;
		border-bottom: 1px solid rgba(0,0,0,.1);
	}
/* 	.notice-tbody{ justify-content: space-between;} */
	
	.tbody-list{display: flex; justify-content: space-between;}
	
</style>
</head>
<body>
<br>
<h1> &#x1F525 공지게시판 &#x1F525;</h1>
	<div style="display:flex; justify-content: flex-end;">
		<button type="button"
			    class="btn btn-outline-info btn-info"
				onclick="location.href='<c:url value='/board/insert'/>'">공지글 쓰기
		</button>
	</div>	
<!-- 공지게시판 검색 기능 -->
	<form action="<c:url value='/board/notice'/>" method="get">
	<div class="input-group mb-3 mt-3">
		<div class="input-group-prepend">
		    <select class="form-control" id="me_authority" name="t">
		      <option value="all" 
		      	<c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
	 		  <option value="first"
		      	<c:if test="${pm.cri.t == 'first'}">selected</c:if>>게시글번호</option>
		      <option value="second"
		      	<c:if test="${pm.cri.t == 'second'}">selected</c:if>>닉네임</option>
		      <option value="third"
		      	<c:if test="${pm.cri.t == 'third'}">selected</c:if>>제목</option>
		      <option value="fourth"
		      	<c:if test="${pm.cri.t == 'fourth'}">selected</c:if>>작성날짜</option>
	   		</select>
	    </div>
	    <input type="text" class="form-control input-search" name="s" id="me_title" placeholder="검색어를 입력하세요." value="${pm.cri.s}">
	    <button class="btn btn-outline-success btn-insert">찾기</button>
	</div>
	</form>
<!-- 공지게시판 출력 -->
<br>
<div class="container">
  <div class="table">
    <ul class="notice-thead">
		<li>게시글번호</li>
		<li>제목</li>
		<li>작성자 닉네임</li>
		<li>작성일</li>
		<li>조회수</li>
		<li>댓글수</li>
    </ul>
    <div style="display: inline-block;">
	    <ul class="notice-tbody">
	   	 <c:forEach items="${list}" var="bo" >
			<li>
				<div class="tbody-list">${bo.bo_num}</div>
			</li>
			<li>
				<div class="tbody-list"><a href="<c:url value='/board/detail?bo_num=${bo.bo_num}'/>" 
						style="color:red">${bo.bo_title}</a></div>
			</li>
			<li>
				<div class="tbody-list">${bo.me_nickname}</div>
			</li>
			<li>
				<div class="tbody-list">${bo.bo_reg_date_str}</div>
			</li>
			<li>
				<div class="tbody-list">${bo.bo_count}</div>
			</li>
			<li>
				<div class="tbody-list"><a href="<c:url value='/board/detail?bo_num=${bo.bo_num}'/>">
					${bo.bo_comment}</a></div>
	    	</li>
	      </c:forEach>
	    </ul>
    </div>
  </div>
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
 	/* $(document).on('click', '.btn-info', function(){
 		var url = '<c:url value="/board/insert"/>';
 		
 		window.location.href = url;
 	}); */
 </script>
</body>
</html>