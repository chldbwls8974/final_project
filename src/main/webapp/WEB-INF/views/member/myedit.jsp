<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/validate.js/0.12.0/validate.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- 데이트피커 디자인 -->	
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<style type="text/css">
	.error {
		color: #f00;
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
	
	input, progress {
	  accent-color: #0c0c0c;
	}
	.input-file{
		display: none;
	}
	.btn-file{
		width: 200px; height: 200px; border-radius: 50%;
		border: 1px solid gray;
		font-weight: fold; font-size: 30px;
		line-height:200px; text-align: center; display: block; text-decoration: none; color: gray;	
		position: relative; overflow: hidden;
		margin: 0 auto;
	}
	.box-thumbnail{
		display: none; position: absolute; top: 0; 
	}
	/* 모달 */
	.modal--bg {
		z-index: 1000;
		display: none;
		position: fixed;
		top: 0%;
		left: 0%;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.3);
		justify-content: center;
		align-items: center;
	}
	
	.modal--content {
		background-color: white;
		padding: 20px;
		border-radius: 5px;
		max-width: 600px;
		margin: 200px auto;
	}
	
</style>
</head>
<body>
<div class="container">
	<p class="title" style="font-size: 45px; font-weight: bolder; padding-bottom: 30px;
		text-align: center; letter-spacing: -3px;">프로필 수정</p>
	<form action="<c:url value='/member/myedit'/>" method="post" id="myForm" enctype="multipart/form-data" style="text-align: center;">
		<div class="1p">
		<input type="hidden" name="me_num" value="${user.me_num}">
		<input type="hidden" name="test" value="${user.me_profile}">
		<input type="hidden" name="ori_nick" value="${user.me_nickname}">
		<img src="<c:url value='/memberimg${user.me_profile}'/>" name="profile" height="200" width="200">
			<div class="form-group">
				<input type="file" class="input-file" name="img" id="img" onchange="readUrl(this)">
					<a href="#" class="btn-file">+
						<div class="box-thumbnail">
							<img src="<c:url value='/memberimg${user.me_profile}'/>" id="preview" height="200" width="200">
						</div>
					</a>
			</div>
			<div class="form-group">
				<label>닉네임</label> <label id="check-nickName-error" class="error" for="me_nickname"></label> 
				<input type="text" class="form-control" name="me_nickname" maxlength="15" value="${user.me_nickname}" required>
			</div>
			<hr>
			<div class="form-group">
				<label>이메일</label> 
				<input type="email" class="form-control" name="ori_email" value="${user.me_email}" readonly> 
				<button type="button" class="form-control button--open" name="email-change-btn" style="margin-bottom: 20px;">이메일 변경</button>
			</div>
			
			
<!-- 이메일 변경 모달창 -->
			<div class="modal--bg">
				<div class="modal--content">
					<p style="font-size: 20px; font-weight: bolder; margin: 20px auto; border-bottom: 8px solid #c2f296; width: 30%; padding: 20px 0 10px 0; text-align: center;">이메일 변경</p>
					
					<form class="modal-form" action="#" method="post" id="innerForm">
						
						
						<div class="form-group">
							<label>이메일</label>
							 <input type="email" class="form-control" name="email" id="email" placeholder="${user.me_email}" required> 
							 <label id="check-email-error" class="error"for="email"></label>
							 <button type="button" class="form-control" name="me_email_btn" id="me_email_btn" style="margin-bottom: 20px;">인증번호 전송</button>
								
							<label>이메일 인증번호</label> 
							<input type="number" class="form-control" name="email_code" id="email_code" required>
							<button type="button" class="form-control" name="email_code_btn"
								id="email_code_btn" disabled="disabled">인증번호 확인</button>
							<div id="timer"></div>
						</div>
						
						<div style="text-align: center; margin-top: 40px;">
							<button type="button" style="background-color: black; color: white; border-radius: 10px; width: 80px;" class="btn button--close">닫기</button> 
							<button type="button"  style="background-color: black; color: white; border-radius: 10px; width: 80px;" 
							class="btn" id="md_update_btn" disabled="disabled" onclick="submitForm()">수정</button> 
						</div>	
					</form> 
				</div>
			</div>
			
			
			

			<div class="form-group">
				<label>전화번호</label> <input type="text" class="form-control" name="me_phone" id="me_phone" value="${user.me_phone}" required>
			</div>

			<div class="form-group">
				<label>이름</label> <input type="text" class="form-control"
					name="me_name" id="me_name" value="${user.me_name}" required>
			</div>

			<div class="form-group1" style="text-align: center; margin-bottom: 20px;">
				<label>성별</label>
				<div style="display: flex; justify-content: center;">
					<div style="padding-right: 25px;">
						<input type="radio" name="me_gender" value="M" <c:if test="${user.me_gender=='M'}">checked</c:if>>남
					</div>
						<input type="radio" name="me_gender" value="F" <c:if test="${user.me_gender=='F'}">checked</c:if>>여
				</div>
			</div>

			<div class="form-group">
				<label>생년월일</label> 
				<input type="text" class="form-control" name="me_birthday" id="me_birthday" placeholder="날짜를 선택하세요." value="${user.me_birthday }" style="text-align: center;" required>
			</div>

			
			<div class="form-group">
				<label>거주지</label> <select class="form-control rg_main" required>
					<option value="">지역을 선택하세요</option>
					<c:forEach items="${MainRegion}" var="main">
						<option value="${main.rg_main}">${main.rg_main}</option>
					</c:forEach>
				</select>

			</div>
			<div class="form-group" style="margin-bottom: 60px;">
				<select class="form-control rg_sub" name="me_rg_num" required>
					<option value="">지역을 선택하세요</option>
					<c:forEach items="${SubRegion}" var="sub">
						<option value="${sub.rg_num}">${sub.rg_sub}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<button class="signup-btn" id="signup">수정</button>
	</form>
</div>	
	
	<script type="text/javascript">
	
	const codeSendBtn = document.getElementById("me_email_btn");
	const checkCode = document.getElementById("email_code");
	const checkCodeBtn = document.getElementById("email_code_btn");
	const updateBtn = document.getElementById("md_update_btn");
	
	let email = $('#email').val();
	let ori_email = $('[name=ori_email]').val();
	let randomCode;
	let x;
	let count = 0;
	let time;
	var min = ""; // 분
	var sec=""; // 초
	
	// 6자리 난수 생성 함수
    function generateRandomCode(length) {
        const chars = "0123456789";
        let randomCode = "";
        for (let i = 0; i < length; i++) {
            const index = Math.floor(Math.random() * chars.length);
            randomCode += chars.charAt(index);
        }
        return randomCode;
    }
	
	
	// 이메일 입력 시 중복이 아니면 전송 버튼 활성화
	$(document).on('keyup','#email',function(){
		let email = $(this).val();
		let ori_email = $('[name=ori_email]').val();
		let flag = false;
		
		var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		// 이메일 정규표현식
		if(!regEmail.test(email)){
			codeSendBtn.disabled = true;
			$('#check-email-error').text('');
			return;
		}
		
		// 이메일 중복 체크
		if(email != ''){
			
			$.ajax({
				async : false, 
				type : 'post', 
				url : '<c:url value="/member/check/email"/>', 
				data : {email : email}, 
				success : function(data){
					if(data){
						codeSendBtn.disabled = false;
						$('#check-email-error').text('사용 가능한 이메일입니다.');
						flag = true;
						
					}else{
							codeSendBtn.disabled = true;
						if(email == ori_email){
							$('#check-email-error').text('사용중인 이메일과 같습니다. 이메일을 확인해주세요.');
						}else{
							$('#check-email-error').text('이미 사용중인 이메일입니다.');
						}
					}
				}
			});
		}
	})
	
	
	// 인증번호 전송 버튼을 누르면 서버로 이메일주소와 코드 보내주고 타이머 시작
	$(document).on('click','[name=me_email_btn]',function(){
		time = 30; // 유효시간 여기서 설정 - 지금은 테스트를 위해서 5초
		randomCode = generateRandomCode(6); 
	
		
		if(email == ori_email){
			alert('같은메일')
		}
		// 타이머 시작
		x = setInterval(function(){
			min = parseInt(time/60);
			sec = time % 60;
			
			document.getElementById("timer").innerHTML = min + "분" + sec + "초";
			time--;
			
			if(time < 0){
				clearInterval(x);
				document.getElementById("timer").textContent ="시간초과";
				checkCodeBtn.disabled = true;
				codeSendBtn.innerHTML = "인증번호 재전송"
			}
		},1000);
		
		// 지워도 됨
		console.log(randomCode)
		
		// 인증버튼 활성화
		checkCodeBtn.disabled = false;
		
		// 값
		const checkEmail = $('[name=email_code]').val();
		
		// ajax로 보내줄 data
		data ={
				to : email,
				randomCode : randomCode
		}
		
		// ajax
		ajaxJsonToJson2(false, 'get','/member/signup/checkmail?email'+email,data,(a)=>{
			
		})
	})
	
	
	
	// 인증번호가 맞는지 확인
	$(document).on('click','[name=email_code_btn]',function(){
		
		let inputCode = $('[name=email_code]').val()
		if(inputCode != randomCode){
			alert('인증번호를 확인해주세요')
		}else{
			alert('인증되었습니다')
			clearInterval(x);
			updateBtn.disabled = false;
			codeSendBtn.innerHTML = "인증완료"
			document.getElementById("timer").textContent ="인증완료";
		}
	})
	
	


	
	// 지역 대분류 선택 시 해당하는 소분류 가져오기
	 $(document).on('change','.rg_main',function(){
		 let th = $(this);
		 rg_main = th.val();
		 console.log(rg_main)
		 data={
			 rg_main : rg_main
		}
		
		ajaxJsonToJson2(false, 'get', '/member/signup/region', data, (a)=>{
			var option = "";
			th.parent().next().find('[name=me_rg_num]').empty();
			
			for (var i in a.SubRegion){
				var obj = a.SubRegion[i];
				option = "<option value='" + obj.rg_num + "'>" + obj.rg_sub + "</option>";
				th.parent().next().find('[name=me_rg_num]').append(option)
			}
			
		})
		
	   });
	
	

	 // 데이트피커
	 $(document).ready(function(){
		$("#me_birthday").flatpickr({
			  showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
              // buttonImage: "/application/db/jquery/images/calendar.gif", // 버튼 이미지
              //buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
              locale: 'ko',
              altInput: true, // 선택한 날짜를 입력란에 보여주도록 설정
              altFormat: "yy-mm-dd", // 입력란에 표시될 날짜 형식 설정
              changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
              changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
              minDate: '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.
              maxDate: 'today',
              nextText: '다음 달', // next 아이콘의 툴팁.
              prevText: '이전 달', // prev 아이콘의 툴팁.
              numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
              stepMonths: 1, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
              yearRange: 'c-100:c+100', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
              showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. ( ...으로 표시되는부분이다.) 
              closeText: '닫기',  // 닫기 버튼 패널
              showAnim: "slide", //애니메이션을 적용한다.  
              showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
	        })
		})
		
	$( function() {
    $( "#me_birthday" ).flatpickr({ 
        onSelect: function() { 
            var date = $.flatpickr.formatDate("yymmdd",$("#datepicker").flatpickr("getDate")); 
            alert(date);
        }
	    });                    
	});

		
		
		
		// 닉네임 중복 검사
		$('[name=me_nickname]').keyup(function(){
			flag = false;
			let nickname = $(this).val();
			let ori_nick = $('[name=ori_nick]').val();
			var reNick = /^.{1,20}$/
				if(!reNick.test(nickname)){
					$('#check-nickName-error').text('');
					return;
				}
			if(nickname != ''){
				$.ajax({
				async : false, 
				type : 'post', 
				url : '<c:url value="/member/check/nickname"/>', 
				data : { nickname : nickname}, 
				success : function(data){
					if(data){
						$('#check-nickName-error').text('사용 가능한 닉네임입니다.');
						flag = true;
					}else{
						if(nickname == ori_nick){
							$('#check-nickName-error').text('');
							flag = true;
						}else{
							$('#check-nickName-error').text('이미 사용중인 닉네임입니다.');
						}
					}
				}
			});
			}else{
				$('#check-nickName-error').text('');
			}
			
		})
		
		// 프로필사진 미리보기
			$('.btn-file').click(function(){
			$('.input-file').click();
			$('.box-thumbnail').show();
			$(this).css('boder' ,'none');
		})

		function readUrl(input){
			//input 태그가 첨부파일이고, 첨부파일이 선택되면
			if(input.files && input.files[0]){
				let reader = new FileReader();
				reader.onload = function(e){
					document.getElementById('preview').src = e.target.result;
				}
				reader.readAsDataURL(input.files[0]);
			}
			//첨부파일이 선택되지 않으면
			else{
				document.getElementById('preview').src = '<c:url value="/memberimg${user.me_profile}"/>';
			}
		}
		
		

	
		
		// 이메일 변경 모달 여닫기
		 $(document).ready(function() {
	        $('.button--open').click(function() {
	            showModal();
	        });

	        $('.button--close').click(function() {
	            closeModal();
	        });

	        
	    });
		
		// 이중 폼 제출
		 function submitForm() {
			let email = $('#email').val();
			let me_num = $('[name=me_num]').val();
			let ori_email = $('[name=ori_email]').val();
			data = {
					email : email,
					me_num : me_num
			}
			ajaxJsonToJson2(false, 'post', '/member/update/email', data, (a)=>{
				if(a){
					closeModal();
					alert("이메일이 수정되었습니다.")
					 $('[name=ori_email]').attr("value",email);
				}else{
					alert("이메일이 수정에 실패하였습니다")
				}
			})
			
		  }
		
		
		function showModal() {
            $('.modal--bg').fadeIn();
        }

        function closeModal() {
            $('.modal--bg').fadeOut();
        }
	</script>
</body>
</html>