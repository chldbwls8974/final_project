<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 정보 수정</title>
</head>
<style type="text/css">
	.container-body{
		background-color: #f2f2f2; height: auto; margin-top: 20px;
		border-radius: 20px; padding: 50px;
	}
	form{
		padding-top:50px;
	}
	.form-control{border-radius: 30px; width: 500px;}
	.form-group{text-align: center;}
	.form-group label{display: inline-block; text-align: center;}
	.form-group button, .form-group select{margin: 0 auto;}
	.form-group input{margin: 0 auto;}
	.fa_pay{
		width: 55%; background-color: #e4f7d3;
		border-radius: 20px; padding:30px; margin:auto;
	}
	.input-file{display: none;}
	.img-thumbnail{
		cursor: pointer; width:200px; height:auto; 
		background-color: transparent; border: none;
	}
	.btn{ border-radius: 10px; width: 300px; height: 45px; border: none;
	background-color: #c2f296; color: black; margin-top: 10px;}
	
</style>
<body>
	<div class="facilityUpdate-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 24%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		시설 정보 수정</p>
	</div>

	<div class="container-body">
		<form action="<c:url value='/businessman/facilityUpdate'/>" method="post">
		  <input name="fa_num" type="hidden" value="${facility.fa_num}">
		  <div class="form-group" hidden="hidden">
		    <label for="fa_bu_num">사업자 번호</label>
		    <input type="text" class="form-control" id="fa_bu_num" name="fa_bu_num" value="${business.bu_num}">
		  </div>
		  
		  <!--수정전 사항이 수정페이지에 그대로 나타나게 하기 위해 if문과 'selected'속성 사용함 -->
		  <div class="form-group">
		    <label style="font-weight: bold;">지역</label>
		    <select class="form-control rg_main" required> 
		        <option value="0">지역을 선택하세요</option>
		        <c:forEach items="${MainRegion}" var="main">
	    			<option value="${main.rg_main}"<c:if test="${facility.fa_rg_main== main.rg_main}">selected</c:if> >${main.rg_main}</option>
				</c:forEach>
		    </select>
		  </div>
		  <div class="form-group">
		    <select class="form-control rg_sub" name="fa_rg_num" required>
		        <option value="0">지역을 선택하세요</option>
		        <c:forEach items="${SubRegion}" var="sub">
		            <option value="${sub.rg_num}">${sub.rg_num}</option>
		        </c:forEach>
		    </select>
		  </div>
	
		  <div class="form-group">
		    <label for="fa_name" style="font-weight: bold;">시설명</label>
		    <input type="text" class="form-control" placeholder="시설명을 입력하세요" name="fa_name" id="fa_name" value="${facility.fa_name}" required>
		  </div>
		  
		  <div class="form-group">
			<label for="fa_add" style="font-weight: bold;">주소</label>
			  <input type="text" class="form-control" placeholder="주소를 입력하세요" name="fa_add" id="fa_add" value="${facility.fa_add}" required>
		  </div>
		  
		  <div class="form-group">
			  <label for="fa_add_detail" style="font-weight: bold;">상세주소</label>
			  <input type="text" class="form-control" placeholder="상세 주소를 입력하세요" name="fa_add_detail" id="fa_add_detail" value="${facility.fa_add_detail}" required>
		  </div>
		 
		  <div class="form-group">
		    <label for="fa_phone" style="font-weight: bold;">전화번호</label>
		    <input type="text" class="form-control" id="fa_phone" name="fa_phone" placeholder="-를 제외하고 입력하세요" 
		    		oninput="autoHyphen(this)" maxlength="14" value="${facility.fa_phone}" required>
		  </div>
		  <br>
		  
		  <h5 class="text-info" style="font-weight: bold; text-align: center; color: black !important;">부대시설</h5>
		  <div class="form-group fa_pay">
			  <div class="form-group">
			    <label for="fa_pay" style="font-weight: bold;">주차장</label><br>
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
			    <label for="fa_locker" style="font-weight: bold;">탈의실</label><br>
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
			    <label for="fa_toilet" style="font-weight: bold;">화장실</label><br>
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
			    <label for="fa_shower" style="font-weight: bold;">샤워실</label><br>
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
			    <label for="fa_smoking" style="font-weight: bold;">흡연장</label><br>
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
			    <label for="fa_machine" style="font-weight: bold;">자판기</label><br>
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
		  </div>
		  <br>
<!-- 		  특이사항 -->
		  	<div class="form-group">
				<label for="fa_note" style="font-weight: bold; text-align:center;">특이사항</label> &nbsp;<span class="badge badge-secondary">선택</span>
				<div style="text-align:center;" >
				<textarea class="form-control"  rows="5" id="fa_note" name="fa_note" style="display:inline-block"> ${facility.fa_note}</textarea>
				</div>
			</div>
			
			<!-- 시설 사진 -->
<%-- 			${files } --%>
<!-- 			여기해야함. 사진이 있는 경우 없는경우 -->
			<div class="form-group picture-box">
			 <label style="font-weight: bold;">시설사진</label> &nbsp;<span class="badge badge-secondary">선택 (최대 3장)</span>
				<div class="form-group box-thumbnail-input">
					<input type="file" name="file" class="input-file input-select" onchange="readUrl(this)"  >
				</div>
				<div class="box-thumbnail">
					<img src="<c:url value='/resources/images/add-image.png'/>" alt="미리보기" class="img-thumbnail img-select" height="100" width="auto">
				</div>
			</div>	
			
			<br>
			 <div style="text-align: center;">
		 		 <button class="btn">수정하기</button>
		  </div>
		</form>
	</div>
	
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
		
		//페이지가 완전히 로드되면 실행 = jQuery의 $(document).ready()와 동일한 역할
		$(function(){	
	         //rg_main에서 change 이벤트가 발생되면 실행
			 $(document).on('change','.rg_main',function(){
				 //변수 생성 -> 현재 이벤트가 발생한 rg_main의 select 요소를 객체로 가져옴
				 let th = $(this);
				 //선택한 옵션 값을 가져와서 rg_main 변수에 저장
				 rg_main = th.val();
				 
				 data={
					 rg_main : rg_main
				}
				//각 지역별 도시 선택 
				ajaxJsonToJson2(false, 'get', '/businessman/facilityUpdate/region1', data, (a)=>{
					var option = "";
					// name이 'fa_rg_num'인 요소를 찾고, 그 안의 내용을 비움
					th.parent().next().find('[name=fa_rg_num]').empty();
					//facility.fa_rg_num의 값을 변수 region에 할당
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
	         //트리거를 통해 rg_main의 모든 select 요소에 대해 change 이벤트를 수동으로 발생. 
	         //=> 이벤트가 발생하면 선택한 옵션에 따라 다른 도시를 로드하고 옵션을 설정함
			$(".rg_main").trigger('change')
	    })
	</script>
	
</body>
</html>