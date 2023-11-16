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
.next-btn, .prev-btn{width: 500px; margin: 0 auto;
	border-radius: 10px; border: none; height: 40px;
	background-color: #c2f296; color: black;}

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
				<input type="email" class="form-control" name="me_email" id="me_email" value="${user.me_email}" readonly> 
				<button type="button" class="form-control" name="email-change-btn" style="margin-bottom: 20px;">이메일 변경</button>
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

	const nextBtn = document.getElementById("next");
	const signUpBtn = document.getElementById("signup");
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
	$(document).on('keyup','#me_email',function(){
		let email = $(this).val();
		
		let flag = false;
		
		var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		if(!regEmail.test(email)){
			codeSendBtn.disabled = true;
			$('#check-email-error').text('');
			return;
		}
		
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
						$('#check-email-error').text('이미 사용중인 이메일입니다.');
					}
				}
			});
		}
		
		
	})
	
	
	// 인증번호 전송 버튼을 누르면 서버로 이메일주소와 코드 보내주고 타이머 시작
	$(document).on('click','[name=me_email_btn]',function(){
		time = 30; // 유효시간 여기서 설정 - 지금은 테스트를 위해서 5초
		randomCode = generateRandomCode(6); 
		
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
		const email = $('[name=me_email]').val();
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
			nextBtn.disabled = false;
			signUpBtn.disabled = false;
			clearInterval(x);
			codeSendBtn.innerHTML = "인증완료"
			document.getElementById("timer").textContent ="인증완료";
		}
	})
	
	
	// 페이지 이전, 다음버튼
	$('.2p').hide();
	$('.prev-btn').hide();
	$(document).on('click','.next-btn',function(){
		$('.1p').hide();
		$(this).hide();
		$('.prev-btn').show();
		$('.2p').show();
		$('.title').hide();
	})
	$(document).on('click','.prev-btn',function(){
		$('.2p').hide();
		$(this).hide();
		$('.1p').show();
		$('.next-btn').show();
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
	
	
	
	
	// 선호 지역 대분류에 따른 소분류
	 $(document).on('change','.pre_rg_main',function(){
		 let th = $(this);
		 rg_main = th.val();
		 console.log(rg_main)
		 data={
			 rg_main : rg_main
		}
		ajaxJsonToJson2(false, 'get', '/member/signup/region', data, (a)=>{
			var option = "";
			th.parent().next().find('[name=pr_rg_num]').empty();
			
			for (var i in a.SubRegion){
				var obj = a.SubRegion[i];
				option = "<option value='" + obj.rg_num + "'>" + obj.rg_sub + "</option>";
				th.parent().next().find('[name=pr_rg_num]').append(option)
			}
			
		})
		
	   });
	
	// 선호지역 추가 버튼
	 $(document).on('click','[name=add-area-btn]',function(){
		 count++;
		 console.log(count)
		 if(2 >= count){
			 str='';
			 btn='';
			 str+=`
			 	<hr>
				 <div class="prefer-area">
					<div class="form-group">
						<label>선호지역</label> <select class="form-control pre_rg_main">
							<option value="0">지역을 선택하세요</option>
							<c:forEach items="${MainRegion}" var="main">
								<option value="${main.rg_main}">${main.rg_main}</option>
							</c:forEach>
						</select>

					</div>
					<div class="form-group">
						<select class="form-control rg_sub" name="pr_rg_num">
							<option value="0">지역을 선택하세요</option>
							<c:forEach items="${SubRegion}" var="sub">
								<option value="${sub.rg_num}">${sub.rg_sub}</option>
							</c:forEach>
						</select>
					</div>
				</div>

			 `;
			btn+=`
			<div class="form-group">
				<button type="button" class="form-control" name="add-area-btn">지역 추가</button>
				</div>
			`; 
			$(this).hide();
			$(this).after(str);
			$(this).after(btn);
		 }
	 })
	
	
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
						$('#check-nickName-error').text('이미 사용중인 닉네임입니다.');
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
		
		
		// 지역
		//페이지가 완전히 로드되면 실행 = jQuery의 $(document).ready()와 동일한 역할
		$(function(){	
	         //rg_main에서 change 이벤트가 발생되면 실행
			 $(document).on('change','.rg_main',function(){
				 //변수 생성 -> 현재 이벤트가 발생한 rg_main의 select 요소를 객체로 가져옴
				 let th = $(this);
				 //선택한 옵션 값을 가져와서 rg_main 변수에 저장
				 rg_main = th.val();
				 
				 data={
					 rg_main : rg_main
				}
				//각 지역별 도시 선택 
				ajaxJsonToJson2(false, 'get', '/member/update/region2', data, (a)=>{
					var option = "";
					// name이 'fa_rg_num'인 요소를 찾고, 그 안의 내용을 비움
					th.parent().next().find('[name=me_rg_num]').empty();
					//facility.fa_rg_num의 값을 변수 region에 할당
					let region = '${member.me_rg_num}'
					
					for (var i in a.SubRegion){
						var obj = a.SubRegion[i];
			            // 'selected' 속성을 사용하여 선택된 항목 표시
						if (obj.rg_num == region) {
			                option = "<option value='" + obj.rg_num + "' selected>" + obj.rg_sub + "</option>";
			            } else {
			                option = "<option value='" + obj.rg_num + "'>" + obj.rg_sub + "</option>";
			            }
			            th.parent().next().find('[name=me_rg_num]').append(option);
			        }
			    })
			});
	         //트리거를 통해 rg_main의 모든 select 요소에 대해 change 이벤트를 수동으로 발생. 
	         //=> 이벤트가 발생하면 선택한 옵션에 따라 다른 도시를 로드하고 옵션을 설정함
			$(".rg_main").trigger('change')
	    })
	
	</script>
</body>
</html>