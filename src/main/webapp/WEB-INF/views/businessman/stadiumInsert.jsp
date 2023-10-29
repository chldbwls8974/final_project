<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기장 등록</title>
</head>
<body>
	<h1>경기장 등록</h1>
	<form action="<c:url value='/businessman/stadiumInsert'/>" method="post">
	  <div class="form-group">
	    <label for="st_fa_num">시설 번호:</label>
	    <input type="text" class="form-control" id="st_fa_num" name="st_fa_num" value="${facility.fa_num}" readonly>
	  </div>

	  <div class="form-group">
	    <label for="st_name">이름:</label>
	    <input type="text" class="form-control" placeholder="경기장 이름을 입력하세요" id="st_name">
	  </div>
	  <div class="form-group">
		<label for="st_locate">위치:</label>
		  <input type="text" class="form-control" placeholder="경기장 위치를 입력하세요" id="st_locate">
	  </div>
	  <br>
	  <h5 class="text-info">[체크 사항]</h5>
	  <div class="form-group">
	    <label for="st_door" style="font-weight: bold;">실내/실외</label>
	    <div class="form-check-inline">
		  <label class="form-check-label">
		  	<input type="radio" class="form-check-input" name="st_door" value="0">실외
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="st_door" value="1">실내
		  </label>
		</div>
	  </div>
	 
	  <div class="form-group">
	    <label for="st_floortype" style="font-weight: bold;">바닥 종류</label>
	    <div class="form-check-inline">
		  <label class="form-check-label">
		  	<input type="radio" class="form-check-input" name="st_floortype" value="0">인조잔디
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="st_floortype" value="1">천연잔디
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="st_floortype" value="2">모래
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="st_floortype" value="3">인도어
		  </label>
		</div>
	  </div>
	  <br>
	  <div class="form-group-inline">
		 <label for="st_width">가로 x 세로(m)</label>
		 <div class="input-group">
		    <input type="number" class="form-control text-right" placeholder="가로" id="st_width" oninput="numOnly(this)" max="99999">
		    <div class="input-group-append">
		      <span class="input-group-text">x</span>
		    </div>
		    <input type="number" class="form-control text-right" placeholder="세로" id="st_height" oninput="numOnly(this)" max="99999">
		    <span class="input-group-text">(m)</span>
	     </div>
	  </div>
	  <br>
	  <div class="form-group-inline">
	    <label for="st_max">최대인원:</label>
   		<div class="input-group">
		    <input type="number" class="form-control text-right" placeholder="최대인원" id="st_max" oninput="numOnly2(this)" max="99">
	  		<span class="input-group-text">명</span>
	  	</div>
	  </div>
	 
	  <div class="form-group">
		  <label for="st_note">특이사항:</label>
		  <textarea class="form-control" rows="5" id="st_note" name="st_note"></textarea>
	  </div>
	  
	  <button class="btn btn-outline-dark col-12">등록</button>

	</form>
	<button class="btn btn-outline-dark col-12">취소</button>

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
	</script>
	
</body>
</html>