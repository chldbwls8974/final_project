<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지게시글 상세보기</title>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<style>
	h1{
		text-align : center;
	}
	.form-control{
		margin-bottom : 10px;
	}
	.btn{
		margin-bottom : 10px;
	}
</style>    
</head>
</head>
<body>
	<br>
	<h1>&#x2709 공지글 보는 곳 &#x2709</h1>
	<form action="<c:url value='/board/detail'/>" method="post">
		<div class="form-group">
			<label>제목</label>
			<input type="text" class="form-control" name="bo_title" value="${board.bo_title}" readonly>
		</div>
		<div class="form-group">
			<label>작성자</label>
			<input type="text" class="form-control" name="bo_me_id" value="${user.me_id}" readonly>
		</div>
		<div class="input-group mb-3">
		    <div class="input-group">
		    	<div class="form-control"
					 style="height : 600px; overflow-y: auto; text-align: center;" >${board.bo_contents}</div>
		    </div>
		</div>
		<div class="form-group">
			<label>첨부파일 : </label>
				<c:forEach items="${fileList}" var="file">
					<a  href="<c:url value='/download${file.fi_name}'/>" 
						download="${file.fi_ori_name }">${file.fi_ori_name }</a><br>
				</c:forEach>
		</div>
		<button type="button"
				class="btn btn-outline-info col-12 btn-return" 
				onclick="location.href='<c:url value='/board/notice'/>'">돌아가기
		</button>
		<c:if test="${user != null && user.me_authority == 'ADMIN'}">
			<button type="button"
					class="btn btn-outline-warning col-12 btn-update"
					onclick="location.href='<c:url value='/board/update'/>'">수정하기
			</button><br>
		</c:if>
		<c:if test="${user != null && user.me_authority == 'ADMIN'}">
			<button type="button"
					class="btn btn-outline-danger col-12 btn-delete"
					onclick="location.href='<c:url value='/board/delete?bo_num=${board.bo_num}'/>'">삭제하기
			</button><br>
		</c:if>
	</form>

<script>
     $('#summernote').summernote({
       placeholder: '내용을 입력하세요.',
       tabsize: 2,
       height: 400
     });
    /*  // 삭제하기 버튼
     $(document).on('click', 'btn-delete', function(){
    	// confirm을 사용하여 알림창을 예 = true, 취소 = false로 출력되게 만들어준다.
 		// 만약 true면 밑에 있는 코드를 실행
 		if(confirm('정말 삭제하시겠습니까?')){
 			$.ajax({
 				async : false,
				method : 'post',
				url : '<c:url value="/board/notice"/>',
				data : JSON.stringify(board),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(data){
					if(data.res){
						alert('삭제성공')
					}else{
						alert('삭제실패')
					}
				}
 			})
 		}
     }) */
</script>
</body>
</html>