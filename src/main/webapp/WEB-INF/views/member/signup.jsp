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
ul{
	display: flex; 
	flex-wrap: wrap; 
	overflow: hidden; 
	border-radius: 12px;
	list-style: none;
}
li{
	box-shadow: none;	
    margin: 0;
    vertical-align: baseline;
}
input[type='checkbox']{
	display : none;
}
.chip__item--3{
	width: 33.333%;
    position: relative;
    padding-right: 1px;
    box-sizing: border-box;
    outline: none;
    text-align : center;
}
.chip_item-radio{
	position: absolute;
	display: none;
    opacity: 0;
    background-color: #F2F5F7;
    width: 100%;
    height: 100%;
}
.chip__item-radio+label{
	position: relative;
    height: 48px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    color: #4B5A64;
    background-color: #FFFFFF;
    border: 1px solid #D9E0E6;
    border-radius: 12px;
    margin: 5px;
    margin-left: 0px;
    display: flex;
    justify-content: center;
    flex-direction: column;
}
input[type='checkbox']:checked+label{
	color: #1570FF;
    border: 1px solid #1570FF;
}
</style>
</head>
<body>
	<h1>회원가입</h1>
	<form action="<c:url value='/member/signup'/>" method="post" id="myForm">
		
		<div class="1p">
			<div class="form-group">
				<label>아이디</label> <label id="check-id-error" class="error"
					for="me_id"></label> <input type="text" class="form-control"
					name="me_id" id="me_id" required>
			</div>

			<div class="form-group">
				<label>비번</label> <label id="check-pw-error" class="error"
					for="me_pw"></label> <input type="password" class="form-control"
					name="me_pw" id="me_pw" required>
			</div>

			<div class="form-group">
				<label>비번 확인</label> <label id="check-pw2-error" class="error"
					for="me_pw2"></label> <input type="password" class="form-control"
					name="me_pw2" id="me_pw2" required>
			</div>

			<div class="form-group">
				<label>이메일</label> <label id="check-email-error" class="error"
					for="me_email"></label> <input type="email" class="form-control"
					name="me_email" id="me_email" required>
				<button type="button" class="form-control" name="me_email_btn"
					id="me_email_btn" disabled="disabled">인증번호 전송</button>
				<input type="number" class="form-control" name="email_code"
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
				<label>이름</label> <input type="text" class="form-control"
					name="me_name" id="me_name" required>
			</div>

			<div class="form-group">
				<label>성별</label> <input type="radio" name="me_gender" value="M">남
				<input type="radio" name="me_gender" value="F">여
			</div>

			<div class="form-group">
				<label>생년월일</label> <input type="text" class="form-control"
					name="me_birthday" id="me_birthday" required>
			</div>

			<div class="form-group">
				<label>닉네임</label> <label id="check-nickName-error" class="error"
					for="me_nickname"></label> <input type="text" class="form-control"
					name="me_nickname" maxlength="15" required>
			</div>
			<div class="form-group">
				<label>거주지</label> <select class="form-control rg_main" required>
					<option value="">지역을 선택하세요</option>
					<c:forEach items="${MainRegion}" var="main">
						<option value="${main.rg_main}">${main.rg_main}</option>
					</c:forEach>
				</select>

			</div>
			<div class="form-group">
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
			<button type="button" class="btn next-btn form-control" id="next"
				disabled="disabled">다음</button>
		</div>

		<!-- 2번째 페이지 -->
		<div class="2p">
			<div class="pre_time">
			<div class="form-group time-box weekday-time">
				<label>평일 선호 시간</label>
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
				<label>주말 선호 시간</label>
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
			</div>
		</div>



			
		
		
		
		
		
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

			<div class="form-group">
				<button type="button" class="form-control" name="add-area-btn">지역
					추가</button>
			</div>

			<div class="form-group">
				<label>추천인 닉네임</label> <input type="text" class="form-control"
					name="recommed_check" id="recommed_check">
				<button type="button" class="form-control" name="recommed_check_btn">입력</button>

			</div>

		</div>
		<div class="form-group">
			<button type="button" class="btn prev-btn form-control">이전</button>
		</div>
		<button class="btn btn-outline-warning col-12" id="signup"
			disabled="disabled">회원가입</button>
	</form>
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
		$("#me_birthday").datepicker({
			  showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
              // buttonImage: "/application/db/jquery/images/calendar.gif", // 버튼 이미지
              //buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
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
              dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
              showAnim: "slide", //애니메이션을 적용한다.  
              showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
              dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
              monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
	        })
	        
		})
		
		
		
		
		// 아이디 중복 검사
		let flag = false;
		$('[name=me_id]').keyup(function(){
			flag = false;
			let id = $(this).val();
			if(!/^[a-zA-Z]\w{5,9}$/.test(id)){
				$('#check-id-error').text('');
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
		
		
	
	</script>
</body>
</html>