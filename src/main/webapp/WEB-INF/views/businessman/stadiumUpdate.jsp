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
		  
		  <h5 class="text-info" style="font-weight: bold;">[체크 사항]</h5>
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
		    
		    <div id="availabilityFields" style="display: none;">
			  <div class="form-group">
			        <label for="av_notdate" style="font-weight: bold;">불가적용 날짜</label>
			        <input type="text" class="form-control" id="av_notdate" name="av_notdate" value="${availability.av_notdate}" placeholder="날짜를 선택하세요">
			  </div>
			
			  <div class="form-group">
			        <label for="av_reason" style="font-weight: bold;">사유</label>
			        <input type="text" class="form-control" id="av_reason" name="av_reason" value="${availability.av_reason}" placeholder="사유를 입력하세요">
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
		  
		  <button class="btn btn-info btn-block">수정</button>
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