<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">

.container{ height: 100%; padding: 70px 0 70px 0;
}
.title{ width:20%; font-size: 40px; font-weight: bolder; text-align: center; letter-spacing: -3px;
	border-bottom: 8px solid #c2f296; padding-bottom: 10px;  margin: 0 auto;}
.title-detail{ margin: 50px auto; background-color: #f0f0f0; border-radius: 30px;
	padding: 30px; width: 42%;}
.form-control{border-radius: 30px; width: 500px;}
.form-group input, .form-group .btn{ display: block; margin: 0 auto; margin-bottom: 30px;}
.form-group label{ text-align: center; display: block; margin: 0 auto;}
.btn{border-radius: 3px; width: 300px; height: 45px; border: none; 
	background-color: #0c0c0c; color: white; font-weight: 900; margin: 50px auto;}

.filebox .fileupload-name {
    display: inline-block;
}
.filebox .file-btn{
	display: inline-block; padding: 6px 25px;
	background-color: #c2f296; cursor: pointer; border-radius: 5px;
}


</style>
<title>매니저 신청</title>
</head>
<body>
	<p class="title">매니저 신청</p>
	<div class="title-detail">
		<p><strong style="font-size: 18px; letter-spacing: -3px;">매니저란?</strong></p>
		<p>매치 매니저로서 참가자들이 즐겁게 운동할 수 있도록
		<br>풋팅이 직접 주선한 취미형 일자리입니다.
		<br>내가 원하는 시간에,
		<br>원하는 구장에서,
		<br>편하고 자유롭게 근무 시간과 장소를 선택할 수 있습니다.</p>
	</div>
	
	<form action="<c:url value='/application/manager'/>"  class="was-validated" method="post" enctype="multipart/form-data" style="text-align: center;">
	  <div class="form-group" hidden="hidden">
	    <label for="bo_bt_num">게시글번호:</label>
	    <input type="text" class="form-control" id="bo_bt_num" name="bo_bt_num" value="6" readonly>
	  </div>
	  
	  <div class="form-group" hidden="hidden">
	    <label for="bo_me_num">회원번호</label>
	    <input type="text" class="form-control" id="bo_me_num" name="bo_me_num" value="${user.me_num}" readonly>
	  </div>
	  
	  <div class="form-group">
		<div class="filebox">
		    <label style="border-bottom: 1px solid #d4d4d1; width: 30%;
		    	 padding-bottom: 10px; margin-bottom: 20px;">아래에 자기소개서와 이력서를 첨부해주세요.</label> <br>
		    <input class="fileupload-name" value="첨부파일" placeholder="첨부파일" readonly>
		    <label for="file1" class="file-btn">업로드</label>
		    <input type="file" class="form-control" name="file" id="file1" style="display: none;" required> <br>
		</div>
		<div class="filebox">
			<input class="fileupload-name" value="첨부파일" placeholder="첨부파일" readonly>
			<label for="file2" class="file-btn">업로드</label>
			<input type="file" class="form-control" name="file" id="file2" style="display: none;"> <br>
		</div>
		<div class="filebox">	
			<input class="fileupload-name" value="첨부파일" placeholder="첨부파일" readonly>
			<label for="file3" class="file-btn">업로드</label>
			<input type="file" class="form-control" name="file" id="file3" style="display: none;" required> <br>
	  	</div>
	  </div>
  	<a href="<c:url value='/'/>"><button type="submit" class="btn">신청하기</button></a>
	</form>
	
</body>

<script type="text/javascript">

//첨부파일 경로 이름 띄우기
$("#file1, #file2, #file3").on('change',function(){
	 //현재 업로드를 가져옴
    var fieldName = $(this).attr("id");
    //현재 선택된 파일의 경로를 가져옴
    var fileName = $(this).val();
    
    $(this).siblings(".fileupload-name").val(fileName);
	});

</script>
</html>