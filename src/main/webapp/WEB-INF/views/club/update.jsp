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
.chip__item-radio:checked+label{
	color: #1570FF;
    border: 1px solid #1570FF;
}
</style>
</head>
<body>
	<h1>클럽수정</h1>
	<form action="<c:url value='/club/update'/>" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<label>클럽 앰블럼</label>
			<input type="file" class="form-control" name="img" id="img">
		</div>
		<input type="hidden" class="form-control" name="me_num" value="${user.me_num }">
		<input type="hidden" class="form-control" name="cl_num" value="${club.cl_num}">
		<input type="hidden" class="form-control" name="test" value="${club.cl_emblem}">
		<div class="form-group">
			<label>클럽명</label><label id="check-name-error" class="error" for="cl_name"></label>
			<input type="text" class="form-control" name="cl_name" id="cl_name" value="${club.cl_name }">
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
		
		<div class="form-group">
		 <label>선호시간</label>
		    <div class="pre_time">
				<div class="form-group time-box weekday-time">
					<label>평일 선호 시간</label>
					<ul class="chip">
						
						<li class="chip__item--3">
							<input type="checkbox" id="time_6" name="favoriteTime" class="chip__item-radio" value="6" <c:if test="${weekTime.contains(Integer(6)) || weekTime.contains(Integer(7))}">checked</c:if>> 
							<label for="time_6" class="chip__item-label" style="height: 70px;">
								<div style="margin-bottom: 5px;">
									<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunrise.svg" >
								</div> 06:00
							</label>
						</li>
						<li class="chip__item--3">
							<input type="checkbox" id="time_8" name="favoriteTime" class="chip__item-radio" value="8" <c:if test="${weekTime.contains(Integer(8)) || weekTime.contains(Integer(9))}">checked</c:if>> 
							<label  for="time_8" class="chip__item-label" style="height: 70px;">
								<div style="margin-bottom: 5px;">
									<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
								</div> 08:00
							</label>
						</li>
						<li class="chip__item--3">
							<input type="checkbox" id="time_10" name="favoriteTime" class="chip__item-radio" value="10" <c:if test="${weekTime.contains(Integer(10)) || weekTime.contains(Integer(11))}">checked</c:if>> 
							<label for="time_10" class="chip__item-label" style="height: 70px;">
								<div style="margin-bottom: 5px;">
									<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
								</div> 10:00
	                		</label>
	                	</li>
						<li class="chip__item--3">
							<input  type="checkbox" id="time_12" name="favoriteTime" class="chip__item-radio" value="12" <c:if test="${weekTime.contains(Integer(12)) || weekTime.contains(Integer(13))}">checked</c:if>> 
							<label  for="time_12" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
								</div> 12:00
	                		</label>
	               		</li>
						<li class="chip__item--3">
							<input type="checkbox" id="time_14" name="favoriteTime" class="chip__item-radio" value="14" <c:if test="${weekTime.contains(Integer(14)) || weekTime.contains(Integer(15))}">checked</c:if>> 
							<label for="time_14" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 14:00
	                		</label>
	               		</li>
						<li  class="chip__item--3">
							<input  type="checkbox" id="time_16" name="favoriteTime" class="chip__item-radio" value="16" <c:if test="${weekTime.contains(Integer(16)) || weekTime.contains(Integer(17))}">checked</c:if>>
							<label  for="time_16" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
								</div> 16:00
	                		</label>
	                	</li>
						<li  class="chip__item--3">
							<input  type="checkbox" id="time_18" name="favoriteTime" class="chip__item-radio" value="18" <c:if test="${weekTime.contains(Integer(18)) || weekTime.contains(Integer(19))}">checked</c:if>> 
							<label  for="time_18" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
								</div> 18:00
	                		</label>
	               		</li>
						<li  class="chip__item--3">
							<input  type="checkbox" id="time_20" name="favoriteTime" class="chip__item-radio" value="20" <c:if test="${weekTime.contains(Integer(20)) || weekTime.contains(Integer(21))}">checked</c:if>> 
							<label  for="time_20" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
								</div> 20:00
	               			</label>
	        			</li>
						<li  class="chip__item--3">
							<input  type="checkbox" id="time_22" name="favoriteTime" class="chip__item-radio" value="22" <c:if test="${weekTime.contains(Integer(22)) || weekTime.contains(Integer(23))}">checked</c:if>> 
							<label  for="time_22" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
								</div> 22:00
	               			</label>
	           			</li>
						<li  class="chip__item--3">
							<input  type="checkbox" id="time_24" name="favoriteTime" class="chip__item-radio" value="0" <c:if test="${weekTime.contains(Integer(0)) || weekTime.contains(Integer(1))}">checked</c:if>>
							<label  for="time_24" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
								</div> 24:00
	               			</label>
	               		</li>
	                	<li  class="chip__item--3">
	                		<input  type="checkbox" id="time_2" name="favoriteTime" class="chip__item-radio" value="2" <c:if test="${weekTime.contains(Integer(2)) || weekTime.contains(Integer(3))}">checked</c:if>>  
	                		<label  for="time_2" class="chip__item-label" style="height: 70px;">
	                			<div  style="margin-bottom: 5px;">
	                				<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
	               				</div> 02:00
	                		</label>
	                	</li>
	                	<li  class="chip__item--3">
	                		<input  type="checkbox" id="time_4" name="favoriteTime" class="chip__item-radio" value="4" <c:if test="${weekTime.contains(Integer(4)) || weekTime.contains(Integer(5))}">checked</c:if>> 
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
							<input type="checkbox" id="holitime_6" name="favoriteHoliTime" class="chip__item-radio" value="6" <c:if test="${holiTime.contains(Integer(6)) || holiTime.contains(Integer(7))}">checked</c:if>> 
							<label for="holitime_6" class="chip__item-label" style="height: 70px;">
								<div style="margin-bottom: 5px;">
									<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunrise.svg">
								</div> 06:00
							</label>
						</li>
						<li class="chip__item--3">
							<input type="checkbox" id="holitime_8" name="favoriteHoliTime" class="chip__item-radio" value="8" <c:if test="${holiTime.contains(Integer(8)) || holiTime.contains(Integer(9))}">checked</c:if>> 
							<label  for="holitime_8" class="chip__item-label" style="height: 70px;">
								<div style="margin-bottom: 5px;">
									<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
								</div> 08:00
							</label>
						</li>
						<li class="chip__item--3">
							<input type="checkbox" id="holitime_10" name="favoriteHoliTime" class="chip__item-radio" value="10" <c:if test="${holiTime.contains(Integer(10)) || holiTime.contains(Integer(11))}">checked</c:if>> 
							<label for="holitime_10" class="chip__item-label" style="height: 70px;">
								<div style="margin-bottom: 5px;">
									<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
								</div> 10:00
	                		</label>
	                	</li>
						<li class="chip__item--3">
							<input  type="checkbox" id="holitime_12" name="favoriteHoliTime" class="chip__item-radio" value="12" <c:if test="${holiTime.contains(Integer(12)) || holiTime.contains(Integer(13))}">checked</c:if>> 
							<label  for="holitime_12" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
								</div> 12:00
	                		</label>
	               		</li>
						<li class="chip__item--3">
							<input type="checkbox" id="holitime_14" name="favoriteHoliTime" class="chip__item-radio" value="14" <c:if test="${holiTime.contains(Integer(14)) || holiTime.contains(Integer(15))}">checked</c:if>> 
							<label for="holitime_14" class="chip__item-label" style="height: 70px;">
							<div style="margin-bottom: 5px;">
								<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
							</div> 14:00
	                		</label>
	               		</li>
						<li  class="chip__item--3">
							<input  type="checkbox" id="holitime_16" name="favoriteHoliTime" class="chip__item-radio" value="16" <c:if test="${holiTime.contains(Integer(16)) || holiTime.contains(Integer(17))}">checked</c:if>>
							<label  for="holitime_16" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_sunny.svg">
								</div> 16:00
	                		</label>
	                	</li>
						<li  class="chip__item--3">
							<input  type="checkbox" id="holitime_18" name="favoriteHoliTime" class="chip__item-radio" value="18" <c:if test="${holiTime.contains(Integer(18)) || holiTime.contains(Integer(19))}">checked</c:if>> 
							<label  for="holitime_18" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
								</div> 18:00
	                		</label>
	               		</li>
						<li  class="chip__item--3">
							<input  type="checkbox" id="holitime_20" name="favoriteHoliTime" class="chip__item-radio" value="20" <c:if test="${holiTime.contains(Integer(20)) || holiTime.contains(Integer(21))}">checked</c:if>> 
							<label  for="holitime_20" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
								</div> 20:00
	               			</label>
	        			</li>
						<li  class="chip__item--3">
							<input  type="checkbox" id="holitime_22" name="favoriteHoliTime" class="chip__item-radio" value="22" <c:if test="${holiTime.contains(Integer(22)) || holiTime.contains(Integer(23))}">checked</c:if>> 
							<label  for="holitime_22" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_night.svg">
								</div> 22:00
	               			</label>
	           			</li>
						<li  class="chip__item--3">
							<input  type="checkbox" id="holitime_24" name="favoriteHoliTime" class="chip__item-radio" value="0"<c:if test="${holiTime.contains(Integer(0)) || holiTime.contains(Integer(1))}">checked</c:if>>
							<label  for="holitime_24" class="chip__item-label" style="height: 70px;">
								<div  style="margin-bottom: 5px;">
									<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
								</div> 24:00
	               			</label>
	               		</li>
	                	<li  class="chip__item--3">
	                		<input  type="checkbox" id="holitime_2" name="favoriteHoliTime" class="chip__item-radio" value="2" <c:if test="${holiTime.contains(Integer(2)) || holiTime.contains(Integer(3))}">checked</c:if>> 
	                		<label  for="holitime_2" class="chip__item-label" style="height: 70px;">
	                			<div  style="margin-bottom: 5px;">
	                				<img  src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_midnight.svg">
	               				</div> 02:00
	                		</label>
	                	</li>
	                	<li  class="chip__item--3">
	                		<input  type="checkbox" id="holitime_4" name="favoriteHoliTime" class="chip__item-radio" value="4" <c:if test="${holiTime.contains(Integer(4)) || holiTime.contains(Integer(5))}">checked</c:if>> 
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
		${ageList }
		<div class="form-group">
		<label>선호 연령</label><br>
		
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" name ="age" value="10" <c:if test="${ageList.contains(Integer(10))}">checked</c:if>>10
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" name ="age" value="20" <c:if test="${ageList.contains(Integer(20))}">checked</c:if>>20
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" name ="age" value="30" <c:if test="${ageList.contains(Integer(30))}">checked</c:if>>30
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" name ="age" value="40" <c:if test="${ageList.contains(Integer(40))}">checked</c:if>>40
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" name ="age" value="50" <c:if test="${ageList.contains(Integer(50))}">checked</c:if>>50
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" name ="age" value="60" <c:if test="${ageList.contains(Integer(60))}">checked</c:if>>60
			  </label>
			</div>
			
		</div>
		
		<div class="form-group">
		 <label>클럽 회비</label>
		   <input type="number"  class="form-control" name="cl_price" id="cl_price" value="${club.cl_price }">
		</div>
		<div class="form-group">
		 <label>클럽 규칙</label>
		    <textarea class="form-control" name="cl_rule">${club.cl_rule }</textarea>
		</div>
		<div class="form-group">
		 <label>클럽 소개</label>
		    <textarea class="form-control" name="cl_introduction">${club.cl_introduction }</textarea>
		</div>
		<div class="form-group">
		 <label>클럽 외부 url</label>
		   <input type="url"  class="form-control" name="cl_url" value="${club.cl_url }">
		</div>
		<button class="btn btn-outline-warning col-12">클럽신청</button>
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