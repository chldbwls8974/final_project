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
	<form action="<c:url value='/admin/member'/>" method="get">
	<div class="input-group mb-3 mt-3">
		<div class="input-group-prepend">
		    <select class="form-control" id="me_authority" name="t">
		      <option value="all">전체</option>
		      <option value="second">아이디</option>
		      <option value="third">작성날짜</option>
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
				<th>회원아이디</th>
				<th>게시글 타입</th>
				<th>제목</th>
				<th>권한</th>
				<th>작성날짜</th>
				<th>매니저신청 수락</th>
			</tr>
		</thead>
		<tbody>
			<tr>
			   <c:forEach items="${list}" var="ma">
					<td>${ma.me_num}</td>
					<td class="id">${ma.me_id}</td>
					<td>${ma.bo_bt_num}</td>
					<td>${ma.bo_title}</td>
					<td class="update">${ma.me_authority}</td>
					<td>${ma.bo_reg_date_str}</td>
					<td><button class="btn btn-outline-warning btn-update">신청수락</button></td>
				</c:forEach>
			</tr>
		</tbody>
	</table>
</div>
<script type="text/javascript">
	/* 신청수락 수정버튼 */
	/* $('.btn-update').click(function(){
		let me_id = $(this).parents('tr').find('.id').text();
		let me_authority = $(this).parents('tr').find('.update').text();		
		let member = {
				me_id : me_id,
				me_authority : me_authority
		}
		$ajax({
			method : 'post',
			url : '<c:url value="/admin/manager"/>',
			data : JSON.stringify(member),
			contentType : 'application/json; charset=utf-8',
			dataType : 'json',
			success : function(data){
				if(data.res){
					alert('수정성공')
				}else{
					alert('수정 실패')
				}
			}
		});
	}) */     
</script>
</body>
</html>