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
	<h1>&#x2709 수정하는 곳 &#x2709</h1>
	<form action="<c:url value='/board/update'/>" method="post">
		<div class="form-group">
			<label>제목</label>
			<input type="text" class="form-control" name="bo_title" value="${board.bo_title}">
		</div>
		<div class="form-group">
			<label>작성자</label>
			<input type="text" class="form-control" name="bo_me_id" value="${user.me_id}" readonly>
		</div>
		<div class="form-group">
			<label>내용</label>
			<textarea name="bo_contents" id="summernote" >
				${board.bo_contents}
			</textarea>
		</div>
		<div class="form-group">
			<label>첨부파일</label>
			<c:forEach items="${board.fileVoList}" var="file">
				<a 	href="<c:url value='/download${file.fi_name }'/>"
					class="form-control" 
					download="${file.fi_ori_name}">${file.fi_ori_name } <span class="btn-del" data-num="${file.fi_num}">x</span></a>
			</c:forEach>
			<c:forEach begin="1" end="${3-board.fileVoList.size()}">
				<input type="file" class="form-control" name="files">
			</c:forEach>
		</div>
			<button type="button"
					class="btn btn-outline-warning col-12 btn-update"
					onclick="location.href='<c:url value='/board/update'/>'">수정하기
			</button><br>
	</form>

	<script>
      $('#summernote').summernote({
        placeholder: '내용을 입력하세요.',
        tabsize: 2,
        height: 400
      });
      $('#summernote').summernote('code', '${board.bo_contents}');
      $('.btn-del').click(function(e){
    	  e.preventDefault();
    	  let fi_num = $(this).data('num');
    	  $(this).parent().after('<input type="hidden" name="delFiles" value="'+fi_num+'">')
    	  $(this).parent().remove();
    	  $('#file').append('<input type="file" class="form-control" name="files">');
      });
    </script>
</body>
</html>