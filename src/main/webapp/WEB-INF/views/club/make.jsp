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

.container{ background-color: #f0f0f0; padding: 50px 0 50px 0;
}
.form-control{border-radius: 30px; width: 400px;}
.form-group{display:block; text-align: center;}
.form-group label{ margin-top: 20px;}
.form-group input,
.form-group select,
.form-group textarea{ display: block; margin: 0 auto;}
.form-group textarea{ text-align: center;}
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
	padding: 0 20px 0 20px;
}
.chip__item--3{
	box-shadow: none;	
    margin: 0;
    vertical-align: baseline;
}
.chip__item--3{
	width: 25%;
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
.chip__item-radio:checked+label{
	color: #1570FF;
    border: 1px solid #1570FF;
}


.form-check-inline{
    position: relative;
    padding-right: 1px;
    margin-right: 5px;
    box-sizing: border-box;
    outline: none;
}
.form-check-input{
	position: absolute;
	display: none;
    opacity: 0;
    background-color: #F2F5F7;
	width: 100%;
    height: 100%;
}
.form-check-input+label{
	position: relative;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    color: #4B5A64;
    background-color: #FFFFFF;
    border: 1px solid #D9E0E6;
    border-radius: 12px;
    margin: 5px;
    display: flex;
    justify-content: center;
    flex-direction: column;
}
.form-check-input:checked+label{
	color: #1570FF;
    border: 1px solid #1570FF;
   	text-align: center;
}

input[type='checkbox']{
	display : none;
}

.btn{ border-radius: 3px; width: 300px; height: 45px; border: none;
	background-color: #0c0c0c; color: white; font-weight: 900; margin-top: 50px;}

</style>
</head>
<body>
	<p style="font-size: 45px; font-weight: bolder; text-align: center; margin-bottom: 20px;
		 letter-spacing: -3px;">클럽 생성</p>
	<form action="<c:url value='/club/make'/>" method="post" style="text-align: center;">
<!-- 		<div class="form-group"> -->
<!-- 			<label>클럽 앰블럼</label> -->
<!-- 			<input type="file" class="form-control" name="cl_emblem"> -->
<!-- 		</div> -->
		<div class="form-group">
			<label>회원 이름</label>
			<input type="hidden" class="form-control" name="me_num" value="${user.me_name }" style="text-align:center; margin: 0 auto;" readonly>
		</div>
		<div class="form-group">
			<label>클럽명</label><label id="check-name-error" class="error" for="cl_name"></label>
			<input type="text" class="form-control" name="cl_name" id="cl_name">
		</div>
		<div class="form-group">
			<label>활동지역</label> 
			<select class="form-control rg_main" required>
				<option value="">지역을 선택하세요</option>
				<c:forEach items="${MainRegion}" var="main">
					<option value="${main.rg_main}">${main.rg_main}</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group">
			<select class="form-control rg_sub" name="cl_rg_num" required>
				<option value="">지역을 선택하세요</option>
				<c:forEach items="${SubRegion}" var="sub">
					<option value="${sub.rg_num}">${sub.rg_sub}</option>
				</c:forEach>
			</select>
		</div>
		
		<div class="form-group" style="margin-top: 20px;">
		 <label>선호시간</label>
		    <div class="pre_time">
				<div class="form-group time-box weekday-time">
					<label style="font-size: 20px; font-weight: bolder;
						 margin-bottom: 10px;">평일 선호 시간</label>
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
					<label style="font-size: 20px; font-weight: bolder;
						 margin-bottom: 10px;">주말 선호 시간</label>
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
	                		<input type="checkbox" id="holitime_2" name="favoriteHoliTime" class="chip__item-radio" value="2"> 
	                		<label for="holitime_2" class="chip__item-label" style="height: 70px;">
	                			<div  style="margin-bottom: 5px;">
	                				<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
	               				</div> 02:00
	                		</label>
	                	</li>
	                	<li  class="chip__item--3">
	                		<input type="checkbox" id="holitime_4" name="favoriteHoliTime" class="chip__item-radio" value="4"> 
	                		<label for="holitime_4" class="chip__item-label" style="height: 70px;">
	                		<div style="margin-bottom: 5px;">
	                			<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
	               			</div>  04:00
	              			</label>
	           			</li>
	                </ul>
				</div>
			</div>
		</div>
		
		<div class="form-group">
		<label>선호 연령</label><br>
			<div class="form-check-inline">
				<input type="checkbox" id="age_10" class="form-check-input" name ="age" value="10">
				<label for="age_10" class="form-check-label" style="height: 40px; width: 50px;">
	          		<div>
	       			</div>  10대
    			</label>
			</div>
			<div class="form-check-inline">
			  <input type="checkbox" id="age_20" class="form-check-input" name ="age" value="20">
				<label for="age_20" class="form-check-label" style="height: 40px; width: 50px;">
	          		<div>
	       			</div>  20대
    			</label>
			</div>
			<div class="form-check-inline">
			  <input type="checkbox" id="age_30" class="form-check-input" name ="age" value="30">
				<label for="age_30" class="form-check-label" style="height: 40px; width: 50px;">
	          		<div>
	       			</div>  30대
    			</label>
			</div>
			<div class="form-check-inline">
			  <input type="checkbox" id="age_40" class="form-check-input" name ="age" value="40">
				<label for="age_40" class="form-check-label" style="height: 40px; width: 50px;">
	          		<div>
	       			</div>  40대
    			</label>
			</div>
			<div class="form-check-inline">
			  <input type="checkbox" id="age_50" class="form-check-input" name ="age" value="50">
				<label for="age_50" class="form-check-label" style="height: 40px; width: 50px;">
	          		<div>
	       			</div>  50대
    			</label>
			</div>
			<div class="form-check-inline">
			  <input type="checkbox" id="age_60" class="form-check-input" name ="age" value="60">
				<label for="age_60" class="form-check-label" style="height: 40px; width: 50px;">
	          		<div>
	       			</div>  60대
    			</label>
			</div>
		</div>
		
		<div class="form-group">
		 <label>클럽 회비</label>
		   <input type="number"  class="form-control" name="cl_price" id="cl_price">
		</div>
		<div class="form-group">
		 <label>클럽 규칙</label>
		    <textarea class="form-control" id="" name="cl_rule" placeholder="클럽규칙을 자유롭게 입력해주세요"></textarea>
		</div>
		<div class="form-group">
		 <label>클럽 소개</label>
		    <textarea class="form-control" name="cl_introduction" placeholder="클럽소개를 자유롭게 입력해주세요"></textarea>
		</div>
		<div class="form-group">
		 <label>클럽 외부 url</label>
		   <input type="url"  class="form-control" name="cl_url">
		</div>
		<button class="btn">클럽신청</button>
	</form>
	
	
	<script type="text/javascript">
	$(document).on('check','[name=age]',function(){
		console.log($(this).val())
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
			th.parent().next().find('[name=cl_rg_num]').empty();
			
			for (var i in a.SubRegion){
				var obj = a.SubRegion[i];
				option = "<option value='" + obj.rg_num + "'>" + obj.rg_sub + "</option>";
				th.parent().next().find('[name=cl_rg_num]').append(option)
			}
			
		})
		
	   });
	
	// 팀이름
	let flag = false;
	$('[name=cl_name]').keyup(function(){
		flag = false;
		let name = $(this).val();
		$.ajax({
			async : false, 
			type : 'post', 
			url : '<c:url value="/club/make/check"/>', 
			data : { name : name}, 
			success : function(data){
				if(data){
					$('#check-name-error').text('이미 사용중인 클럽명입니다.');
				}else{
					$('#check-name-error').text('사용 가능한 클럽명입니다.');
					flag = true;
				}
			}
		});
	})
	</script>
</body>
</html>