<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 프로필 수정</title>
<style type="text/css">
	.profileImage, .fileup-btn, .filereset-btn{
		border-radius: 5px;
		border: 1px solid #999;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
</style>
</head>
<body>
	<form class="myprofile-photo" action="<c:url value='/member/myedit'/>" method="post" enctype="multipart/form-data">			
	  <h3>내 정보 수정</h3>
		<div class="myprofile">
			<input type="file" name="profileImage" class="profileImage" id="profileUpdate">
			<img src="${user.me_profile}">
		    <input type="submit" class="fileup-btn" value="사진 수정" >
		    <input type="button" class="filereset-btn" value="초기화" onclick="">
		</div>	
        <hr>

        <input type="hidden" id="id" value="${member.me_id}" readonly >

        <div class="myprofile">
            <label for="nickname">닉네임</label>
            <input type="text" class="form-control" name="input-nickname" placeholder="${user.me_nickname}">
  			<button type="button" class="form-control" name="check-btn">확인</button>
        </div>
        <div class="myprofile">
            <label for="gender">성별</label>
			<input type="radio" name="me_gender" value="M">남
			<input type="radio" name="me_gender" value="F">여
        </div>
        <div class="myprofile">
            <label for="email">이메일</label>
            <input type="email" class="form-control" id="email" placeholder="${user.me_email}">
        </div>
		<div>
		<button class="btn-update col-12">수정</button>
		</div>
	</form>
</body>
<script type="text/javascript">

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