<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 등록</title>
</head>
<body>
	<h1 class="display-3"><span style="color: black; font-weight: bold;">시설 등록</span></h1> <br>
	<form action="<c:url value='/businessman/facilityInsert'/>" method="post">
		<div class="form-group">
			<label for="fa_bu_num">사업자 번호</label>
		    <input type="text" class="form-control" id="fa_bu_num" name="fa_bu_num" value="${business.bu_num}" readonly>
		</div>
		  
	  	<div class="form-group">
			<label>지역</label> 
			<select class="form-control rg_main" required>
				<option value="0">지역을 선택하세요</option>
					<c:forEach items="${MainRegion}" var="main">
						<option value="${main.rg_main}">${main.rg_main}</option>
					</c:forEach>
			</select>
		</div>
	    <div class="form-group">
			<select class="form-control rg_sub" name="fa_rg_num" required>
				<option value="0">지역을 선택하세요</option>
					<c:forEach items="${SubRegion}" var="sub">
						<option value="${sub.rg_num}">${sub.rg_sub}</option>
					</c:forEach>
			</select>
	    </div>

  	    <div class="form-group">
		    <label for="fa_name">시설명</label>
		    <input type="text" class="form-control" placeholder="시설명을 입력하세요" name="fa_name" id="fa_name" required>
		</div>
		<div class="form-group">
			<label for="fa_add">주소</label>
		    <input type="text" class="form-control" placeholder="주소를 입력하세요" name="fa_add" id="fa_add" required>
		</div>
		<div class="form-group">
			<label for="fa_add_detail">상세주소</label>
			<input type="text" class="form-control" placeholder="상세 주소를 입력하세요" name="fa_add_detail" id="fa_add_detail" required>
		</div>
		 
		<div class="form-group">
		    <label for="fa_phone">전화번호</label>
		    <input type="text" class="form-control" id="fa_phone" name="fa_phone" placeholder="-를 제외하고 입력하세요" oninput="autoHyphen(this)" maxlength="14" required>
		</div>
		  
	    <h3>부대시설</h3>
	    <div class="form-group">
			<label for="fa_pay" style="font-weight: bold;">주차장</label>
		    <div class="form-check-inline">
				<label class="form-check-label">
			  		<input type="radio" class="form-check-input" name="fa_pay" value="0" required>없음
			    </label>
			</div>
			<div class="form-check-inline">
			    <label class="form-check-label">
			    	<input type="radio" class="form-check-input" name="fa_pay" value="1" required>무료
			    </label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
			    	<input type="radio" class="form-check-input" name="fa_pay" value="2" required>유료
			    </label>
			</div>
		</div>
		  
		<div class="form-group">
			<label for="fa_locker" style="font-weight: bold;">탈의실</label>
		    <div class="form-check-inline">
				<label class="form-check-label">
			  		<input type="radio" class="form-check-input" name="fa_locker" value="0" required>없음
			    </label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
			    	<input type="radio" class="form-check-input" name="fa_locker" value="1" required>있음
			    </label>
			</div>
		</div>
		  
		<div class="form-group">
			<label for="fa_toilet" style="font-weight: bold;">화장실</label>
		    <div class="form-check-inline">
				<label class="form-check-label">
			  		<input type="radio" class="form-check-input" name="fa_toilet" value="0" required>없음
			    </label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
			    	<input type="radio" class="form-check-input" name="fa_toilet" value="1" required>있음
			    </label>
			</div>
		</div>
		  
		<div class="form-group">
		    <label for="fa_shower" style="font-weight: bold;">샤워실</label>
		    <div class="form-check-inline">
				<label class="form-check-label">
			  		<input type="radio" class="form-check-input" name="fa_shower" value="0" required>없음
			    </label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
			    	<input type="radio" class="form-check-input" name="fa_shower" value="1" required>있음
			    </label>
			</div>
		</div>
		  
		<div class="form-group">
		    <label for="fa_smoking" style="font-weight: bold;">흡연장</label>
		    <div class="form-check-inline">
				<label class="form-check-label">
			  		<input type="radio" class="form-check-input" name="fa_smoking" value="0" required>없음
			    </label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
			    	<input type="radio" class="form-check-input" name="fa_smoking" value="1" required>있음
			    </label>
			</div>
		</div>
	
		<div class="form-group">
			<label for="fa_machine" style="font-weight: bold;">자판기</label>
		    <div class="form-check-inline">
				<label class="form-check-label">
			  		<input type="radio" class="form-check-input" name=fa_machine value="0" required>없음
			    </label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
			    	<input type="radio" class="form-check-input" name="fa_machine" value="1" required>있음
			    </label>
			</div>
		</div>
		<br>
		  
		<div class="form-group">
		<label for="fa_note">특이사항</label>
			<textarea class="form-control" rows="5" id="fa_note" name="fa_note"></textarea>
		</div>
	   <br>
		
		
		
		
		
		
		
		
	   <h3>운영시간</h3>
	   <div class="operating">
		  <div class="form-group">
			<c:forEach var="i" begin="1" end="7">
				<div class="form-check-inline">
	            	<input type="checkbox" class="day_checkbox" id="checkbox_${i}" data-target="${i}">
					<c:choose>
				        <c:when test="${i == 1}">
				            <c:set var="day" value="월" />
				        </c:when>
				        <c:when test="${i == 2}">
				            <c:set var="day" value="화" />
				        </c:when>
				        <c:when test="${i == 3}">
				            <c:set var="day" value="수" />
				        </c:when>
				        <c:when test="${i == 4}">
				            <c:set var="day" value="목" />
				        </c:when>
				        <c:when test="${i == 5}">
				            <c:set var="day" value="금" />
				        </c:when>
				        <c:when test="${i == 6}">
				            <c:set var="day" value="토" />
				        </c:when>
				        <c:when test="${i == 7}">
				            <c:set var="day" value="일" />
				        </c:when>
				    </c:choose>
				    
				    <label for="op_day_${i}" >요일 선택:</label>
				    <select class="form-control op_day" name="operatingVoList[${i-1 }].op_day" id="op_day_${i}" disabled>
				        <option value="${day}">${day}</option>
				    </select>
				    
					<label >오픈시간:</label>
					<select class="form-control op_open" name="op_open" id="op_open_${i}" disabled>
					    <c:forEach var="h" begin="0" end="23" step="1">
					        <option><c:out value="${h < 10 ? '0' : ''}${h}:00" /></option>
					    </c:forEach>
					</select>
					
					<label>종료시간:</label>
					<select class="form-control op_close" name="op_close" id="op_close_${i}" disabled>
					    <c:forEach var="h" begin="0" end="23" step="1">
					        <option><c:out value="${h < 10 ? '0' : ''}${h}:00" /></option>
					    </c:forEach>
					</select>
				</div>
			</c:forEach>
		  </div> 
	   </div>
	   <button class="btn btn-secondary btn-block">등록</button><br>
	</form> 




	<script type="text/javascript">	
		//자동으로 하이픈(-)으로 구분된 전화번호 형식으로 변환하는 메서드
		function autoHyphen(target) {
			//target의 값을 자체로 다시 설정
   			target.value = target.value
	   			//대괄호 안에서 ^는 '부정'을 의미. g 플래그는 전체 문자열에서 모든 일치 항목을 찾음. 따라서, 숫자가 아닌 모든 문자를 제거. 
        		.replace(/[^0-9]/g, '')
        		//숫자만 남은 문자열을 전화번호 형식으로 변환
        		.replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
		}
		//지역 선택
		 $(document).on('change','.rg_main',function(){
			 let th = $(this);
			 rg_main = th.val();
			 //console.log(rg_main)
			 data={
				 rg_main : rg_main
			}
			//각 지역별 도시 선택
			ajaxJsonToJson2(false, 'get', '/businessman/facilityInsert/region', data, (a)=>{
				var option = "";
				th.parent().next().find('[name=fa_rg_num]').empty();
				
				for (var i in a.SubRegion){
					var obj = a.SubRegion[i];
					option = "<option value='" + obj.rg_num + "'>" + obj.rg_sub + "</option>";
					th.parent().next().find('[name=fa_rg_num]').append(option)
				}
			})
		   });
		 
		//체크박스에 체크하지 않은 요일은 비활성화(체크한 것만 활성화)
		 $(document).on('click', '.day_checkbox', function() {
			    var target = $(this).data('target');
			    var op_day_select = $('#op_day_' + target);
			    var op_open_select = $('#op_open_' + target);
			    var op_close_select = $('#op_close_' + target);
				
			    //체크박스에 체크가 되면 활성화
			    if ($(this).is(':checked')) {
			        op_day_select.prop('disabled', false);
			        op_open_select.prop('disabled', false);
			        op_close_select.prop('disabled', false);
			    } else {//체크박스에 체크가 해제되면 비활성화
			        op_day_select.prop('disabled', true);
			        op_open_select.prop('disabled', true);
			        op_close_select.prop('disabled', true);
			    }
			});

		
		
		   $(document).ready(function() {
		        $("#submit").click(function(e) {
		            e.preventDefault();

		            // 선택된 운영 요일/시간 데이터 수집
		            var operatingList = [];
		            $(".day_checkbox:checked").each(function() {
		                var index = $(this).data("target");
		                var day = $("#op_day_" + index).val();
		                var open = $("#op_open_" + index).val();
		                var close = $("#op_close_" + index).val();

		                operatingList.push({
		                    op_day: day,
		                    op_open: open,
		                    op_close: close
		                });
		            });
		            // JSON 형식으로 데이터 구성
		            var data = {
		                operatingList: operatingList
		            };
		            
					// JSON.stringify()를 사용하여 JSON 형식으로 변환
		            var jsonData = JSON.stringify(data);
		            
		            // Ajax 요청 보내기 (응답 처리 생략)
		            $.ajax({
		                type: "POST",
		                url: "/businessman/facilityInsert",
		                data: jsonData,
		                contentType: "application/json; charset=utf-8",
		                dataType: "json"
		            });
		        });
		    });
	</script>

</body>
</html>