<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 프로필 수정</title>
<style type="text/css">
.myprofile-photo{ border-radius: 30px; background-color: #f0f0f0; height: 100%;
	margin-top: 20px;
}
.profileImage, .fileup-btn, .filereset-btn{
	border-radius: 5px;
	border: 1px solid #999;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

.myprofile{ margin-bottom: 20px;}	
	
.radio_box { display: inline-block; *display: inline; *zoom: 1; position: relative; padding-left: 25px; margin-right: 10px; cursor: pointer; font-size: 14px; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; }

/* 기본 라디오 버튼 숨기기 */
.radio_box input[type="radio"] { display: none; }

/* 선택되지 않은 라디오 버튼 스타일 꾸미기 */
.on { width: 20px; height: 20px; background: #ddd; border-radius: 50%; position: absolute; top: 0; left: 0; }

/* 선택된 라디오 버튼 스타일 꾸미기 */
.radio_box input[type="radio"]:checked + .on { background: #c2f296; }
.on:after { content: ""; position: absolute; display: none; }
.radio_box input[type="radio"]:checked + .on:after { display: block; }
.on:after { width: 10px; height: 10px; background: #fff; border-radius: 50%; position: absolute; left: 5px; top: 5px; }
	
.select-img{ width: 400px; margin: 20px 0;}
.form-control{border-radius: 30px; width: 500px; margin: 0 auto;}
#check-btn{ margin-top: 20px;}
.btn{width: 500px; margin: 0 auto;
border-radius: 10px; border: none; height: 40px; margin-top: 10px;
background-color: #c2f296; color: black;}

</style>
</head>
<body>
	<form class="myprofile-photo" action="<c:url value='/member/myedit'/>"
		method="post" enctype="multipart/form-data" style="text-align: center;">			
	  <p class="title" style="font-size: 45px; font-weight: bolder;
		padding: 140px 0 20px 0; text-align: center;">내 정보 수정</p>
		<div class="myprofile">
			<input type="file" name="profileImage" class="profileImage" id="profileUpdate">
			<div class="select-img">
				<img src="${user.me_profile}">
			    <input type="hidden" class="myprofile" value="${user.me_profile}"/>
			    <input type="hidden" class="myprofile-thumb" value="${user.me_profile}"/>
			</div> 
		</div>	
        <hr>

        <input type="hidden" id="id" value="${member.me_id}" readonly >

        <div class="myprofile">
            <label for="nickname">닉네임</label>
            <input type="text" class="form-control" name="input-nickname" placeholder="${user.me_nickname}">
  			<button type="button" class="form-control" name="check-btn" id="check-btn">확인</button>
        </div>
        <div class="myprofile">
			<label for="M" class="radio_box">
				<input type="radio" id="M" name="gener" value="M" checked="checked"/>
				<span class="on"></span>
				남
			</label>
			<label for="F" class="radio_box">
				<input type="radio" id="F" name="gener" value="F" />
				<span class="on"></span>
				여
			</label>
        </div>
		<div>
		<button class="btn">수정</button>
		</div>
	</form>
</body>
<script type="text/javascript">

	$("#myprofile").change(function(){
	   if(this.files && this.files[0]) {
	    var reader = new FileReader;
	    reader.onload = function(data) {
	     $(".select_img img").attr("src", data.target.result).width(500);        
	    }
	    reader.readAsDataURL(this.files[0]);
	   }
	  });

	//존재하는 닉네임인지 아닌지 확인
	let isSpanAdded = false;
	$(document).on('click','[name=check-btn]',function(){
		let check=$('[name=input-nickname]').val();
		
		// 입력값이 공백인지 확인
	    if (check.trim() === '') {
	        alert('닉네임을 입력해주세요.'); // 공백이면 메시지
	        return;
	    }
		
		data={
				check : check
		}
		
		var str = '';
		ajaxJsonToJson2(false, 'get','/member/signup/check',data,(a)=>{
			console.log(a)
			if (!isSpanAdded) { //안내문구가 없으면
				str = '<span id="nickname-message"></span>';
				$(this).after(str); //확인버튼 뒤에 추가
				isSpanAdded = true; //스팬 중복추가 방지
			}
				if(a.checked == null){
					$('#nickname-message').text('사용 가능한 닉네임입니다.');
				}else{
		            $('#nickname-message').text('이미 사용 중인 닉네임입니다.');
				}
		});
	});
	
	//성별정보
	$(document).ready(function(){
		// 회원의 성별정보를 가져옴
	 	var savedGender = "${user.me_gender}";
	 	console.log(savedGender);
	
		// 라디오 버튼을 가져옴
		var genderBtn= document.getElementsByName("me_gender");
	
		// 저장된 성별 정보와 일치하는 버튼을 체크
		for (var i = 0; i < genderBtn.length; i++) {
		    if (genderBtn[i].value === savedGender) {
		    	genderBtn[i].checked = true;
		        // 일치하는 값을 찾으면 종료
		        break;
		    }
		}
	})
	
	
	
</script>
</html>