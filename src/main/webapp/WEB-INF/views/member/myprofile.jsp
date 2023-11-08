<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 프로필</title>
<style type="text/css">

.container-body{}
.profile-head{ text-align: center; margin-top: 30px; padding-top: 30px;}
.form-group p{ font-weight: bold;}
.title{ 
	font-size: 22px; font-weight: bolder;
	padding: 10px 0; text-align: center;
}
.myprofile-image-thumb{
	width: 110px; height: 110px; border-radius: 50%; margin: 0 auto;
}
.profile-body{ 
	background-color: #f0f0f0; border-radius: 40px; margin: 0 auto 30px;
	height: auto; width: 600px; text-align: center; padding: 20px;
}

.profile-footer{
	width: 80%; display: flex; margin: 0 auto;
}
.btn-add, .btn-block{
	width: 15%; height: 50px; margin: auto auto 10px; border: none;
	border-radius: 15px; background-color: #c2f296; color: black;

}

</style>
</head>
<body>
<div class="container-body">
	<hr style="margin-top: 30px;">
	<div class="profile-head">
		<img src="/final_project${user.me_profile}" class="myprofile-image-thumb" alt="프로필 사진">
		<p class="title">${user.me_name }님</p>
	</div>	
	<div class="profile-body">
		<div class="form-group">
			<label>아이디</label>
			<p>${user.me_id}</p>
		</div>
		<div class="form-group">
			<label>이름</label>
			<p>${user.me_name}</p>
		</div>
		<div class="form-group">
			<label>닉네임</label>
			<p>${user.me_nickname}</p>
		</div>
		<div class="form-group">
			<label>티어</label>
			<p>${user.me_tr_name}</p>
		</div>
		<div class="form-group">
			<label>거주 지역</label>
			<p>${userRegion}</p>
		</div>
	</div>
	<div class="profile-footer">
		<button class="btn-add">즐겨찾기</button>
		<button class="btn-block">차단하기</button>
	</div>
	<hr>
</div>	   
</body>
</html>