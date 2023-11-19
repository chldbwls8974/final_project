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

</style>
</head>
<body>
<div class="container">
	<p class="title" style="font-size: 45px; font-weight: bolder; padding-bottom: 30px;
		text-align: center; letter-spacing: -3px;">회원가입</p>
	<form action="<c:url value='/member/signup'/>" method="post" id="myForm" style="text-align: center;">
		<input type="hidden" value="/basic.jpg" name="me_profile">
		
		<div class="1p">
			<div class="form-group">
				<label>아이디</label>  <input type="text" class="form-control"
					name="me_id" id="me_id" required> <label id="check-id-error" class="error"
					for="me_id"></label>
			</div>

			<div class="form-group">
				<label>비밀번호</label> <input type="password" class="form-control"
					name="me_pw" id="me_pw" required> <label id="check-pw-error" class="error"
					for="me_pw"></label>
			</div>

			<div class="form-group">
				<label>비밀번호 확인</label> <input type="password" class="form-control"
					name="me_pw2" id="me_pw2" required> <label id="check-pw2-error" class="error"
					for="me_pw2"></label>
			</div>

			<div class="form-group">
				<label>이메일</label> <input type="email" class="form-control"
					name="me_email" id="me_email" required> <label id="check-email-error" class="error"
					for="me_email"></label>
				<button type="button" class="form-control" name="me_email_btn"
					id="me_email_btn" disabled="disabled" style="margin-bottom: 20px;">인증번호 전송</button>
					
				<label>이메일 인증번호</label> <input type="number" class="form-control" name="email_code"
					id="email_code" required>
				<button type="button" class="form-control" name="email_code_btn"
					id="email_code_btn" disabled="disabled">인증번호 확인</button>
				<div id="timer"></div>
			</div>

			<div class="form-group">
				<label>전화번호</label> <input type="text" class="form-control"
					name="me_phone" id="me_phone" required>
			</div>

			<div class="form-group">
				<label>이름</label> 
				<input type="text" class="form-control" name="me_name" id="me_name" maxlength="10" required>
			</div>

			<div class="form-group1" style="text-align: center; margin-bottom: 20px;">
				<label>성별</label>
				<div style="display: flex; justify-content: center;">
					<div style="padding-right: 25px;">
						<input type="radio" name="me_gender" value="M">남
					</div>
					<input type="radio" name="me_gender" value="F">여
				</div>
			</div>

			<div class="form-group">
				<label>생년월일</label> <input type="text" class="form-control"
					name="me_birthday" id="me_birthday"
					placeholder="날짜를 선택하세요." style="text-align: center;" required>
			</div>

			<div class="form-group">
				<label>닉네임</label> <label id="check-nickName-error" class="error"
					for="me_nickname"></label> <input type="text" class="form-control"
					name="me_nickname" maxlength="15" maxlength="15" required>
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

		<!-- 다음버튼 -->
		<div class="form-group">
			<button type="button" class="next-btn" id="next"
				disabled="disabled">다음</button>
		</div>

		<!-- 2번째 페이지 -->
		<div class="2p">
			<div class="pre_time">
			<div class="form-group time-box weekday-time">
				<label style="font-size: 20px; font-weight: bolder; margin-bottom: 10px;">평일 선호 시간</label>
				<ul class="chip">
					
					<li class="chip__item--3">
						<input type="checkbox" id="time_6" name="favoriteTime" class="chip__item-radio" value="6"> 
						<label for="time_6" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunrise.svg">
							</div> 06:00
						</label>
					</li>
					<li class="chip__item--3">
						<input type="checkbox" id="time_8" name="favoriteTime" class="chip__item-radio" value="8"> 
						<label  for="time_8" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 08:00
						</label>
					</li>
					<li class="chip__item--3">
						<input type="checkbox" id="time_10" name="favoriteTime" class="chip__item-radio" value="10"> 
						<label for="time_10" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 10:00
                		</label>
                	</li>
					<li class="chip__item--3">
						<input  type="checkbox" id="time_12" name="favoriteTime" class="chip__item-radio" value="12"> 
						<label  for="time_12" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 12:00
                		</label>
               		</li>
					<li class="chip__item--3">
						<input type="checkbox" id="time_14" name="favoriteTime" class="chip__item-radio" value="14"> 
						<label for="time_14" class="chip__item-label" style="height: 70px;">
						<div style="margin-bottom: 5px;">
							<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
						</div> 14:00
                		</label>
               		</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="time_16" name="favoriteTime" class="chip__item-radio" value="16">
						<label  for="time_16" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 16:00
                		</label>
                	</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="time_18" name="favoriteTime" class="chip__item-radio" value="18"> 
						<label  for="time_18" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 18:00
                		</label>
               		</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="time_20" name="favoriteTime" class="chip__item-radio" value="20"> 
						<label  for="time_20" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 20:00
               			</label>
        			</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="time_22" name="favoriteTime" class="chip__item-radio" value="22"> 
						<label  for="time_22" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 22:00
               			</label>
           			</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="time_24" name="favoriteTime" class="chip__item-radio" value="0">
						<label  for="time_24" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
							</div> 24:00
               			</label>
               		</li>
                	<li  class="chip__item--3">
                		<input  type="checkbox" id="time_2" name="favoriteTime" class="chip__item-radio" value="2"> 
                		<label  for="time_2" class="chip__item-label" style="height: 70px;">
                			<div  style="margin-bottom: 5px;">
                				<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
               				</div> 02:00
                		</label>
                	</li>
                	<li  class="chip__item--3">
                		<input  type="checkbox" id="time_4" name="favoriteTime" class="chip__item-radio" value="4"> 
                		<label  for="time_4" class="chip__item-label" style="height: 70px;">
                		<div  style="margin-bottom: 5px;">
                			<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
               			</div>  04:00
              			</label>
           			</li>
                </ul>
			</div>
			<div class="form-group time-box weekend-time">
				<label style="font-size: 20px; font-weight: bolder; margin: 10 0 10px;">주말 선호 시간</label>
				<ul class="chip">
					<li class="chip__item--3">
						<input type="checkbox" id="holitime_6" name="favoriteHoliTime" class="chip__item-radio" value="6"> 
						<label for="holitime_6" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunrise.svg">
							</div> 06:00
						</label>
					</li>
					<li class="chip__item--3">
						<input type="checkbox" id="holitime_8" name="favoriteHoliTime" class="chip__item-radio" value="8"> 
						<label  for="holitime_8" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 08:00
						</label>
					</li>
					<li class="chip__item--3">
						<input type="checkbox" id="holitime_10" name="favoriteHoliTime" class="chip__item-radio" value="10"> 
						<label for="holitime_10" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 10:00
                		</label>
                	</li>
					<li class="chip__item--3">
						<input  type="checkbox" id="holitime_12" name="favoriteHoliTime" class="chip__item-radio" value="12"> 
						<label  for="holitime_12" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 12:00
                		</label>
               		</li>
					<li class="chip__item--3">
						<input type="checkbox" id="holitime_14" name="favoriteHoliTime" class="chip__item-radio" value="14"> 
						<label for="holitime_14" class="chip__item-label" style="height: 70px;">
						<div style="margin-bottom: 5px;">
							<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
						</div> 14:00
                		</label>
               		</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="holitime_16" name="favoriteHoliTime" class="chip__item-radio" value="16">
						<label  for="holitime_16" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 16:00
                		</label>
                	</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="holitime_18" name="favoriteHoliTime" class="chip__item-radio" value="18"> 
						<label  for="holitime_18" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 18:00
                		</label>
               		</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="holitime_20" name="favoriteHoliTime" class="chip__item-radio" value="20"> 
						<label  for="holitime_20" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 20:00
               			</label>
        			</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="holitime_22" name="favoriteHoliTime" class="chip__item-radio" value="22"> 
						<label  for="holitime_22" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
							</div> 22:00
               			</label>
           			</li>
					<li  class="chip__item--3">
						<input  type="checkbox" id="holitime_24" name="favoriteHoliTime" class="chip__item-radio" value="0">
						<label  for="holitime_24" class="chip__item-label" style="height: 70px;">
							<div  style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
							</div> 24:00
               			</label>
               		</li>
                	<li  class="chip__item--3">
                		<input  type="checkbox" id="holitime_2" name="favoriteHoliTime" class="chip__item-radio" value="2"> 
                		<label  for="holitime_2" class="chip__item-label" style="height: 70px;">
                			<div  style="margin-bottom: 5px;">
                				<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
               				</div> 02:00
                		</label>
                	</li>
                	<li  class="chip__item--3">
                		<input  type="checkbox" id="holitime_4" name="favoriteHoliTime" class="chip__item-radio" value="4"> 
                		<label  for="holitime_4" class="chip__item-label" style="height: 70px;">
                		<div  style="margin-bottom: 5px;">
                			<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
               			</div>  04:00
              			</label>
           			</li>
                </ul>
                <div>
					 <button type="button" id="reset-btn"  style="background-color: black; color: white; border-radius: 10px; width: 80px;" class="btn">초기화</button>
				</div>
			</div>
		</div>

			 <div class="prefer-area">
						 <div class="form-group"  id="area-box" style="display: block;">
							<div class="form-group" style="display: block;">
								<select class="form-control pre_rg_main">
									<option value="0">대분류를 선택하세요</option>
									<c:forEach items="${MainRegion}" var="main">
										<option value="${main.rg_main}" <c:if test="${list.rg_main == main.rg_main }">selected</c:if>>${main.rg_main}</option>
									</c:forEach>
								</select>
			
							</div>
							<div class="form-group" style="display: block;">
								<select class="form-control rg_sub" name="pr_rg_num">
									<option value="0">소분류를 선택하세요</option>
									<c:forEach items="${subRg}" var="sub">
										<c:if test="${sub.rg_main == list.rg_main}">
											<option value="${sub.rg_num}"<c:if test="${list.rg_num == sub.rg_num }">selected</c:if>>${sub.rg_sub}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>

			<div class="form-group">
				<button type="button" class="form-control" name="add-area-btn">지역
					추가</button>
			</div>

			<div class="form-group" style="margin: 20px; 0 60px 0;">
				<label>추천인 닉네임</label> <input type="text" class="form-control"
					name="recommed_check" id="recommed_check">
				<button type="button" class="form-control" name="recommed_check_btn" style="margin-top: 10px;">입력</button>
			</div>

		</div>
		<div class="form-group">
			<button type="button" class="prev-btn">이전</button>
		</div>
		<button class="signup-btn" id="signup"
			disabled="disabled">회원가입</button>
	</form>
</div>	
	
	<script type="text/javascript">
	

	const password = document.getElementsByName("me_pw")[0].value;
	const passwordConfirm = document.getElementsByName("me_pw2")[0].value;
	const codeSendBtn = document.getElementById("me_email_btn");
	const checkCode = document.getElementById("email_code");
	const checkCodeBtn = document.getElementById("email_code_btn");
	const nextBtn = document.getElementById("next");
	const signUpBtn = document.getElementById("signup");
	let randomCode;
	let x;
	let count = 1;
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
	
	// 추천인 입력
	$(document).on('click','[name=recommed_check_btn]',function(){
		let check=$('[name=recommed_check]').val();
		data={
				check : check
		}
		var str = '';
		ajaxJsonToJson2(false, 'get','/member/signup/check',data,(a)=>{
			$(this).next('span').remove(); //중복추가 방지
			if(a.checked == null){
				str+=`<span>없는 회원입니다.</span>`;
			}else{
				str+=`<span>확인되었습니다.</span>`;
			}
			$(this).after(str);
		})
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
		 
		 if(3 > count){
			 count++;
			 str='';
			 btn='';
			 str+=`
				 <div class="prefer-area">
				 <div class="form-group"  id="area-box" style="display: block;">
					<div class="form-group" style="display: block;">
						<select class="form-control pre_rg_main">
							<option value="0">대분류를 선택하세요</option>
							<c:forEach items="${MainRegion}" var="main">
								<option value="${main.rg_main}" <c:if test="${list.rg_main == main.rg_main }">selected</c:if>>${main.rg_main}</option>
							</c:forEach>
						</select>
	
					</div>
					<div class="form-group" style="display: block;">
						<select class="form-control rg_sub" name="pr_rg_num">
							<option value="0">소분류를 선택하세요</option>
							<c:forEach items="${subRg}" var="sub">
								<c:if test="${sub.rg_main == list.rg_main}">
									<option value="${sub.rg_num}"<c:if test="${list.rg_num == sub.rg_num }">selected</c:if>>${sub.rg_sub}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="form-group" style="display: block;">
						<button type="button" name="area-del-btn" class="form-control" >x</button>
					</div>
				</div>
			</div>


			 `;
			btn+=`
			<div class="form-group">
				<button type="button" class="form-control" name="add-area-btn">지역 추가</button>
				</div>
			`; 
			$(this).hide();
			$(this).before(str);
			$(this).before(btn);
		 }else{
			 alert("선호지역은 최대 3개까지 등록 가능합니다.")
		 }
	 })
	 
	
	 // 데이트피커
	$( function() {
    $( "#me_birthday" ).flatpickr({ 
    	maxDate: "today", // 오늘 이후의 날짜만 선택 가능
        format: "yy-mm-dd",
        onSelect: function() { 
            var date = $.flatpickr.formatDate("yy-mm-dd",$("#datepicker").flatpickr("getDate")); 
            alert(date);
        }
	    });                    
	});

		
		
		
		
		// 아이디 중복 검사
		let flag = false;
		$('[name=me_id]').keyup(function(){
			flag = false;
			let id = $(this).val();
			if(!/^[a-zA-Z]\w{5,9}$/.test(id)){
				$('#check-id-error').text('아이디는 6~10글자 영문+숫자 조합이며, 영문으로 시작해야합니다');
				return;
			}
			$.ajax({
				async : false, 
				type : 'post', 
				url : '<c:url value="/member/check/id"/>', 
				data : { id : id}, 
				success : function(data){
					if(data){
						$('#check-id-error').text('사용 가능한 아이디입니다.');
						flag = true;
					}else{
						$('#check-id-error').text('이미 사용중인 아이디입니다.');
					}
				}
			});
		})
		
		// 비밀번호 정규표현식 검사
		$('[name=me_pw]').keyup(function(){
			flag = false;
			let pw = $(this).val();
			var rePw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$])[A-Za-z\d!@#\$]{10,20}$/
				if(rePw.test(pw)){
					$('#check-pw-error').text('');
					return;
				}else{
					$('#check-pw-error').text('비밀번호는 영문,숫자,!@#$ 포함 10~20글자여야합니다.');
				}
		})
		
		// 비밀번호 일치 검사
		$('[name=me_pw2]').keyup(function(){
			flag = false;
			let pw = $(this).val();
			let rePw = $('[name=me_pw]').val();
			if(rePw==pw){
				$('#check-pw2-error').text('');
				return;
			}else{
				$('#check-pw2-error').text('비밀번호가 일치하지 않습니다.');
			}
		})
		
		//비밀번호 확인 안되면 제출 못함
		document.getElementById("myForm").addEventListener("submit", function(event) {
		    if (password !== passwordConfirm) {
		        alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		        event.preventDefault(); // 폼 제출을 막음
		    }
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
		
		
		// 선호 지역 삭제 버튼
		$(document).on('click','[name=area-del-btn]',function(){
				$(this).parents('#area-box').hide();
				$(this).parent().prev().find('[name=pr_rg_num]').val(0);
				count--;
		});

		
		// 선호 시간 초기화
		$('#reset-btn').click(function(){
		     // 주중 선호 시간 체크박스 해제
	        $("[name=favoriteTime]").prop("checked", false);

	        // 주말 선호 시간 체크박스 해제
	        $("[name=favoriteHoliTime]").prop("checked", false);
		})
		
	
		
	
	</script>
</body>
</html>