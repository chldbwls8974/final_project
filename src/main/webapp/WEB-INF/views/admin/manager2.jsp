<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매니저권한 조회</title>
<style type="text/css">
	.btn-group{
		float : right;
	}
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
		background-color: cornsilk; border-radius: 20px;
	}
	.a{
		color : red;
	}
	.notice-thead{
		display: flex; justify-content: space-between; padding: 0 0 16px 0;
		border-bottom: 1px solid rgba(0,0,0,.1);
	}
 	.notice-tbody{ justify-content: space-between; padding: 5px;}
	.tbody-box{ 
		display: flex; justify-content: space-between;
		margin: 0; padding: 20px 20px 30px 20px; border-bottom: 1px solid rgba(0,0,0,.1);
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
<div class="manager-search">
	<div class="manager-search-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; font-weight: bolder; margin:0 auto; padding: 20px 0 10px 0;">매니저 권한 조회</p>
	</div>
	<!-- 매니저권한 조회 -->
	<br>
	<div class="btn-group btn-group">
	  <button type="button"
				    class="btn btn-dark btn-info"
					onclick="location.href='<c:url value='/admin/manager'/>'"	    
			>매니저신청 관리</button>
	  <button type="button"
				    class="btn btn-dark btn-info"
					onclick="location.href='<c:url value='/admin/manager2'/>'"	    
			>매니저권한 조회</button>
	</div>
	<br>
	<!-- 매니저 검색 기능 -->
	<form action="<c:url value='/admin/manager2'/>" method="get">
		<div class="manager-search-navigation" style="margin-top: 30px; text-align: center;">
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
	<!-- 매니저 정보 출력 -->
	<div class="main">
		<div class="table">
			<ul class="notice-thead">
				<li>회원 번호</li>
				<li>회원 닉네임</li>
				<li>게시글 타입</li>
				<li>제목</li>
				<li>권한</li>
				<li>작성날짜</li>
				<li>매니저권한 취소</li>
			</ul>
		    <ul class="notice-tbody">
			   <c:forEach items="${list}" var="ma">
					<li>
						<div class="tbody-box">
							<div id="tbody-list">${ma.me_num}</div>
							<div id="tbody-list" class="id">${ma.me_nickname}</div>
							<div id="tbody-list">
								<c:choose>
			        				<c:when test="${ma.bo_bt_num == 6}">매니저신청</c:when>
								</c:choose>
							</div>
							<div id="tbody-list"><a href="<c:url value='/board/detail?bo_num=${ma.bo_num}'/>">${ma.bo_title}</a></div>
							<div id="tbody-list" class="update">${ma.me_authority}</div>
							<div id="tbody-list">${ma.bo_reg_date_str}</div>
							<div id="tbody-list">
								<button class="btn btn-outline-danger btn-update">취소</button>
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
						href="<c:url value='/admin/manager2${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
				<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
					<a class="page-link" 
						href="<c:url value='/admin/manager2${pm.cri.getUrl(i)}'/>">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pm.next}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/admin/manager2${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
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
			let me_nickname = $(this).parents('tr').find('.id').text();
			// 버튼을 클릭한 부모 tr에서 class가 update인 값을 me_authority로 넣어준다.
			let me_authority = $(this).parents('tr').find('.update').text();
			// 버튼을 누른 회원의 nickname과 authority값을 manager로 가져왔음 ( ex : 동해번쩍, USER )
			let manager = {
					me_nickname : me_nickname,
					me_authority : me_authority
			}
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/admin/manager2"/>',
				data : JSON.stringify(manager),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(data){
					if(data.res){
						alert('수정성공')
						let str = ``;
						/* var="ma"를 AdminController에서 만든 list데이터를 반복 */
						for(ma of data.list){
							str += `
								<tr>
									<td>\${ma.me_num}</td>
									<td class="id">\${ma.me_nickname}</td>
									<td>\${ma.bo_bt_num}</td>
									<td>\${ma.bo_title}</td>
									<td class="update">\${ma.me_authority}</td>
									<td>\${ma.bo_reg_date_str}</td>
									<td>
										<button class="btn btn-outline-warning btn-update">취소</button>
									</td>
								</tr>
							`
						}
						$('.select-manager').html(str);
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