<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시페이지</title>
<style>
	/* 모달 */
	.modal--bg {
		display: none;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.3);
		justify-content: center;
		align-items: center;
	}
	
	.modal--content {
		background-color: white;
		padding: 20px;
		border-radius: 5px;
		max-width: 400px;
		margin: 200px auto;
	}
</style>    
</head>
</head>
<body>
${match.mt_num } 
	<!-- 임시페이지 -->
	<!-- 임시페이지 -->
	<!-- 임시페이지 -->
	<!-- 임시페이지 -->
	<!-- 임시페이지 -->
	<h1>매치전적 임시페이지</h1>
	<c:forEach items="${entryList}" var="list">
		<span>${list.en_me_num }</span>
	</c:forEach>
	<!-- 모달버튼 -->
	<button type="button" class="btn btn-outline-warning button--open" data-value="${board.bo_num}">게시글 신고</button>
	
	<!-- 모달창 -->
	<div class="modal--bg">
		<div class="modal--content">
			<p style="font-size: 20px; font-weight: bolder; margin: 0 auto; border-bottom: 8px solid #c2f296;
			width: 20%; padding: 20px 0 10px 0; text-align: center;">신고하기</p>
			<!-- 일단 여기부터 작업 -->
			<form class="modal-form" action="<c:url value='/member/matchReport/insert'/>" method="post">
				<input type="hidden" class="form-control" name="rp_me_num" value="${user.me_num}" readonly>
				<input type="hidden" class="form-control" name="rp_mt_num" value="${match.mt_num}" readonly>
				<!-- 셀렉트로 닉네임 선택하면 value는 me_num이 전송되게 -->
					<select class="form-control isSelected1" name="rp_me_num2">
						<option value="0" selected>닉네임 선택</option>
						<c:forEach items="${entryList}" var="list">
							<option value="${list.en_me_num }">${list.en_me_num}(닉네임)</option>
						</c:forEach>
					</select>
				<div class="form-group">
					<select class="form-control isSelected2" name="rp_rc_num">
						<option value="0">분류</option>
						<option value="1">폭행</option>
						<option value="2">욕설</option>
						<option value="3">지각</option>
						<option value="4">음주</option>
						<option value="5">비매너 플레이</option>
					</select>
					<textarea cols="46" rows="6" name="rp_content"></textarea>
				</div>
				<div style="text-align: center; margin-top: 40px;">
					<button type="button" style="background-color: black; color: white; border-radius: 10px; width: 80px;"
						class="btn button--close">닫기</button> 
					<button  style="background-color: black; color: white; border-radius: 10px; width: 80px;"
						class="btn">신고</button> 
				</div>	 
			</form> 
		</div>
	</div>

</body>
<script type="text/javascript">
	//모달 
	$(document).ready(function() {
		$('.button--open').click(function() {
			showModal();
		});

		$('.button--close').click(function() {
			closeModal();
		});

		function showModal() {
			$('.modal--bg').fadeIn();
		}

		function closeModal() {
			$('.modal--bg').fadeOut();
		}
	});
	//모달 옵션 선택하지 않으면 제출하지 못하게
	$(document).ready(function() {
		$(".modal-form").submit(function(e) {
			var selectedValue1 = $(".isSelected1").val();
			var selectedValue2 = $(".isSelected2").val();
			if (selectedValue1 == 0) {
				alert("대상을 선택하세요.");
				e.preventDefault(); // 제출 막기
			}
			if(selectedValue2 == 0){
				alert("신고 종류를 선택하세요.");
				e.preventDefault();
			}
		});
	});
</script>
</html>