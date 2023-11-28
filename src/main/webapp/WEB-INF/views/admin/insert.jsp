<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 입력하기</title>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<style>
	h1{
		text-align : center;
	}
	.form-control{
		margin-bottom : 10px;
	}
	.form-control{border-radius: 30px; width: 500px;}
	.form-group{text-align: center;}
	.form-group label{display: inline-block; text-align: center;}
	.form-group button, .form-group select{margin: 0 auto;}
	.form-group input{margin: 0 auto;}
</style>    
</head>
</head>
<body>
	<br>
	<p class="title" style="font-size: 35px; font-weight: bolder; padding-bottom: 30px;
		text-align: center; margin-top: 20px;">사업자 등록</p>
	<form action="<c:url value='/admin/insert'/>" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<label>대표자명</label>
			<input type="text" class="form-control" name="bu_name" >
		</div>
		<div class="form-group">
			<label>대표 전화번호</label>
			<input type="text" class="form-control" name="bu_phone" >
		</div>
		<div class="form-group">
			<label>사업자 등록번호</label>
			<input type="text" class="form-control" name="bu_registration_number" >
		</div>
		<div class="form-group">
			<label>대표 이메일</label>
			<input type="text" class="form-control" name="bu_email" >
		</div>
		<div class="form-group">
			<label>회원 번호</label>
			<input type="text" class="form-control" name="bu_me_num" >
		</div>
		<div style="text-align: center; margin-top: 40px;">
			<button style="background-color: black; color: white; border-radius: 10px; width: 130px;"
				class="btn">등록</button> 
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