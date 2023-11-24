<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자권한 조회</title>
<style type="text/css">
	.btn-info{
		color : outline-info;
		border : 2px solid yellow;
	}
	.btn-info:hover{
		background-color : outline-info;
		color : white;
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
	.notice-thead{
		display: flex; margin: 10px; padding: 0 0 16px 0;
		border-bottom: 1px solid rgba(0,0,0,.1);
	}
 	.select-business{padding: 5px; margin: 10px;}
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
	.up-btn{
		border-radius: 10px !important; padding: 3px 10px 3px 10px; border: none;
		background-color: #c2f296; color: black; line-height: 35px;
	}
</style>
</head>
<body>
<div class="businessman-search">
	<div class="businessman-search-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 27%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		사업자 권한 조회</p>
	</div>
	<!-- 사업자권한 조회 -->
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
	<!-- 사업자 신청 검색 기능 -->
	<form action="<c:url value='/admin/business2'/>" method="get">
		<div class="businessman-search-navigation" style="margin: 30px 0 30px 0; text-align: center;">
		    <select class="searchType" id="me_authority" name="t">
		      <option value="all"
		      		<c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
		      <option value="first"
		      		<c:if test="${pm.cri.t == 'first'}">selected</c:if>>닉네임</option>
		      <option value="second"
		      		<c:if test="${pm.cri.t == 'second'}">selected</c:if>>제목</option>
		      <option value="third"
		      		<c:if test="${pm.cri.t == 'third'}">selected</c:if>>작성날짜</option>
		    </select>
		    <input type="search" class="keyword" name="s" id="me_title" placeholder="검색어를 입력하세요." value="${pm.cri.s}">
		    <button type="submit" class="search-btn">찾기</button>
		</div>
	</form>
	<!-- 사업자신청 정보 출력 -->
	<div class="main">
		<div class="table">
			<ul class="notice-thead">
				<li style="width: 10%">회원 번호</li>
				<li style="width: 20%">회원 닉네임</li>
				<li style="width: 10%">게시글 타입</li>
				<li style="width: 20%">제목</li>
				<li style="width: 10%">권한</li>
				<li style="width: 20%">작성날짜</li>
				<li style="width: 10%">권한 취소</li>
			</ul>
			 <ul class="select-business">
            <c:forEach items="${list}" var="bu">
               <li>
                  <div class="tbody-box">
                     <div id="tbody-list" style="width: 10%">${bu.me_num}</div>
                     <div id="tbody-list" class="id" style="width: 20%">${bu.me_nickname}</div>
                     <div id="tbody-list" style="width: 10%">
                        <c:choose>
                             <c:when test="${bu.bo_bt_num == 7}">사업자신청</c:when>
                        </c:choose>
                     </div>
                     <div id="tbody-list" style="width: 20%">
                     <a href="<c:url value='/board/detail?bo_num=${bu.bo_num}'/>">${bu.bo_title}</a>
                     </div>
                     <div id="tbody-list" class="update" style="width: 10%">${bu.me_authority}</div>
                     <div id="tbody-list" style="width: 20%">${bu.bo_reg_date_str}</div>
                     <div id="tbody-list" style="width: 10%; height: 60px;">
                        <button class="up-btn btn-update">취소</button>
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
						href="<c:url value='/admin/business2${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
				<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
					<a class="page-link" 
						href="<c:url value='/admin/business2${pm.cri.getUrl(i)}'/>">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pm.next}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/admin/business2${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
<script type="text/javascript">
	/* 신청수락 수정버튼 */
	$(document).on('click', '.btn-update', function(){
		// confirm을 사용하여 알림창을 예 = true, 취소 = false로 출력되게 만들어준다.
		// 만약 true면 밑에 있는 코드를 실행
		if(confirm("권한을 USER로 변경하시겠습니까?")){
			// 버튼을 클릭한 부모 tr에서 class가 id인 값을 me_nickname로 넣어준다.
			let me_nickname = $(this).val();
			// 버튼을 클릭한 부모 tr에서 class가 update인 값을 me_authority로 넣어준다.
			let me_authority = $(this).parents('ul').find('.update').text();
			// 버튼을 누른 회원의 nickname과 authority값을 manager로 가져왔음 ( ex : 동해번쩍, USER )
			let business = {
					me_nickname : me_nickname,
					me_authority : me_authority
			}
			console.log(business);
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/admin/business2"/>',
				data : JSON.stringify(business),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(data){
					if(data.res){
						alert('수정성공')
						let str = ``;
						/* var="bu"를 AdminController에서 만든 list데이터를 반복 */
						for(bu of data.list){
							str += `
								<ul>
									<li>\${bu.me_num}</li>
									<li class="id">\${bu.me_nickname}</li>
									<li>\${bu.bo_bt_num}</li>
									<li id="tbody-list" style="width: 20%"><a href="<c:url value='/board/detail?bo_num=${bu.bo_num}'/>">\${bu.bo_title}</li>
									<li class="update">\${bu.me_authority}</li>
									<li>\${bu.bo_reg_date_str}</li>
									<li>
										<button class="btn btn-outline-danger btn-update">취소</button>
									</li>
								</ul>
							`
						}
						$('.select-business').html(str);
					}else{
						alert('수정실패')
					}
				}
			});
		}
	})      
</script>
</body>
</html>