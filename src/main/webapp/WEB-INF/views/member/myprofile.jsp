<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 프로필</title>
<style type="text/css">

.container-body{ width: 100%; height: auto; display: flex; margin-top: 100px;}
.profile-head{ 
	text-align: center; padding: 60px;
	background-color: #f2f2f2; border-radius: 20px;
	margin: 0 30px 0 30px; height: auto; width: 250px;
}
.form-group{ display: flex; justify-content: space-between;}
.form-group label {  text-align: left; border-left: 7px solid #c2f296; padding-left: 10px;}
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
	background-color: #f2f2f2; border-radius: 20px; display: flex; flex-direction: column;
	height: auto; width: 70%; text-align: center; padding: 80px 50px 50px 50px;
}
.profile-head2{
	width: 80%; display: flex; margin: 10px auto;
}

.myedit{ }
.myedit a{text-decoration: none; color: black; display: flex;}
.myedit p { margin: 3px 0 0 0;}
.myedit a:hover{text-decoration: none; color: black;}
.btn-add, .btn-block{
	width: 120px; height: 40px; margin: auto auto 10px; border: none;
	border-radius: 5px; background-color: #c2f296; color: black;
}

</style>
</head>
<body>
<div class="container-body">
	<hr style="margin-top: 30px;">
	<div>
		<div class="profile-head">
			<img src="<c:url value='/memberimg${user.me_profile}'/>" class="myprofile-image-thumb" alt="프로필 사진">
			<p class="title">${member.me_name }</p> 
			<p style="color: #777777; font-size: 18px;">${member.me_id}</p>
			<div class="myedit">
				<a href="<c:url value='/member/myedit?me_num=${user.me_num}'/>" class="myprofile-btn">
					<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_setting_color.svg"
						style="width: 24px; height: 24px; margin-right: 5px;" alt="프로필 수정">
					<p style="font-size: 14px;">프로필 수정하기</p>
				</a>
			</div>
		</div>	
		<div class="profile-head2">
			<button class="btn-add">즐겨찾기</button>
			<button class="btn-block">차단하기</button>
		</div>
	</div>
	<div class="profile-body">
		<div class="form-group">
			<label>닉네임 </label>
			<div>
				<p> ${member.me_nickname}</p>
			</div>
		</div>
		<div class="form-group">
			<label>티어</label>
			<div>
				<p>${member.me_tr_name}</p>
			</div>
		</div>
		<div class="form-group">
			<label>거주 지역</label>
			<div>
			<p>&nbsp;&nbsp;${memberRegion.rg_main}  ${memberRegion.rg_sub}</p>
			</div>
		</div>
		<div class="form-group">
			<label>선호 지역</label>
			<div>
				<c:forEach items="${memberPRegion}" var="list">
					<p>&nbsp;&nbsp;${list.rg_main}  ${list.rg_sub}</p> 
				</c:forEach>
			</div>
		</div>
		<div class="form-group">
			<label>평일 선호 시간대</label>
			<div style="display: flex; justify-content: center;">
				<c:forEach items="${memberPTimeWeekday}" var="list">
					<p>&nbsp;&nbsp;${list.pt_ti_num} : 00</p>
				</c:forEach> 
			</div>
		</div>
		<div class="form-group">
			<label>주말 선호 시간대</label>
			<div style="display: flex; justify-content: center;">
				<c:forEach items="${memberPTimeHoliday}" var="list">
					<p>&nbsp;&nbsp;${list.pt_ti_num} : 00</p>
				</c:forEach> 
			</div>
		</div>
	
	</div>
	<hr>
</div>
</body>
<script type="text/javascript">

	//즐겨찾기, 차단리스트를 가져오는 함수
	$(document).ready(function() {
		//본인 프로필이면 버튼 숨기기
		var userNum = ${user.me_num};
		var memberNum = ${member.me_num};
		if(userNum == memberNum){
			$('.btn-add, .btn-block').hide();
		}
    	getBlockAndMarkList(); 
	});
	//즐겨찾기 추가/삭제
	$('.btn-add').click(function(){
		data = {
			ma_me_num : ${user.me_num},
			ma_marked_num : ${member.me_num}
		}
		ajaxJsonToJson(false, 'post', "/member/markList/process", data,(data)=>{
			getBlockAndMarkList();
		});
	})
	//차단 추가/삭제
	$('.btn-block').click(function(){
		data = {
			bl_me_num : ${user.me_num},
			bl_blocked_num : ${member.me_num}
		}
		ajaxJsonToJson(false, 'post', "/member/blockList/process", data,(data)=>{
			getBlockAndMarkList();
		});
	})
	//즐겨찾기, 차단리스트를 가져오는 함수
	function getBlockAndMarkList() {
		let data = { me_num : ${user.me_num}};
		let memberNum = ${member.me_num};
		ajaxJsonToJson(false, 'post', "/member/myBlockAndMarkList", data,(data)=>{
			$(".btn-add").text("즐겨찾기"); 
			$(".btn-block").text("차단하기");
			for(obj of data.blockList){
				if(obj.bl_blocked_num == memberNum){
					$(".btn-block").text("차단됨");
				}
			}
			for(obj of data.markList){
				if(obj.ma_marked_num == memberNum){
					$(".btn-add").text("해제하기");
				}
			}
		});
	}
		
</script>
</html>