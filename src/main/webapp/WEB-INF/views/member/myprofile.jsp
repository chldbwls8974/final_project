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
.time-box{
    margin-bottom: 30px;
    padding: 0;
    border: 0;
    vertical-align: baseline;
}
.chip{
	display: flex; 
	flex-wrap: wrap; 
	overflow: hidden; 
	border-radius: 12px;
	list-style: none;
	padding: 20px;
}
.chip__item--3{
	width: 25%;
    position: relative;
    box-sizing: border-box;
    outline: none;
    margin: 0 auto;
    box-shadow: none;	
    margin: 0;
    vertical-align: baseline;
}
.chip_item-radio{
	position: absolute;
	display: none;
    opacity: 0;
    background-color: #F2F5F7;
    width: 100%;
    height: 100%;
}
.chip__item-label div{ margin-top: 10px;}
.chip__item-radio+label{
	position: relative;
	width: 200px;
    height: 48px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    color: #4B5A64;
    background-color: #FFFFFF;
    border: 1px solid #D9E0E6;
    border-radius: 20px;
    margin: 5px;
    margin-left: 0px;
    display: flex;
    justify-content: center;
    flex-direction: column;
}
input[type='checkbox']{
	display : none;
}
input[type='checkbox']:checked+label{
	display: inline-block;
	color: #1570FF;
    border: 1px solid #1570FF;
}


.container{ 
	background-color: #f2f2f2; padding: 30px; z-index: 1;
	margin-top: 20px; border-radius: 20px;
}
.form-control{border-radius: 30px; width: 500px;}
.form-group{text-align: center;}
.form-group label{display: inline-block; text-align: center;}
.form-group button, .form-group select{margin: 0 auto;}
.form-group input{margin: 0 auto;}

.signup-btn{ width: 500px; margin: 0 auto;
	border-radius: 10px; border: none;
	background-color: #0c0c0c; height: 40px; color: white;}
.next-btn, .prev-btn{width: 500px; margin: 0 auto;
	border-radius: 10px; border: none; height: 40px;
	background-color: #c2f296; color: black;}

input, progress {
  accent-color: #0c0c0c;
}

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
			<img src="<c:url value='/memberimg${member.me_profile}'/>" class="myprofile-image-thumb" alt="프로필 사진">
			<p class="title">${member.me_name }</p> 
			<p style="color: #777777; font-size: 18px;">${member.me_id}</p>
			<div class="myedit">
				<a href="<c:url value='/member/myedit?me_num=${member.me_num}'/>" class="myprofile-btn">
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
			<div class="form-group time-box weekday-time">
				<label style="font-size: 20px; font-weight: bolder; margin-bottom: 10px;">평일 선호 시간</label>
				<ul class="chip">
					
					<li class="chip__item--3">
						<input type="checkbox" id="time_6" name="favoriteTime" class="chip__item-radio" value="6" <c:if test="${weekTime.contains(Integer(6))}">checked</c:if>  disabled="disabled"> 
						<label for="time_6" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunrise.svg">
							</div> 06:00
						</label>
					</li>
					<li class="chip__item--3">
						<input type="checkbox" id="time_8" name="favoriteTime" class="chip__item-radio" value="8" <c:if test="${weekTime.contains(Integer(8))}">checked</c:if>  disabled="disabled"> 
						<label  for="time_8" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 08:00
						</label>
					</li>
					<li class="chip__item--3">
						<input type="checkbox" id="time_10" name="favoriteTime" class="chip__item-radio" value="10" <c:if test="${weekTime.contains(Integer(10))}">checked</c:if>  disabled="disabled"> 
						<label for="time_10" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 10:00
                		</label>
                	</li>
					<li class="chip__item--3">
						<input  type="checkbox" id="time_12" name="favoriteTime" class="chip__item-radio" value="12" <c:if test="${weekTime.contains(Integer(12))}">checked</c:if>  disabled="disabled"> 
						<label  for="time_12" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 12:00
                		</label>
               		</li>
					<li class="chip__item--3">
						<input type="checkbox" id="time_14" name="favoriteTime" class="chip__item-radio" value="14" <c:if test="${weekTime.contains(Integer(14))}">checked</c:if>  disabled="disabled"> 
						<label for="time_14" class="chip__item-label" style="height: 70px;">
						<div style="margin-bottom: 5px;">
							<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
						</div> 14:00
                		</label>
               		</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="time_16" name="favoriteTime" class="chip__item-radio" value="16" <c:if test="${weekTime.contains(Integer(16))}">checked</c:if>  disabled="disabled">
						<label  for="time_16" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 16:00
                		</label>
                	</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="time_18" name="favoriteTime" class="chip__item-radio" value="18" <c:if test="${weekTime.contains(Integer(18))}">checked</c:if>  disabled="disabled"> 
						<label  for="time_18" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 18:00
                		</label>
               		</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="time_20" name="favoriteTime" class="chip__item-radio" value="20" <c:if test="${weekTime.contains(Integer(20))}">checked</c:if>  disabled="disabled"> 
						<label  for="time_20" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 20:00
               			</label>
        			</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="time_22" name="favoriteTime" class="chip__item-radio" value="22" <c:if test="${weekTime.contains(Integer(22))}">checked</c:if>  disabled="disabled"> 
						<label  for="time_22" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 22:00
               			</label>
           			</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="time_24" name="favoriteTime" class="chip__item-radio" value="0" <c:if test="${weekTime.contains(Integer(0))}">checked</c:if>  disabled="disabled">
						<label  for="time_24" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
							</div> 24:00
               			</label>
               		</li>
                	<li  class="chip__item--3">
                			<input  type="checkbox" id="time_2" name="favoriteTime" class="chip__item-radio" value="2" <c:if test="${weekTime.contains(Integer(2))}">checked</c:if>  disabled="disabled"> 
                		<label  for="time_2" class="chip__item-label" style="height: 70px;">
                			<div  style="margin-bottom: 5px;">
                				<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
               				</div> 02:00
                		</label>
                	</li>
                	<li  class="chip__item--3">
                		<input  type="checkbox" id="time_4" name="favoriteTime" class="chip__item-radio" value="4" <c:if test="${weekTime.contains(Integer(4))}">checked</c:if>  disabled="disabled">
                		<label  for="time_4" class="chip__item-label" style="height: 70px;">
                		<div  style="margin-bottom: 5px;">
                			<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
               			</div>  04:00
              			</label>
           			</li>
                </ul>
			</div>
		</div>
		<div class="form-group">
			<label>주말 선호 시간대</label>
			<div style="display: flex; justify-content: center;">
				<ul class="chip">
					<li class="chip__item--3">
						<input type="checkbox" id="holitime_6" name="favoriteHoliTime" class="chip__item-radio" value="6" <c:if test="${holiTime.contains(Integer(6))}">checked</c:if> disabled="disabled"> 
						<label for="holitime_6" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunrise.svg">
							</div> 06:00
						</label>
					</li>
					<li class="chip__item--3">
						<input type="checkbox" id="holitime_8" name="favoriteHoliTime" class="chip__item-radio" value="8" <c:if test="${holiTime.contains(Integer(8))}">checked</c:if> disabled="disabled"> 
						<label  for="holitime_8" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 08:00
						</label>
					</li>
					<li class="chip__item--3">
						<input type="checkbox" id="holitime_10" name="favoriteHoliTime" class="chip__item-radio" value="10" <c:if test="${holiTime.contains(Integer(10))}">checked</c:if> disabled="disabled"> 
						<label for="holitime_10" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 10:00
                		</label>
                	</li>
					<li class="chip__item--3">
						<input  type="checkbox" id="holitime_12" name="favoriteHoliTime" class="chip__item-radio" value="12" <c:if test="${holiTime.contains(Integer(12))}">checked</c:if> disabled="disabled"> 
						<label  for="holitime_12" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 12:00
                		</label>
               		</li>
					<li class="chip__item--3">
						<input type="checkbox" id="holitime_14" name="favoriteHoliTime" class="chip__item-radio" value="14" <c:if test="${holiTime.contains(Integer(14))}">checked</c:if> disabled="disabled"> 
						<label for="holitime_14" class="chip__item-label" style="height: 70px;">
						<div style="margin-bottom: 5px;">
							<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
						</div> 14:00
                		</label>
               		</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="holitime_16" name="favoriteHoliTime" class="chip__item-radio" value="16" <c:if test="${holiTime.contains(Integer(16))}">checked</c:if> disabled="disabled">
						<label  for="holitime_16" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 16:00
                		</label>
                	</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="holitime_18" name="favoriteHoliTime" class="chip__item-radio" value="18" <c:if test="${holiTime.contains(Integer(18))}">checked</c:if> disabled="disabled"> 
						<label  for="holitime_18" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 18:00
                		</label>
               		</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="holitime_20" name="favoriteHoliTime" class="chip__item-radio" value="20" <c:if test="${holiTime.contains(Integer(20))}">checked</c:if> disabled="disabled"> 
						<label  for="holitime_20" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 20:00
               			</label>
        			</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="holitime_22" name="favoriteHoliTime" class="chip__item-radio" value="22" <c:if test="${holiTime.contains(Integer(22))}">checked</c:if> disabled="disabled"> 
						<label  for="holitime_22" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 22:00
               			</label>
           			</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="holitime_24" name="favoriteHoliTime" class="chip__item-radio" value="0" <c:if test="${holiTime.contains(Integer(0))}">checked</c:if> disabled="disabled">
						<label  for="holitime_24" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
							</div> 24:00
               			</label>
               		</li>
                	<li  class="chip__item--3">
                		<input  type="checkbox" id="holitime_2" name="favoriteHoliTime" class="chip__item-radio" value="2" <c:if test="${holiTime.contains(Integer(2))}">checked</c:if> disabled="disabled"> 
                		<label  for="holitime_2" class="chip__item-label" style="height: 70px;">
                			<div  style="margin-bottom: 5px;">
                				<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
               				</div> 02:00
                		</label>
                	</li>
                	<li  class="chip__item--3">
                		<input  type="checkbox" id="holitime_4" name="favoriteHoliTime" class="chip__item-radio" value="4" <c:if test="${holiTime.contains(Integer(4))}">checked</c:if> disabled="disabled"> 
                		<label  for="holitime_4" class="chip__item-label" style="height: 70px;">
                		<div  style="margin-bottom: 5px;">
                			<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
               			</div>  04:00
              			</label>
           			</li>
                </ul>
			</div>
		</div>
	
	</div>
	<hr>
</div>
</body>
<script type="text/javascript">

	// 수정사항 실시간 적용
	$(document).ready(function() {
		getUserInformation()
	});
	

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