<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인매치 게시판</title>
<style>
.container-body{
		background-color: #f2f2f2; height: auto; margin-top: 20px;
		border-radius: 20px; padding-bottom: 20px;
	}
	.main{
		padding: 40px; height: auto;
		background-color: white; border-radius: 20px;
	}
	.individual-thead{
		display: flex; padding: 20px;
		border-bottom: 1px solid rgba(0,0,0,.1);
	}
 	.individual-tbody{ padding: 5px;}
 	.tbody-box{ 
		display: flex; margin: 0; padding: 20px 20px 30px 20px;
	}
	.search-btn{
		border-radius: 3px; width: 120px; height: 38px; border: none;
		background-color: #0c0c0c; color: white;
	}
	.write-btn{
		border-radius: 5px; width: 120px; height: 40px; border: none;
		background-color: #c2f296; color: black; margin: 10px 0 10px 0;
	}
	.write-btn:hover{
		background-color : #e6ffcc; color: black;
		border : 1px solid #c2f296;
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
	.notion{
	  background-color: #dffac7;
	  border-radius: 30px;
	}
	.notion:first-child,
	.notion+.notion{
		margin-bottom: 10px;
	}
</style>
</head>
<body>
<div class="container-body">
	<div style="padding : 30px">
	<br>
		<p style="font-size: 35px; font-weight: bolder; margin: 10px auto 50px auto; border-bottom: 8px solid #c2f296;
			width: 20%; padding: 20px 0 10px 0; text-align: center;">개인게시판</p>
		<div style="display:flex;">
			
			<div class="input-group mb-3 mt-3">
				<div class="input-group-prepend" style="width: 130px;">
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
			<button type="button" style="width: 135px;"
				    class="write-btn btn-individual"
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
		    <button class="search-btn btn-insert">찾기</button>   
		</div>
		</form>
	<br>
	<!-- 공지게시판 출력 -->
		<div class="main">
		  <div class="table">
		     <ul class="individual-thead">
		      	<li style="width: 10%;">게시글번호</li>
		      	<li style="width: 35%;">제목</li>
		        <li style="width: 15%;">작성자 닉네임</li>
		        <li style="width: 20%;">작성일</li>
		        <li style="width: 10%;">조회수</li>
		        <li style="width: 10%;">댓글수</li>
		      </ul>
		   </div>
		   	 <ul class="individual-tbody">
		   	 <c:forEach items="${list}" var="bo" varStatus="loop">
			   	 	<c:choose>
				   	 		<c:when test="${bo.bo_bt_num == 1 && loop.index < 3 }">
			   	 				<li class="notion">
							      <div class="tbody-box">
							      	<div class="tbody-list" style="width: 10%;">${bo.bo_num}</div>
							      	<div class="tbody-list" style="width: 35%;">
							      		<a href="<c:url value='/board/detail?bo_num=${bo.bo_num}'/>" 
							      			style="color: #646464;">${bo.bo_title}</a>
							      	</div>
							        <div class="tbody-list" style="width: 15%;">${bo.me_nickname}</div>
							        <div class="tbody-list" style="width: 20%;">${bo.bo_reg_date_str}</div>
							        <div class="tbody-list" style="width: 10%;">${bo.bo_count}</div>
							        <div class="tbody-list" style="width: 10%;">${bo.bo_comment}</div>
							      </div>
								</li>
						    </c:when>
						    <c:when test="${bo.bo_bt_num == 3}">
								<li>
							      <div class="tbody-box">
							      	<div class="tbody-list" style="width: 10%;">${bo.bo_num}</div>
							      	<div class="tbody-list" style="width: 35%;"><a href="<c:url value='/board/detail?bo_num=${bo.bo_num}'/>"
							      								style="color: #86aa64;">${bo.bo_title}</a></div>
							        <div class="tbody-list" style="width: 15%;">${bo.me_nickname}</div>
							        <div class="tbody-list" style="width: 20%;">${bo.bo_reg_date_str}</div>
							        <div class="tbody-list" style="width: 10%;">${bo.bo_count}</div>
							        <div class="tbody-list" style="width: 10%;"><a href="<c:url value='/board/detail?bo_num=${bo.bo_num}'/>">${bo.bo_comment}</a></div>
							      </div>
								</li>
						   </c:when>
					 </c:choose>
		      </c:forEach>
	      	</ul>
		</div>
	</div>
	  <!-- 페이지네이션 적용 -->
	  <ul class="pagination justify-content-center" style="margin: 30px;">
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
});k		
</script>
</body>
</html>