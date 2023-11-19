<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자입력</title>
<style type="text/css">
	.btn-info{
		color : outline-info;
		border : 2px solid yellow;
	}
	.btn-info:hover{
		background-color : outline-info;
		color : white;
	}
	.write-btn{
		border-radius: 5px; width: 120px; height: 40px; border: none;
		background-color: #c2f296; color: black; margin: 10px 0 10px 0;
	}
	.write-btn:hover{
		background-color : #e6ffcc; color: black;
		border : 1px solid #c2f296;
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
	.main{
		padding: 40px; height: auto;
		background-color: #eafdd9; border-radius: 20px;
	}
	.a{
		color : red;
	}
	.business-thead{
		display: flex; padding: 0 0 16px 0;
		border-bottom: 1px solid rgba(0,0,0,.1);
	}
 	.select-business{padding: 5px;}
	.tbody-box{ 
		display: flex; border-bottom: 1px solid rgba(0,0,0,.1);
		margin: 0; padding: 20px 20px 30px 20px;
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
</style>
</head>
<body>
<div class="businessman-search">
	<div class="businessman-search-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 27%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		사업자등록 조회</p>
	</div>
	<!-- 사업자등록 조회 -->
	<div style="text-align: center; margin-right: 10px;">
		<div class="btn-group btn-group">
			<button type="button"
					    class="btn-info"
					    style="
							border-radius: 10px; width: 130px; height: 40px; border: none;
							background-color: #c2f296; color: black; margin: 10px 10px 10px 0;"
						onclick="location.href='<c:url value='/admin/business'/>'"	    
				>신청 관리</button>
			<button type="button"
					    class="btn-info"
					    style="
							border-radius: 10px; width: 130px; height: 40px; border: none;
							background-color: #c2f296; color: black; margin: 10px 0 10px 0;"
						onclick="location.href='<c:url value='/admin/business2'/>'"	    
				>권한 조회</button>
			<button type="button"
					    class="btn-info"
					    style="
							border-radius: 10px; width: 130px; height: 40px; border: none;
							background-color: #c2f296; color: black; margin: 10px 0 10px 10px;"
						onclick="location.href='<c:url value='/admin/business3'/>'"	    
				>사업자 입력</button>
		</div>
	</div>
	<div style="display:flex; justify-content: flex-end;">
			<button type="button"
				    class="write-btn btn-business"
				    onclick="location.href='<c:url value='/admin/insert'/>'"
				>사업자 등록</button>
	</div>
	<!-- 사업자 검색 기능 -->
	<form action="<c:url value='/admin/business3'/>" method="get">
		<div class="businessman-search-navigation" style="margin: 30px 0 30px 0; text-align: center;">
		    <select class="searchType" id="me_authority" name="t">
		      <option value="all"
		      		<c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
		      <option value="first"
		      		<c:if test="${pm.cri.t == 'first'}">selected</c:if>>회원번호</option>
		      <option value="second"
		      		<c:if test="${pm.cri.t == 'second'}">selected</c:if>>대표자명</option>
		      <option value="third"
		      		<c:if test="${pm.cri.t == 'third'}">selected</c:if>>사업자 번호</option>
		    </select>
		    <input type="search" class="keyword" name="s" id="me_title" placeholder="검색어를 입력하세요." value="${pm.cri.s}">
		    <button type="submit" class="search-btn">찾기</button>
		</div>
	</form>
	<!-- 사업자 정보 출력 -->
	<div class="main">
		<div class="table">
			<ul class="business-thead">
				<li style="width: 10%">사업자 번호</li>
				<li style="width: 20%">대표자명</li>
				<li style="width: 10%">대표 전화번호</li>
				<li style="width: 20%">사업자 등록번호</li>
				<li style="width: 10%">대표 이메일</li>
				<li style="width: 20%">회원 번호</li>
				<li style="width: 10%">수정</li>
				<li style="width: 10%">삭제</li>
			</ul>
			<ul class="select-business">
            <c:forEach items="${list}" var="bu">
               <li>
                  <div class="tbody-box">
                     <div id="tbody-list" style="width: 10%">${bu.bu_num}</div>
                     <div id="tbody-list" class="id" style="width: 20%">${bu.bu_name}</div>
                     <div id="tbody-list" style="width: 10%">${bu.bu_phone}</div>
                     <div id="tbody-list" style="width: 20%">${bu.bu_registration_number}</div>
                     <div id="tbody-list" class="update" style="width: 10%">${bu.bu_email}</div>
                     <div id="tbody-list" style="width: 20%">${bu.bu_me_num}</div>
                     <div id="tbody-list" style="width: 10%">
                     	<button type="button"
                     			class="btn btn-update"
								style="background-color: #d7fdb5; color: black; height: 45px; border-radius: 10px; width: 70px; margin-bottom: 20px;"
								onclick="location.href='<c:url value='/admin/update?bu_num=${bu.bu_num}'/>'"
								>수정</button>	
                     </div>
                     <div id="tbody-list" style="width: 10%">
                     	<button type="button"
                     			class="btn btn-delete" value="${bu.bu_num}"
								style="background-color: #d7fdb5; color: black; height: 45px; border-radius: 10px; width: 70px; margin-bottom: 20px;"
                     			>삭제</button>
                     </div>
                  </div>
               </li>
            </c:forEach>
         	</ul>
		</div>
		<!-- 페이지네이션 적용 -->
	  <ul class="pagination justify-content-center">
			<c:if test="${pm.prev}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/admin/business3${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
				<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
					<a class="page-link" 
						href="<c:url value='/admin/business3${pm.cri.getUrl(i)}'/>">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pm.next}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/admin/business3${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
<script type="text/javascript">
$(document).on('click', '.btn-delete', function (){
	data={bu_num : $(this).val()}
	if(confirm("정말 사업자를 삭제하시겠습니까?")){
		ajaxJsonToJson2(false,'get','/admin/delete',data, (a)=>{
			
		})
	}
})
</script>
</body>
</html>