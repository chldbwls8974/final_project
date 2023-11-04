<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 쓰기</title>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<style>
	h1{
		text-align : center;
	}
	.form-control{
		margin-bottom : 10px;
	}
</style>    
</head>
</head>
<body>
	<br>
	<h1>&#x2709 자유글 쓰셈 &#x2709</h1>
	<form action="<c:url value='/board/insert2'/>" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<label>제목</label>
			<input type="text" class="form-control" name="bo_title">
		</div>
		<div class="form-group">
			<label>작성자</label>
			<input type="text" class="form-control" name="bo_me_id" value="${user.me_id}" readonly>
		</div>
		<div class="form-group">
			<label>내용</label>
			<textarea name="bo_contents" id="summernote"></textarea>
		</div>
		<div class="form-group">
			<label>첨부파일</label>
			<input type="file" class="form-control" name="files">
			<input type="file" class="form-control" name="files">
			<input type="file" class="form-control" name="files">
		</div>
		<button class="btn btn-outline-success col-12">등록하기</button>
	</form>

	<script>
      $('#summernote').summernote({
        placeholder: '내용을 입력하세요.',
        tabsize: 2,
        height: 400
      });
    </script>
</body>
</html>