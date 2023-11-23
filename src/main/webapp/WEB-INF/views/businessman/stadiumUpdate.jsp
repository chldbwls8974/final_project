<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기장 정보 수정</title>
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
	.form-group-box{ background-color: #e4f7d3; border-radius: 20px; width: 55%; padding: 30px; margin: 0 auto;}
	.form-group-inline{ text-align: center;}
	.form-group-inline .form-group input{ width: 100px;}
	.input-group{ width: 50%; margin: 0 auto; }
	textarea.form-control{ margin: 0 auto; }
	.btn{ border-radius: 10px; width: 300px; height: 45px; border: none;
	background-color: #c2f296; color: black; margin: 50px auto;}
	
</style>
<body>
	<div class="stadiumUpdate-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 28%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		경기장 정보 수정</p>
	</div>
	
	<div class="container-body">
		<form action="<c:url value='/businessman/stadiumUpdate'/>" method="post">
	  	  <input name="st_num" value="${stadium.st_num}" hidden="hidden">
		  <div class="form-group">
		    <label for="st_fa_num" hidden="hidden">시설 번호:</label>
	 	    <input type="text" class="form-control" id="st_fa_num" name="st_fa_num" value="${stadium.st_fa_num}" hidden="hidden">
		  </div>
		  
		  <div class="form-group">
		    <label for="st_name" style="font-weight: bold;">경기장 이름</label>
		    <input type="text" class="form-control" placeholder="경기장 이름을 입력하세요" id="st_name" name="st_name" value="${stadium.st_name}" required>
		  </div>
		  
		  <div class="form-group">
			<label for="st_locate" style="font-weight: bold;">위치</label>
			  <input type="text" class="form-control" placeholder="경기장 위치를 입력하세요" id="st_locate" name="st_locate" value="${stadium.st_locate}" required>
		  </div>
		  <br>
		  
		  <h5 class="text-info" style="font-weight: bold; color: black !important; text-align: center; margin-bottom: 20px;">체크 사항</h5>
			 <div class="form-group-box"> 
			  <div class="form-group">
			    <label for="st_door" style="font-weight: bold;">실내/실외</label><br>
			    <div class="form-check-inline">
			        <label class="form-check-label">
			            <c:choose>
			                <c:when test="${stadium.st_door == '0'}">
			                    <input type="radio" class="form-check-input" name="st_door" value="0" checked>실외
			                </c:when>
			                <c:otherwise>
			                    <input type="radio" class="form-check-input" name="st_door" value="0">실외
			                </c:otherwise>
			            </c:choose>
			        </label>
			    </div>
			    <div class="form-check-inline">
			        <label class="form-check-label">
			            <c:choose>
			                <c:when test="${stadium.st_door == '1'}">
			                    <input type="radio" class="form-check-input" name="st_door" value="1" checked>실내
			                </c:when>
			                <c:otherwise>
			                    <input type="radio" class="form-check-input" name="st_door" value="1">실내
			                </c:otherwise>
			            </c:choose>
			        </label>
			    </div>
			  </div>
			  <div class="form-group">
				    <label for="st_floortype" style="font-weight: bold;">바닥 종류</label><br>
				    <div class="form-check-inline">
				        <label class="form-check-label">
				            <c:choose>
				                <c:when test="${stadium.st_floortype == '0'}">
				                    <input type="radio" class="form-check-input" name="st_floortype" value="0" checked>인조잔디
				                </c:when>
				                <c:otherwise>
				                    <input type="radio" class="form-check-input" name="st_floortype" value="0">인조잔디
				                </c:otherwise>
				            </c:choose>
				        </label>
				    </div>
			    <div class="form-check-inline">
			        <label class="form-check-label">
			            <c:choose>
			                <c:when test="${stadium.st_floortype == '1'}">
			                    <input type="radio" class="form-check-input" name="st_floortype" value="1" checked>천연잔디
			                </c:when>
			                <c:otherwise>
			                    <input type="radio" class="form-check-input" name="st_floortype" value="1">천연잔디
			                </c:otherwise>
			            </c:choose>
			        </label>
			    </div>
			    <div class="form-check-inline">
			        <label class="form-check-label">
			            <c:choose>
			                <c:when test="${stadium.st_floortype == '2'}">
			                    <input type="radio" class="form-check-input" name="st_floortype" value="2" checked>모래
			                </c:when>
			                <c:otherwise>
			                    <input type="radio" class="form-check-input" name="st_floortype" value="2">모래
			                </c:otherwise>
			            </c:choose>
			        </label>
			    </div>
			    <div class="form-check-inline">
			        <label class="form-check-label">
			            <c:choose>
			                <c:when test="${stadium.st_floortype == '3'}">
			                    <input type="radio" class="form-check-input" name="st_floortype" value="3" checked>인도어
			                </c:when>
			                <c:otherwise>
			                    <input type="radio" class="form-check-input" name="st_floortype" value="3">인도어
			                </c:otherwise>
			            </c:choose>
			        </label>
			    </div>
			  </div>
			 
			  <div class="form-group">
				    <label for="st_available" style="font-weight: bold;">이용 가능 여부</label><br>
				    <div class="form-check-inline">
				        <label class="form-check-label">
				            <c:choose>
				                <c:when test="${stadium.st_available == '0'}">
				                    <input type="radio" class="form-check-input" name="st_available" value="0" checked>가능
				                </c:when>
				                <c:otherwise>
				                    <input type="radio" class="form-check-input" name="st_available" value="0">가능
				                </c:otherwise>
				            </c:choose>
				        </label>
				    </div>
			    <div class="form-check-inline">
			        <label class="form-check-label">
			            <c:choose>
			                <c:when test="${stadium.st_available == '1'}">
			                    <input type="radio" class="form-check-input" name="st_available" value="1" checked>불가능
			                </c:when>
			                <c:otherwise>
			                    <input type="radio" class="form-check-input" name="st_available" value="1">불가능
			                </c:otherwise>
			            </c:choose>
			        </label>
			    </div>
			    <div class="form-check-inline">
			        <label class="form-check-label">
			            <c:choose>
			                <c:when test="${stadium.st_available == '2'}">
			                    <input type="radio" class="form-check-input" name="st_available" value="2" checked>삭제
			                </c:when>
			                <c:otherwise>
			                    <input type="radio" class="form-check-input" name="st_available" value="2">삭제
			                </c:otherwise>
			            </c:choose>
			        </label>
			    </div>
			  </div>
			 </div> 
		  <br>
		  <div class="form-group-inline">
			 <label for="st_width" style="font-weight: bold;">가로 x 세로(m)</label>
			 <div class="input-group">
			    <input type="number" class="form-control text-right" placeholder="가로" name="st_width" 
			    		id="st_width" oninput="numOnly(this)" max="99999" value="${stadium.st_width}" required>
			    <div class="input-group-append">
			      <span class="input-group-text">x</span>
			    </div>
			    <input type="number" class="form-control text-right" placeholder="세로" name="st_height" 
			    		id="st_height" oninput="numOnly(this)" max="99999" value="${stadium.st_height}" required>
			    <span class="input-group-text">(m)</span>
		     </div>
		  </div>
		  <br>
		  
		  <div class="form-group-inline">
		    <label for="st_max" style="font-weight: bold;">최대인원</label>
	   		<div class="input-group">
			    <input type="number" class="form-control text-right" placeholder="최대인원"name="st_max"  
			    		id="st_max" oninput="numOnly2(this)" max="99" value="${stadium.st_max}" required>
		  		<span class="input-group-text">명</span>
		  	</div>
		  </div>
		  <br>
		  
		  <div class="form-group">
			  <label for="st_note" style="font-weight: bold;">특이사항</label> &nbsp;<span class="badge badge-secondary">선택</span>
			  <textarea class="form-control" rows="5" id="st_note" name="st_note">${stadium.st_note}</textarea>
		  </div>
		  <div style="margin: 0 auto;">
			  <button class="btn btn-block">수정</button>
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
	</script>
	
</body>
</html>