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
	<p class="title" style="font-size: 45px; font-weight: bolder; padding-bottom: 30px;
		text-align: center; letter-spacing: -3px;">회원가입</p>
	<form action="<c:url value='/kakao_callback'/>" method="post" id="myForm">
		<div class="1p">
			<input type="hidden" name="me_id" value="${me_id }">
<%-- 			<input type="hidden" name="me_pw" value="kakao${me_id }"> --%>
			<input type="hidden" name="me_email" value="${kakaoAccount.email }">
			<input type="hidden" name="me_name" value="${kakaoAccount.name }">
			<input type="hidden" name="me_gender" value="${kakaoAccount.gender }">
			<div class="form-group">
				<label>닉네임</label> <label id="check-nickName-error" class="error" for="me_nickname"></label>
				 <input type="text" class="form-control" name="me_nickname" maxlength="15" placeholder="${kakaoAccount.profile_nickname }" required>
			</div>
			<div class="form-group">
				<label>생년월일</label> <input type="text" class="form-control"
					name="me_birthday" id="me_birthday"
					placeholder="날짜를 선택하세요." style="text-align: center;" required>
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
			<button type="button" class="btn next-btn form-control" id="next">다음</button>
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
                 <div>
					 <button type="button" id="reset-btn"  style="background-color: black; color: white; border-radius: 10px; width: 80px;" class="btn">초기화</button>
				</div>
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
		<button class="signup-btn" id="signup" style="display:flow-root;">회원가입</button>
	</form>
	<script type="text/javascript">
	

	const nextBtn = document.getElementById("next");
	const signUpBtn = document.getElementById("signup");
	let count = 1;
	
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
	
		// 여러 조건 안맞으면 폼 제출을 막음
		document.getElementById("myForm").addEventListener("submit", function(event) {
            let birth = $('[name=me_birthday]').val();
            if (birth == '') {
                alert("생년월일을 선택해주세요.");
                event.preventDefault();
            }
		});
			
		
	
	</script>
</body>
</html>