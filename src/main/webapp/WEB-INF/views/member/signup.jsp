<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">
.error{
	color:#f00;
}
</style>
</head>
<body>
	<h1>회원가입</h1>
	<form action="<c:url value='/member/signup'/>" method="post">
		<div class="form-group">
			<label>아이디</label><label id="check-id-error" class="error" for="me_id"></label>
			<input type="text" class="form-control" name="me_id" id="me_id" required>
			
		</div>
		<div class="form-group">
			<label>비번</label>
			<input type="password" class="form-control" name="me_pw" id="me_pw" required>
		</div>
		<div class="form-group">
			<label>비번 확인</label>
			<input type="password" class="form-control" name="me_pw2" required>
		</div>
		<div class="form-group">
			<label>이메일</label>
			<input type="email" class="form-control" name="me_email" id="me_email" required>
			<button type ="button" class="form-control" name="me_email_btn">이메일 인증</button>
		</div>
		<div class="form-group">
			<label>전화번호</label>
			<input type="text" class="form-control" name="me_phone" id="me_phone" required>
		</div>
		<div class="form-group">
			<label>이름</label>
			<input type="text" class="form-control" name="me_name" id="me_name" required>
		</div>
		<div class="form-group">
			<label>성별</label>
			<input type="radio" name="me_gender" value="M">남
			<input type="radio" name="me_gender" value="F">여
		</div>
		<div class="form-group">
			<label>생년월일</label>
			<input type="text" class="form-control" name="me_birthday" id="me_birthday" required>
		</div>
		
		
		<div class="form-group">
			<label>닉네임</label>
			<input type="text" class="form-control" name="me_nickname" required>
		</div>
		
		
		<div class="form-group">
		 <label>거주지</label>
		 	<select class="form-control rg_main" >
			 	<option value="0">지역을 선택하세요</option>
			 	<c:forEach items="${MainRegion}" var="main">
			 		<option value="${main.rg_main}">${main.rg_main}</option>
			 	</c:forEach>
			 </select>
			 
		</div>
		<div class="form-group">
			<select class="form-control rg_sub" name="me_rg_num">
			 	<option value="0">지역을 선택하세요</option>
			 	<c:forEach items="${SubRegion}" var="sub">
			 		<option value="${sub.rg_num}">${sub.rg_sub}</option>
			 	</c:forEach>
			 </select>
		</div>

		<div class="prefer-area">
			<div class="form-group">
				<label>선호지역</label> <select class="form-control rg_main">
					<option value="0">지역을 선택하세요</option>
					<c:forEach items="${MainRegion}" var="main">
						<option value="${main.rg_main}">${main.rg_main}</option>
					</c:forEach>
				</select>

			</div>
			<div class="form-group">
				<select class="form-control rg_sub" id="me_prefer_rg_num">
					<option value="0">지역을 선택하세요</option>
					<c:forEach items="${SubRegion}" var="sub">
						<option value="${sub.rg_num}">${sub.rg_sub}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		
		<div class="form-group">
		<button type="button" class="form-control" name="add-area-btn">지역 추가</button>
		</div>
		<div class="form-group">
			<label>추천인 닉네임</label>
			<input type="text" class="form-control" name="recommed_check" id="recommed_check">
			<button type="button" class="form-control" name="recommed_check_btn">입력</button>
			
		</div>
		
		
		
		
		<button class="btn btn-outline-warning col-12">회원가입</button>
	</form>
	<script type="text/javascript">
	
	let count = 0;
	
	$(document).on('click','[name=recommed_check_btn]',function(){
		let check=$('[name=recommed_check]').val();
		data={
				check : check
		}
		var str = '';
		ajaxJsonToJson2(false, 'get','/member/signup/check',data,(a)=>{
			console.log(a)
			if(a.checked == null){
				str+=`<span>없는 회원입니다.</span>`;
			}else{
				str+=`<span>확인되었습니다.</span>`;
			}
			$(this).after(str);
		})
	})
	
	
	
	
	 $(document).on('change','[name=rg_main]',function(){
		 let th = $(this);
		 rg_main = th.val();
		 console.log(rg_main)
		 data={
			 rg_main : rg_main
		}
		 
		
		ajaxJsonToJson2(false, 'get', '/member/signup/region', data, (a)=>{
			var option = "";
			th.parent().next().find('[name=rg_sub]').empty();
			
			for (var i in a.SubRegion){
				var obj = a.SubRegion[i];
				option = "<option value='" + obj.rg_num + "'>" + obj.rg_sub + "</option>";
				th.parent().next().find('[name=rg_sub]').append(option)
			}
			
		})
		
	   });
	 	
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
					 <label>선호지역</label>
					 	<select class="form-control" name="rg_main">
						 	<option value="0">지역을 선택하세요</option>
						 	<c:forEach items="${MainRegion}" var="main">
						 		<option value="${main.rg_main}">${main.rg_main}</option>
						 	</c:forEach>
						 </select>
						 
					</div>
					<div class="form-group">
						<select class="form-control" name="rg_sub">
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
              stepMonths: 3, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
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
		
	
	</script>
</body>
</html>