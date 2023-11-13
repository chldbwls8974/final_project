<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 프로필</title>
<style type="text/css">

.container-body{ width: 100%; display: flex; margin: 50px 0 30px 0;}
.profile-head{ 
	text-align: center; padding: 60px;
	background-color: #f2f2f2; border-radius: 20px;
	margin: 0 30px 0 30px; height: 300px;
}
.form-group{ display: flex;}
.form-group div{ text-align: right;}
.form-group p{ font-weight: bold;}
.title{ 
	font-size: 22px; font-weight: bolder;
	padding: 10px 0; text-align: center; margin: 0;
}
.myprofile-image-thumb{
	width: 110px; height: 110px; border-radius: 50%; margin: 0 auto;
}
.profile-body{ 
	background-color: #f2f2f2; border-radius: 20px;
	height: auto; width: 70%; text-align: center; padding: 20px;
}

.profile-head2{
	width: 80%; display: flex; margin: 10px auto;
}
.btn-add, .btn-block{
	width: auto; height: 50px; margin: auto auto 10px; border: none;
	border-radius: 15px; background-color: #c2f296; color: black;

}

</style>
</head>
<body>
<div class="container-body">
	<hr style="margin-top: 30px;">
	<div>
		<div class="profile-head">
			<img src="/final_project${user.me_profile}" class="myprofile-image-thumb" alt="프로필 사진">
			<p class="title">${user.me_name } 님</p>
			<p style="color: #777777; font-size: 18px;">${user.me_id}</p>
		</div>	
		<div class="profile-head2">
			<button class="btn-add">즐겨찾기</button>
			<button class="btn-block">차단하기</button>
		</div>
	</div>
	<div class="profile-body">
		<div class="form-group">
			<label>닉네임</label>
			<div>
				<p>${user.me_nickname}</p>
			</div>
		</div>
		<div class="form-group">
			<label>티어</label>
			<div>
				<p>${user.me_tr_name}</p>
			</div>
		</div>
		<div class="form-group">
			<label>거주 지역</label>
			<div>
			<p>${userRegion.rg_main}  ${userRegion.rg_sub}</p>
			</div>
		</div>
		<div class="form-group">
			<label>선호 지역</label>
			<div>
			<p>${userPRegion.rg_main} ${userPRegion.rg_sub}</p>
			</div>
		</div>
		<div class="form-group">
			<label>선호 시간대</label>
			<div style="display: flex; justify-content: center;">
				<p>${userPTime.ti_day}요일 </p>
				<p id="timeParagraph">${userPTime.ti_time}시</p>
			</div>
		</div>
	
	</div>
	<hr>
</div>	   
<script type="text/javascript">

	//ready 함수를 사용하여 문서가 준비되면 실행
	$(document).ready(function() {
    // jQuery를 사용하여 시간 형식 변경
    var timeString = "${userPTime.ti_time}";
    
    // Date 객체를 사용하여 문자열을 파싱
    var time = new Date("1970-01-01 " + timeString);
    
    // 시간 부분만 추출하여 p 태그에 추가
    var hours = time.getHours();
    
    // jQuery를 사용하여 p 태그에 시간 추가
    $("#timeParagraph").text(hours + "시");
});

</script>
</body>
</html>