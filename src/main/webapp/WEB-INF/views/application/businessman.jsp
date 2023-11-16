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
.title{ width:20%; font-size: 35px; font-weight: bolder; text-align: center; letter-spacing: -3px;
	border-bottom: 8px solid #c2f296; padding-bottom: 10px;  margin: 0 auto; margin-bottom: 30px;}
.title-detail{ margin: 50px auto; background-color: #f2f2f2; border-radius: 30px;
	padding: 30px; width: 42%;}
.form-group{ text-align: center;}
.form-group label{ text-align: center; display: block; margin: 0 auto;}
#bo_contents{  resize: none; outline: none; border-radius: 5px;
	width: 400px; overflow: hidden; margin: 20px auto;}
.filebox .fileupload-name {
    display: inline-block;}
.filebox{ margin-bottom: 30px;}
.filebox .file-btn{
	display: inline-block; padding: 6px 25px;
	background-color: #c2f296; cursor: pointer; border-radius: 5px;}


.was-validated .btn{ display: block; margin: 0 auto; margin-bottom: 30px;}
.btn{border-radius: 3px; width: 300px; height: 45px; border: none; 
	background-color: #0c0c0c; color: white; font-weight: 900; margin-top: 80px;}



</style>
<title>사업자 신청</title>
</head>
<body>
	<p class="title">사업자 신청</p>
	<form action="<c:url value='/application/businessman'/>" method="post" class="was-validated" enctype="multipart/form-data">
	  <div class="form-group" hidden="hidden">
	    <label for="bo_bt_num">게시글번호:</label>
	    <input type="text" class="form-control" id="bo_bt_num" name="bo_bt_num" value="7" readonly>
	  </div>
	  <br>
	  <div class="form-group" hidden="hidden">
	    <label for="bo_me_num">회원번호:</label>
	    <input type="text" class="form-control" id="bo_me_num" name="bo_me_num" value="${user.me_num}" readonly>
	  </div>
	
	  <div class="title-detail">
			<p><strong style="font-size: 18px; letter-spacing: -3px;">사업자 승인 절차 안내</strong></p>
			<p><b>1</b> 아래의 양식에 따라 사업자 신청을 진행해주세요.
			<br><b>2</b> 관리자가 사업자 등록증 확인 후 미팅 날짜 안내를 위해 유선상 별도 연락드립니다.
			<br><b>3</b> 심사에 통과되면, 사업자 승인이 완료되었다는 안내 문자가 전달되며 사업자 페이지에서 시설 및 경기장 등록이 가능합니다.</p>
	  </div>
	  <br>
	
	  <div class="form-group">
	  	<label for="bo_contents" style="border-bottom: 1px solid #d4d4d1; width: 40%;
		    	 padding-bottom: 10px; margin-bottom: 10px;">1. 대표자명 / 대표 전화번호 / 대표 이메일을 작성해주세요.</label>
	    <textarea class="form-control" id="bo_contents" name="bo_contents" rows="3">
	    대표 이름 : 
	    대표 연락처 : 
	    대표 이메일 : 
	    </textarea>
	  </div>
	  <br>
	  <br>
	  <div class="form-group">
	  	<div class="filebox">
		    <label style="border-bottom: 1px solid #d4d4d1; width: 40%;
		    	 padding-bottom: 10px; margin-bottom: 10px;">2. 아래에 사업자 등록증을 첨부해주세요.</label> <br>
		    <input class="fileupload-name" value="첨부파일" placeholder="첨부파일" readonly>
			<label for="file1" class="file-btn">업로드</label>
		    <input type="file" class="form-control" name="files" id="file1" style="display: none;" required> <br>
		</div>	
		<div class="filebox" style="margin-bottom: 50px;">		    
		    <input class="fileupload-name" value="첨부파일" placeholder="첨부파일" readonly>
			<label for="file2" class="file-btn">업로드</label>
			<input type="file" class="form-control" name="files" id="file2" style="display: none;"> <br>
		</div>	
	  </div>
  	  <a href="<c:url value='/'/>"><button type="submit" class="btn">신청하기</button></a>	
	</form>
	
</body>
<script type="text/javascript">

//첨부파일 경로 이름 띄우기
$("#file1, #file2").on('change',function(){
	 //현재 업로드를 가져옴
    var fieldName = $(this).attr("id");
    //현재 선택된 파일의 경로를 가져옴
    var fileName = $(this).val();
    
    $(this).siblings(".fileupload-name").val(fileName);
});

</script>
</html>