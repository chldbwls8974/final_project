<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매니저 신청 관리</title>
</head>
<body>
<!-- 매니저 신청 검색 기능 -->
	<form action="<c:url value='/admin/manager'/>" method="get">
	<div class="input-group mb-3 mt-3">
		<div class="input-group-prepend">
		    <select class="form-control" id="me_authority" name="t">
		      <option value="all"
		      		<c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
		      <option value="first"
		      		<c:if test="${pm.cri.t == 'first'}">selected</c:if>>닉네임</option>
		      <option value="second"
		      		<c:if test="${pm.cri.t == 'second'}">selected</c:if>>제목</option>
		      <option value="third"
		      		<c:if test="${pm.cri.t == 'third'}">selected</c:if>>작성날짜</option>
		    </select>
	    </div>
	    <input type="text" class="form-control" name="s" id="me_title" placeholder="검색어를 입력하세요." value="${pm.cri.s}">
	    <button class="btn btn-outline-success btn-insert">찾기</button>
	</div>
	</form>
<!-- 매니저신청 정보 출력 -->
<div class="container">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>회원 번호</th>
				<th>회원 닉네임</th>
				<th>게시글 타입</th>
				<th>제목</th>
				<th>권한</th>
				<th>작성날짜</th>
				<th>매니저신청 수락</th>
			</tr>
		</thead>
		<tbody class="select-manager">
		   <c:forEach items="${list}" var="ma">
				<tr>
					<td>${ma.me_num}</td>
					<td class="id">${ma.me_nickname}</td>
					<td>
						<c:choose>
	        				<c:when test="${ma.bo_bt_num == 6}">매니저신청</c:when>
						</c:choose>
					</td>
					<td><a href="<c:url value='/admin/contents'/>">${ma.bo_title}</a></td>
					<td class="update">${ma.me_authority}</td>
					<td>${ma.bo_reg_date_str}</td>
					<td>
						<button class="btn btn-outline-warning btn-update">신청수락</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- 페이지네이션 적용 -->
  <ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
			<li class="page-item">
				<a class="page-link" 
					href="<c:url value='/admin/manager${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
			</li>
		</c:if>
		<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
				<a class="page-link" 
					href="<c:url value='/admin/manager${pm.cri.getUrl(i)}'/>">${i}</a>
			</li>
		</c:forEach>
		<c:if test="${pm.next}">
			<li class="page-item">
				<a class="page-link" 
					href="<c:url value='/admin/manager${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
			</li>
		</c:if>
	</ul>
</div>
<script type="text/javascript">
	/* 신청수락 수정버튼 */
	$(document).on('click', '.btn-update', function(){
		// confirm을 사용하여 알림창을 예 = true, 취소 = false로 출력되게 만들어준다.
		// 만약 true면 밑에 있는 코드를 실행
		if(confirm("수락하시겠습니까?")){
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
				url : '<c:url value="/admin/manager"/>',
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
										<button class="btn btn-outline-warning btn-update">신청수락</button>
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