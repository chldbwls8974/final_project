<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인매치 게시글 쓰기</title>
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
	<h1>&#x2709 클럽매치 쓰셈 &#x2709</h1>
	<form action="<c:url value='/board/insert4'/>" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<label>제목</label>
			<input type="text" class="form-control" name="bo_title">
		</div>
		<div class="form-group">
			<label>작성자</label>
			<input type="text" class="form-control" name="bo_me_id" value="${user.me_id}" readonly>
		</div>
		<div class="form-group">
			<label>지역선택</label>
			<div class="input-group-prepend">
			    <select class="form-control" name="bo_rg_num">
			      <option value="1">서울</option>
			      <option value="27">부산</option>
			      <option value="44">대구</option>
			      <option value="54">인천</option>
			      <option value="65">광주</option>
			      <option value="71">대전</option>
			      <option value="77">울산</option>
			      <option value="83">세종</option>
			      <option value="84">경기</option>
			      <option value="116">강원</option>
			      <option value="135">충북</option>
			      <option value="147">충남</option>
			      <option value="163">전북</option>
			      <option value="178">전남</option>
			      <option value="201">경북</option>
			      <option value="224">경남</option>
			      <option value="243">제주</option>
		   		</select>
		    </div>
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