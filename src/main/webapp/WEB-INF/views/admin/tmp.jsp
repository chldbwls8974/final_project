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
		background-color: rgba(0, 0, 0, 0.5);
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
	<!-- 임시페이지 -->
	<!-- 임시페이지 -->
	<!-- 임시페이지 -->
	<!-- 임시페이지 -->
	<!-- 임시페이지 -->
	<h1>매치전적 임시페이지</h1>

	<!-- 모달버튼 -->
	<button type="button" class="btn btn-outline-warning button--open" data-value="${board.bo_num}">게시글 신고</button>
	
	<!-- 모달창 -->
	<div class="modal--bg">
		<div class="modal--content">
			<p>신고하기</p>
			<form class="modal-form" action="<c:url value='/admin/boardReport/insert'/>" method="post">
				<input type="hidden" class="form-control" name="rp_me_num" value="${user.me_num}" readonly>
				<input type="hidden" class="form-control" name="rp_bo_num" value="${board.bo_num}" readonly>
				<input type="hidden" class="form-control" name="rp_me_num2" value="${board.bo_me_num}" readonly>
				<div class="form-group">
					<select class="form-control isSelected" name="rp_rc_num">
						<option value="0">분류</option>
						<option value="6">음란물</option>
						<option value="7">스팸</option>
						<option value="8">홍보</option>
						<option value="9">광고</option>
						<option value="10">분란 조장</option>
						<option value="11">혐오</option>
						<option value="12">욕설</option>
						<option value="13">기타</option>
					</select>
					<textarea cols="46" rows="6" name="rp_content"></textarea>
				</div>
				<button type="button" class="btn btn-outline-dark button--close">닫기</button> 
				<button class="btn btn-outline-dark">신고</button> 
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
	//모달 옵션 선택여부에 따라 알림창 또는 제출
	$(document).ready(function() {
		$(".modal-form").submit(function(e) {
			// 선택된 값이 0이면 제출을 막고 알림창 띄우기
			var selectedValue = $(".isSelected").val();
			if (selectedValue == 0) {
				alert("옵션을 선택하세요.");
				e.preventDefault(); // 제출 막기
			}
			// 선택된 값이 유효하면 폼이 계속 제출됨
		});
	});
</script>
</html>