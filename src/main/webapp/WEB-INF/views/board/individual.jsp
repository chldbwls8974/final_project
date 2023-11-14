<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인매치 게시판</title>
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
	/* 공지글 부분 */
	.notionBoard{
		background-color : #B0B0B0
	}
	

</style>
</head>
<body>
<br>
<h1>  &#x1F388 개인매치 게시판  &#x1F388;</h1>
	<div style="display:flex; justify-content: flex-end;">
		<button type="button"
			    class="btn btn-outline-info btn-info btn-individual"
				>글쓰기
		</button>
	</div>	
<!-- 개인매치 게시판 검색 기능 -->
	<form action="<c:url value='/board/individual'/>" method="get">
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
	    <input type="hidden" class="form-control region-input" name="bo_rg_num"   value="0">
	    <button class="btn btn-outline-success btn-insert">찾기</button>   
	</div>
	</form>
	<div class="input-group mb-3 mt-3">
		<div class="input-group-prepend">
			<select class="form-control select-region" >
				  <option class="region" value="0">전체</option>
			      <option class="region" value="1">서울</option>
		 		  <option class="region" value="27">부산</option>
		 		  <option class="region" value="44">대구</option>
		 		  <option class="region" value="54">인천</option>
		 		  <option class="region" value="65">광주</option>
		 		  <option class="region" value="71">대전</option>
		 		  <option class="region" value="77">울산</option>
		 		  <option class="region" value="83">세종</option>
		 		  <option class="region" value="84">경기</option>
		 		  <option class="region" value="116">강원</option>
		 		  <option class="region" value="135">충북</option>
		 		  <option class="region" value="147">충남</option>
		 		  <option class="region" value="163">전북</option>
		 		  <option class="region" value="178">전남</option>
		 		  <option class="region" value="201">경북</option>
		 		  <option class="region" value="224">경남</option>
		 		  <option class="region" value="243">제주</option>
		   	</select>
		</div>
	</div> 
<br>
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
   	 	<c:choose>
   	 		<c:when test="${bo.bo_bt_num == 1}">
   	 			<!-- 상단에 최신 공지글 모두 표시 -->
		      <tr class="notionBoard">
		      	<td>${bo.bo_num}</td>
		      	<td><a href="<c:url value='/board/detail?bo_num=${bo.bo_num}'/>" style="color:red">${bo.bo_title}</a></td>
		        <td>${bo.me_nickname}</td>
		        <td>${bo.bo_reg_date_str}</td>
		        <td>${bo.bo_count}</td>
		        <td><a href="<c:url value='/board/detail?bo_num=${bo.bo_num}'/>">${bo.bo_comment}</a></td>
		      </tr>
		    </c:when>
		    <c:when test="${bo.bo_bt_num == 3}" >
		      <tr class="boardRegion" data-num="${bo.bo_rg_num}">
		      	<td>${bo.bo_num}</td>
		      	<td><a href="<c:url value='/board/detail?bo_num=${bo.bo_num}'/>">${bo.bo_title}</a></td>
		        <td>${bo.me_nickname}</td>
		        <td>${bo.bo_reg_date_str}</td>
		        <td>${bo.bo_count}</td>
		        <td><a href="<c:url value='/board/detail?bo_num=${bo.bo_num}'/>">${bo.bo_comment}</a></td>
		      </tr>
		    </c:when>
		 </c:choose>
      </c:forEach>
    </tbody>
  </table>
  <!-- 페이지네이션 적용 -->
  <ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
			<li class="page-item">
				<a class="page-link" 
					href="<c:url value='/board/individual${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
			</li>
		</c:if>
		<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
				<a class="page-link" 
					href="<c:url value='/board/individual${pm.cri.getUrl(i)}'/>">${i}</a>
			</li>
		</c:forEach>
		<c:if test="${pm.next}">
			<li class="page-item">
				<a class="page-link" 
					href="<c:url value='/board/individual${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
			</li>
		</c:if>
	</ul>
 </div>
 <script type="text/javascript">
 $(document).on('click', '.btn-individual', function(){
		let co_me_num = '${user.me_num}';
		if(co_me_num == 0 ){
			if(confirm('로그인이 필요한 서비스입니다. 로그인하시겠습니까?')){
				location.href = '<c:url value="/member/login"/>'
			}
			return
		}else{
			location.href = '<c:url value="/board/insert3"/>'
		}
	});


 // 지역 필터 번호 넣기  
$(document).on('click', '.select-region', function(){
	let bo_rg_num = $(this).val();
	console.log(bo_rg_num);
	$('.region-input').val(bo_rg_num);
});		
</script>
</body>
</html>