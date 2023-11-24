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
	.form-control{
		margin-bottom : 10px;
	}
	.title{
		font-size: 35px; font-weight: bolder; margin: 50px auto; border-bottom: 8px solid #c2f296;
		width: 35%; padding-bottom: 10px; text-align: center;
	}
	.in-btn{
		background-color: #d7fdb5; color: black; height: 45px; width: 400px; 
		border-radius: 10px; margin: 50px 0 50px 0; border: none;
	}
</style>    
</head>
</head>
<body>
	<br>
	<p class="title">자유게시판 글 작성</p>
	<form action="<c:url value='/board/insert2'/>" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<label>제목</label>
			<input type="text" class="form-control" name="bo_title">
		</div>
		<div class="form-group">
			<label>작성자</label>
			<input type="text" class="form-control" name="bo_me_id" value="${user.me_nickname}" readonly>
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
		<div style="text-align: center;">
			<button class="in-btn">등록하기</button>
		</div>
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