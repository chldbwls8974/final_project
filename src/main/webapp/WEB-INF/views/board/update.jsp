<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지게시글 수정하는 곳</title>
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
	<form action="<c:url value='/board/update'/>" method="post"  enctype="multipart/form-data">
		<input type="hidden" name="bo_num" value="${board.bo_num}">
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
			<label>첨부파일 : </label>
			<c:forEach items="${fileList}" var="file">
				<!-- 어디 까지가 부모인지 알아야하기 때문에 div태그로 감싸준다. -->
				<div class="box">
					<a  href="<c:url value='/download${file.fi_name}'/>" 
						download="${file.fi_ori_name }">${file.fi_ori_name}
					</a>
					<a href="#" class="btn-del btn" data-num="${file.fi_num}">
						<button type="button">X</button>
					</a><br>
				</div>	
			</c:forEach>
			<c:forEach begin="1" end="${3 - fileList.size() }">
				<input type="file" name="files"> <br>
			</c:forEach>
			<button class="btn btn-outline-warning col-12 btn-submit">수정하기</button><br>
		</div>
	</form>
	<script type="text/javascript">
	$('#summernote').summernote({
	    placeholder: '내용을 입력하세요.',
	    tabsize: 2,
	    height: 400
	});
	// 내용에 들어가는 엔터 때문에 역따옴표로 넣어줘야한다
	$('#summernote').summernote('code', `${board.bo_contents}`); 

	$(document).on('click', '.btn-del', function(e) {
		console.log($(this).val())
		e.preventDefault();
		let fi_num = $(this).data('num');
		$('.btn-submit').before('<input type="file" name="files"> <br>');
		$('.btn-submit').before('<input type="hidden" name="delNums" value="'+fi_num+'"> <br>');
		$(this).parent().remove();
	});
    </script>
</body>
</html>