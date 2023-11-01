<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 정보 수정</title>
</head>
<body>
	<h1 class="display-3"><span style="color: black; font-weight: bold;">시설 정보 수정</span></h1> <br>
	<form action="<c:url value='/businessman/facilityUpdate'/>" method="post">
	  <input name="fa_num" type="hidden" value="${facility.fa_num}">
	  <div class="form-group" hidden="hidden">
	    <label for="fa_bu_num">사업자 번호</label>
	    <input type="text" class="form-control" id="fa_bu_num" name="fa_bu_num" value="${business.bu_num}">
	  </div>
	  
	  <!--수정전 사항이 수정페이지에 그대로 나타나게 하기 위해 if문과 'selected'속성 사용함 -->
	  <div class="form-group">
	    <label>지역</label>
	    <select class="form-control rg_main"> 
	        <option value="0">지역을 선택하세요</option>
	        <c:forEach items="${MainRegion}" var="main">
    			<option value="${main.rg_main}" <c:if test="${facility.fa_rg_num == main.rg_main.toString()}">selected</c:if>>${main.rg_main}</option>
			</c:forEach>
	    </select>
	  </div>
	  <div class="form-group">
	    <select class="form-control rg_sub" name="fa_rg_num">
	        <option value="0">지역을 선택하세요</option>
	        <c:forEach items="${SubRegion}" var="sub">
	            <option value="${main.rg_sub}" <c:if test="${facility.fa_rg_num == main.rg_sub.toString()}">selected</c:if>>${main.rg_sub}</option>
	        </c:forEach>
	    </select>
	  </div>


	  <div class="form-group">
	    <label for="fa_name">시설명</label>
	    <input type="text" class="form-control" placeholder="시설명을 입력하세요" name="fa_name" id="fa_name" value="${facility.fa_name}" required>
	  </div>
	  
	  <div class="form-group">
		<label for="fa_add">주소</label>
		  <input type="text" class="form-control" placeholder="주소를 입력하세요" name="fa_add" id="fa_add" value="${facility.fa_add}" required>
	  </div>
	  
	  <div class="form-group">
		  <label for="fa_add_detail">상세주소</label>
		  <input type="text" class="form-control" placeholder="상세 주소를 입력하세요" name="fa_add_detail" id="fa_add_detail" value="${facility.fa_add_detail}" required>
	  </div>
	 
	  <div class="form-group">
	    <label for="fa_phone">전화번호</label>
	    <input type="text" class="form-control" id="fa_phone" name="fa_phone" placeholder="-를 제외하고 입력하세요" 
	    		oninput="autoHyphen(this)" maxlength="14" value="${facility.fa_phone}" required>
	  </div>
	  
	  <h3>부대시설</h3>
	   <div class="form-group">
	    <label for="fa_pay" style="font-weight: bold;">주차장</label>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_pay == '0'}">
	                    <input type="radio" class="form-check-input" name="fa_pay" value="0" checked>없음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_pay" value="0">없음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_pay == '1'}">
	                    <input type="radio" class="form-check-input" name="fa_pay" value="1" checked>무료
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_pay" value="1">무료
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_pay == '2'}">
	                    <input type="radio" class="form-check-input" name="fa_pay" value="2" checked>유료
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_pay" value="2">유료
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	  </div>

	  <div class="form-group">
	    <label for="fa_locker" style="font-weight: bold;">탈의실</label>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_locker == '0'}">
	                    <input type="radio" class="form-check-input" name="fa_locker" value="0" checked>없음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_locker" value="0">없음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_locker == '1'}">
	                    <input type="radio" class="form-check-input" name="fa_locker" value="1" checked>있음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_locker" value="1">있음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	  </div>

	  <div class="form-group">
	    <label for="fa_toilet" style="font-weight: bold;">화장실</label>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_toilet == '0'}">
	                    <input type="radio" class="form-check-input" name="fa_toilet" value="0" checked>없음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_toilet" value="0">없음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_toilet == '1'}">
	                    <input type="radio" class="form-check-input" name="fa_toilet" value="1" checked>있음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_toilet" value="1">있음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	  </div>
	  
	  
	  <div class="form-group">
	    <label for="fa_shower" style="font-weight: bold;">샤워실</label>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_shower == '0'}">
	                    <input type="radio" class="form-check-input" name="fa_shower" value="0" checked>없음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_shower" value="0">없음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_shower == '1'}">
	                    <input type="radio" class="form-check-input" name="fa_shower" value="1" checked>있음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_shower" value="1">있음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	  </div>
	  
	  	  <div class="form-group">
	    <label for="fa_smoking" style="font-weight: bold;">흡연장</label>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_smoking == '0'}">
	                    <input type="radio" class="form-check-input" name="fa_smoking" value="0" checked>없음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_smoking" value="0">없음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_smoking == '1'}">
	                    <input type="radio" class="form-check-input" name="fa_smoking" value="1" checked>있음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_smoking" value="1">있음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="fa_machine" style="font-weight: bold;">자판기</label>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_machine == '0'}">
	                    <input type="radio" class="form-check-input" name="fa_machine" value="0" checked>없음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_machine" value="0">없음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	    <div class="form-check-inline">
	        <label class="form-check-label">
	            <c:choose>
	                <c:when test="${facility.fa_machine == '1'}">
	                    <input type="radio" class="form-check-input" name="fa_machine" value="1" checked>있음
	                </c:when>
	                <c:otherwise>
	                    <input type="radio" class="form-check-input" name="fa_machine" value="1">있음
	                </c:otherwise>
	            </c:choose>
	        </label>
	    </div>
	  </div>

	  <div class="form-group">
		  <label for="fa_note">특이사항</label>
		  <textarea class="form-control" rows="5" id="fa_note" name="fa_note">${facility.fa_note}</textarea>
	  </div>
	  <button class="btn btn-secondary btn-block">수정하기</button>
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
			 
			 data={
				 rg_main : rg_main
			}
			//각 지역별 도시 선택 
			ajaxJsonToJson2(false, 'get', '/businessman/facilityUpdate/region1', data, (a)=>{
				var option = "";
				th.parent().next().find('[name=fa_rg_num]').empty();
				let region = '${facility.fa_rg_num}'
				
				for (var i in a.SubRegion){
					var obj = a.SubRegion[i];
		            // 'selected' 속성을 사용하여 선택된 항목 표시
					if (obj.rg_num == region) {
		                option = "<option value='" + obj.rg_num + "' selected>" + obj.rg_sub + "</option>";
		            } else {
		                option = "<option value='" + obj.rg_num + "'>" + obj.rg_sub + "</option>";
		            }
		            th.parent().next().find('[name=fa_rg_num]').append(option);
		        }
		    })
		});

	</script>
	
</body>
</html>