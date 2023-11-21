<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 등록</title>
</head>
<style type="text/css">
	.container-body{
		background-color: #f2f2f2; height: auto; margin-top: 20px;
		border-radius: 20px; padding: 100px;
	}
	.input-file{display: none;}
	.img-thumbnail{cursor: pointer;}
</style>
<body>
	<div class="facilityInsert-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 18%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		시설 등록</p>
	</div>
	
	<div class="container-body">
		<form action="<c:url value='/businessman/facilityInsert'/>" method="post"  enctype="multipart/form-data">
			
			<div class="form-group" hidden="hidden">
				<label for="fa_bu_num">사업자 번호</label>
			    <input type="text" class="form-control" id="fa_bu_num" name="fa_bu_num" value="${business.bu_num}" readonly>
			</div>
			  
		  	<div class="form-group">
				<label style="font-weight: bold;">지역</label>
				<select class="form-control rg_main" required>
					<option value="0">지역을 선택하세요</option>
						<c:forEach items="${MainRegion}" var="main">
							<option value="${main.rg_main}">${main.rg_main}</option>
						</c:forEach>
				</select>
			</div>
		    <div class="form-group">
				<select class="form-control rg_sub" name="fa_rg_num" required>
						<c:forEach items="${SubRegion}" var="sub">
							<option value="${sub.rg_num}">${sub.rg_sub}</option>
						</c:forEach>
				</select>
		    </div>
	
	  	    <div class="form-group">
			    <label for="fa_name" style="font-weight: bold;">시설명</label>
			    <input type="text" class="form-control" placeholder="시설명을 입력하세요" name="fa_name" id="fa_name" required>
			</div>
			<div class="form-group">
				<label for="fa_add" style="font-weight: bold;">주소</label>
			    <input type="text" class="form-control" placeholder="주소를 입력하세요" name="fa_add" id="fa_add" required>
			</div>
			<div class="form-group">
				<label for="fa_add_detail" style="font-weight: bold;">상세주소</label>
				<input type="text" class="form-control" placeholder="상세 주소를 입력하세요" name="fa_add_detail" id="fa_add_detail" required>
			</div>
			 
			<div class="form-group">
			    <label for="fa_phone" style="font-weight: bold;">전화번호</label>
			    <input type="text" class="form-control" id="fa_phone" name="fa_phone" placeholder="-를 제외하고 입력하세요" oninput="autoHyphen(this)" maxlength="14" required>
			</div>
			<br>
			  
		  	<h5 class="text-info" style="font-weight: bold;">[부대시설]</h5>
		    <div class="form-group">
				<label for="fa_pay" style="font-weight: bold;">주차장</label><br>
			    <div class="form-check-inline">
					<label class="form-check-label">
				  		<input type="radio" class="form-check-input" name="fa_pay" value="0" checked>없음
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
				<label for="fa_locker" style="font-weight: bold;">탈의실</label><br>
			    <div class="form-check-inline">
					<label class="form-check-label">
				  		<input type="radio" class="form-check-input" name="fa_locker" value="0" checked>없음
				    </label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label">
				    	<input type="radio" class="form-check-input" name="fa_locker" value="1" required>있음
				    </label>
				</div>
			</div>
			  
			<div class="form-group">
				<label for="fa_toilet" style="font-weight: bold;">화장실</label><br>
			    <div class="form-check-inline">
					<label class="form-check-label">
				  		<input type="radio" class="form-check-input" name="fa_toilet" value="0" checked>없음
				    </label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label">
				    	<input type="radio" class="form-check-input" name="fa_toilet" value="1" required>있음
				    </label>
				</div>
			</div>
			  
			<div class="form-group">
			    <label for="fa_shower" style="font-weight: bold;">샤워실</label><br>
			    <div class="form-check-inline">
					<label class="form-check-label">
				  		<input type="radio" class="form-check-input" name="fa_shower" value="0" checked>없음
				    </label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label">
				    	<input type="radio" class="form-check-input" name="fa_shower" value="1" required>있음
				    </label>
				</div>
			</div>
			  
			<div class="form-group">
			    <label for="fa_smoking" style="font-weight: bold;">흡연장</label><br>
			    <div class="form-check-inline">
					<label class="form-check-label">
				  		<input type="radio" class="form-check-input" name="fa_smoking" value="0" checked>없음
				    </label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label">
				    	<input type="radio" class="form-check-input" name="fa_smoking" value="1" required>있음
				    </label>
				</div>
			</div>
		
			<div class="form-group">
				<label for="fa_machine" style="font-weight: bold;">자판기</label><br>
			    <div class="form-check-inline">
					<label class="form-check-label">
				  		<input type="radio" class="form-check-input" name=fa_machine value="0" checked>없음
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
			<label for="fa_note" style="font-weight: bold;">특이사항</label> &nbsp;<span class="badge badge-secondary">선택</span>
				<textarea class="form-control" rows="5" id="fa_note" name="fa_note"></textarea>
			</div>
			
<!-- 			시설 사진 -->
			<div class="form-group box-thumbnail-input">
				<input type="file" name="file" class="input-file input-select" onchange="readUrl(this)"  >
			</div>
			<div class="box-thumbnail">
				<img src="" alt="미리보기" class="img-thumbnail img-select" height="100" width="auto">
			</div>
			
			
			
		   <br>
		   <button class="btn btn-info btn-block">등록</button>
	   	   <a class="btn btn-warning btn-block" role="button" href="<c:url value='/businessman/facility'/>">취소</a>
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
		
		
		// 이미지를 클릭하면 input 태그가 클릭되게 하는 이벤트 등록
			$(document).on('click','.img-thumbnail',function(){
				// 이미지 태그가 몇번째 요소인지
				let index =$(this).index();

				// 클릭된 이미지와 순서가 같은 input 태그 클릭
				 $('.input-file').eq(index).click();
			});

			function readUrl(input){
				//input 태그가 첨부파일이고, 첨부파일이 선택되면
				// 파일이 선택 / 취소된 input 요소가 몇번째인지 확인
				let index = $(input).index();

				//$를 써주는 이유는 jquery 요소임을 표기하기 위해서
				let $selectInput = $(input); // 선택된 input 태그 요소
				let $selectImg = $('.img-thumbnail').eq(index); // 선택된 input 태그와 세트인 이미지 태그 요소
				
				if(input.files && input.files[0]){
					let reader = new FileReader();
					reader.onload = function(e){
						$selectImg.prop('src', e.target.result);
					}
					reader.readAsDataURL(input.files[0]);

					// 새 요소를 추가하지 않는 경우 : 현재 바뀐 첨부 파일이 + 가 아닌 요소일때
					if(!$selectImg.hasClass('img-select')){
						return;
					}

					// 새 요소(input 태그와 img 태그) 추가하는 부분
					$selectImg.removeClass('img-select');
					$selectInput.removeClass('input-select');

					// 선택된 이미지가 3개보다 작은 경우
					if($('.img-thumbnail').length < 3){
						$('.box-thumbnail-input').append(`<input type="file" name="file" class="input-file input-select" onchange="readUrl(this)"  >`);
						$('.box-thumbnail').append(`<img src="img.png" alt="미리보기" class="img-thumbnail img-select" height="100" width="auto">`);
					}
				}
				//첨부파일이 선택되지 않으면
				else{
					// + 를 눌러서 첨부 파일을 선택할 때 취소하는 경우
					if($selectImg.hasClass('img-select')){
						$selectImg.prop('src','img.png');
						return;
					}
					// + 앞에 이미지를 클릭하여 첨부파일을 열어서 취소하는 경우
					$selectImg.remove();
					$selectInput.remove();
					if($('.img-select').length == 0){
						$('.box-thumbnail-input').append(`<input type="file" name="file" class="input-file input-select" onchange="readUrl(this)"  >`);
						$('.box-thumbnail').append(`<img src="img.png" alt="미리보기" class="img-thumbnail img-select" height="100" width="auto">`);
					}
					
				}
			}
		
	</script>

</body>
</html>