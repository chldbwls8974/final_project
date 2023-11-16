<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기장 등록</title>
</head>
<style type="text/css">
	.container-body{
		background-color: #f2f2f2; height: auto; margin-top: 20px;
		border-radius: 20px; padding: 100px;
	}
</style>
<body>
	<div class="stadiumInsert-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 24%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		경기장 등록</p>
	</div>
		
	<div class="container-body">
		<form action="<c:url value='/businessman/stadiumInsert'/>" method="post">
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
		  
		  <h5 class="text-info" style="font-weight: bold;">[체크 사항]</h5>
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
		  
		  <button class="btn btn-info btn-block">등록</button>
		  <a class="btn btn-warning btn-block" role="button" href="<c:url value='/businessman/facility'/>">취소</a>
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
		
	</script>
	
</body>
</html>