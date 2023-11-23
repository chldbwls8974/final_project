<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    $(function () {
        // datepicker 초기화
        $("#av_notdate").datepicker();
    });
</script>
<meta charset="UTF-8">
<title>경기장 등록</title>
</head>
<style type="text/css">
	.container-body{
		background-color: #f2f2f2; height: auto; margin-top: 20px;
		border-radius: 20px; padding: 100px;
	}
	.form-control{border-radius: 30px; width: 500px;}
	.form-group{text-align: center;}
	.form-group label{display: inline-block; text-align: center;}
	.form-group button, .form-group select{margin: 0 auto;}
	.form-group input{margin: 0 auto;}
	.form-group-box{ background-color: #e4f7d3; border-radius: 10px; width: 60%; padding: 30px; margin: 0 auto;}
	.form-group-inline{ text-align: center;}
	.form-group-inline .form-group input{ width: 100px;}
	.input-group{ width: 50%; margin: 0 auto; }
	textarea.form-control{ margin: 0 auto; }
	.btn{ border-radius: 10px; width: 300px; height: 45px; border: none;
	background-color: #c2f296; color: black; margin-top: 50px;}
	
</style>
<body>
	<div class="stadiumInsert-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 24%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		경기장 등록</p>
	</div>
		
	<div class="container-body">
		<form action="<c:url value='/businessman/stadiumInsert'/>" method="post" style="text-align: center;">
		  <div class="form-group" hidden="hidden">
		    <label for="st_fa_num">시설 번호</label>
	 	    <input type="text" class="form-control" id="st_fa_num" name="st_fa_num" value="${fa_num}" readonly>
		  </div>
		  
		  <div class="form-group">
		    <label for="st_name" style="font-weight: bold;">경기장 이름</label>
		    <input type="text" class="form-control" placeholder="경기장 이름을 입력하세요" id="st_name" name="st_name" required>
		  </div>
		  
		  <div class="form-group">
			<label for="st_locate" style="font-weight: bold;">위치</label>
			  <input type="text" class="form-control" placeholder="경기장 위치를 입력하세요" id="st_locate" name="st_locate" required>
		  </div>
		  <br>
		  
		  <h5 class="text-info" style="font-weight: bold; color: black !important; text-align: center; margin-bottom: 20px;">
		  	체크 사항</h5>
		 <div class="form-group-box">
		  <div class="form-group">
		    <label for="st_door" style="font-weight: bold;">실내/실외</label><br>
		    <div class="form-check-inline">
			  <label class="form-check-label">
			  	<input type="radio" class="form-check-input" name="st_door" value="0" required>실외
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="st_door" value="1" required>실내
			  </label>
			</div>
		  </div>
		 
		  <div class="form-group">
		    <label for="st_floortype" style="font-weight: bold;">바닥 종류</label><br>
		    <div class="form-check-inline">
			  <label class="form-check-label">
			  	<input type="radio" class="form-check-input" name="st_floortype" value="0" required>인조잔디
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="st_floortype" value="1" required>천연잔디
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="st_floortype" value="2" required>모래
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="st_floortype" value="3" required>인도어
			  </label>
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="st_available" style="font-weight: bold;">이용 가능 여부</label><br>
		    <div class="form-check-inline">
			  <label class="form-check-label">
			  	<input type="radio" class="form-check-input" name="st_available" value="0" required>가능
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="st_available" value="1" required>불가능
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="st_available" value="2" required>삭제
			  </label>
			</div>
		  </div>
		  <br>
		  <div id="availabilityFields" style="display: none;">
			  <div class="form-group" style="width: 100%">
			        <label for="av_notdate" style="font-weight: bold;">불가적용 날짜</label>
			        <input type="text" class="form-control" id="av_notdate" name="av_notdate"
			        style="width: 90%;" placeholder="날짜를 선택하세요">
			  </div>
			
			  <div class="form-group" style="width: 100%">
			        <label for="av_reason" style="font-weight: bold;">사유</label>
			        <input type="text" class="form-control" id="av_reason" name="av_reason"
			        style="width: 90%;" placeholder="사유를 입력하세요">
			  </div>
		  </div> 
		 </div>
		  
		  <div class="form-group-inline">
			 <label for="st_width" style="font-weight: bold;">가로 x 세로(m)</label>
			 <div class="input-group">
			    <input type="number" class="form-control text-right" placeholder="가로" name="st_width" id="st_width" oninput="numOnly(this); calculateMax();" max="99999" required>
			    <div class="input-group-append">
			      <span class="input-group-text">x</span>
			    </div>
			    <input type="number" class="form-control text-right" placeholder="세로" name="st_height" id="st_height" oninput="numOnly(this); calculateMax();" max="99999" required>
			    <span class="input-group-text">(m)</span>
		     </div>
		  </div>
		  <br>
		  
		  <div class="form-group-inline">
		    <label for="st_max" style="font-weight: bold;">최대인원</label>
	   		<div class="input-group">
			    <input type="number" class="form-control text-right" placeholder="최대인원"name="st_max"  id="st_max" oninput="numOnly2(this)" max="99" required>
		  		<span class="input-group-text">명</span>
		  	</div>
		  </div>
		  <br>
		 
		  <div class="form-group">
			  <label for="st_note" style="font-weight: bold;">특이사항</label> &nbsp;<span class="badge badge-secondary">선택</span>
			  <textarea class="form-control" rows="5" id="st_note" name="st_note"></textarea>
		  </div>
			<div style="display: inline-block;">
			  <button class="btn btn-block">등록</button>
			  <a class="btn btn-block" role="button" href="<c:url value='/businessman/facility'/>" style="background-color: #b9b9b9;">
			  취소</a>
			</div>	
		</form>
	</div>
	
	<script type="text/javascript">	
		//숫자만 입력되도록 하는 메서드
		function numOnly(target) {
	        //입력값이 5자리 이상인 경우 마지막 5자리만 유지
   			target.value = target.value.slice(0, 5);
		}
		function numOnly2(target) {
	        //입력값이 2자리 이상인 경우 마지막 2자리만 유지
   			target.value = target.value.slice(0, 2);
		}
		
		//최대인원 자동계산
		function calculateMax() {
		        // st_width와 st_height의 현재 값 가져오기
		        var st_width = parseFloat(document.getElementById("st_width").value) || 0;
		        var st_height = parseFloat(document.getElementById("st_height").value) || 0;

		        if (st_width > 0 && st_height > 0) {
		            // 계산된 결과를 result 변수에 저장
		            var result = st_width * st_height;

		            // 범위에 따라 st_max 값 설정
		            if (result >= 420 && result < 540) {
		                document.getElementById("st_max").value = 15;
		            } else if (result >= 540 && result <= 800) {
		                document.getElementById("st_max").value = 18;
		            } else {
		                // 이외의 범위는 직접 최대 인원 수 입력 가능
		                document.getElementById("st_max").value = "";
		            }
		        } else {
		            // st_width와 st_height의 값이 0인 경우
		            document.getElementById("st_max").value = "";
		        }
		    }
		
		 //이용가능여부 변경
	    $('input[name="st_available"]').change(function () {
	        if ($(this).val() === '1') {
	            $('#availabilityFields').show();
	        } else {
	            $('#availabilityFields').hide();
	        }
	    });
		
	</script>
	
</body>
</html>