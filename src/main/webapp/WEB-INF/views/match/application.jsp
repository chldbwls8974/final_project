<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>매치 페이지</title>
	<style type="text/css">
	nav{width: 100%; display: flex;}
	input{text-align: right;}
	.left-box{flex: 2;}
	.right-box{flex: 1; height: 500px; padding-left: 10px}
	.contents-box{padding-top: 10px}
	.info-box{
	width: 100%; background-color: white; height: 300px; margin-bottom: 10px;
	border: 3px solid black; box-sizing: border-box;
	}
	.right-side-box{
	width: 100%; height: 200px; float: right; margin-bottom: 10px;
	border: 3px solid black; box-sizing: border-box;
	}
	</style>
</head>
<body>
	<h1>매치 페이지</h1>
	<nav class="container">
		<div class="contents-box left-box">
			<div class="info-box match-box">
			${match}
			</div>
			<div class="info-box factility-box">
			</div>
		</div>
		<div class="contents-box right-box">
			<c:if test="${(match.mt_type == 0 && type == 0) || (match.mt_type == 1 && type == 0)}">
				<c:if test="${match.entry_res == 0}">
					<div class="application-box right-side-box">
						<h4>개인 매치 신청</h4>
						<span>비용 : ${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre}포인트/2시간</span>
						<input type="text" class="total-price" disabled value="${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre}"> <br>
						<button class="btn btn-outline-primary btn-application">신청</button>
					</div>
					<div class="coupon-box right-side-box">
						<h4>보유 쿠폰</h4>
						<c:forEach items="${couponList}" var="co">
							<div>
								<input type="radio" name="coupon" value="${co.hp_num}">${co.cp_source}(${co.cp_sale}) <br>
								<input type="text" class="sale-point" value="${co.cp_sale}" hidden>
							</div>
						</c:forEach>
					</div>
				</c:if>
				<c:if test="${match.entry_res != 0}">
					<div class="cansel-box right-side-box">
						<h4>취소</h4>
						<button class="btn btn-outline-danger btn-cansel">신청 완료</button>
					</div>
				</c:if>
			</c:if>
			<c:if test="${(match.mt_type == 0 && type == 1) || (match.mt_type == 2 && type == 1)}">
				<div class="application-box right-side-box">
					<h4>클럽 매치 신청</h4>
					<span>비용 : ${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre}포인트/2시간</span>
					<input type="text" class="total-price" disabled value="${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre}"> <br>
					<button class="btn btn-outline-primary btn-application">신청</button>
				</div>
			</c:if>
			<c:if test="${(match.mt_type == 1 && type == 1) || (match.mt_type == 2 && type == 0)}">
				<h1>잘못된 접근입니다.</h1>			
			</c:if>
		</div>
	</nav>
	<script type="text/javascript">
	let type = ${type};
	let hp_num = 0;
	let total_price = ${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre};
	let mt_num = ${match.mt_num}
	$(document).on('click', '[name=coupon]', function() {
		hp_num = $(this).val();
		total_price = ${expense.ex_state == 0 ? expense.ex_price : expense.ex_pre} - $(this).siblings('.sale-point').val();

		$('.total-price').val(total_price);
	});
	$(document).on('click', '.btn-application', function() {
		application()
	});
	$(document).on('click', '.btn-cansel', function() {
		cansel()
	});
	
	function application() {
		if(type == 0){
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/match/application/solo"/>',
				data : {mt_num:mt_num, total_price:total_price, hp_num:hp_num},
				dataType : 'json',
				success : function(data) {
					if(data.res){
						alert(data.msg);
						location.href='<c:url value="/match/application?mt_num="/>'+ ${match.mt_num} + '&type=' + ${type};
					}else{
						alert(data.msg);
					}
				}
			});
		}else if(type == 1){
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/match/application/club"/>',
				data : {},
				dataType : 'json',
				success : function(data) {
				
				}
			});
		}
	}
	function cansel() {
		if(type == 0){
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/match/cansel/solo"/>',
				data : {mt_num:mt_num},
				dataType : 'json',
				success : function(data) {
					if(data.res){
						alert(data.msg);
						location.href='<c:url value="/match/application?mt_num="/>'+ ${match.mt_num} + '&type=' + ${type};
					}else{
						alert(data.msg);
					}
				}
			});
		}else if(type == 1){
			$.ajax({
				async : false,
				method : 'post',
				url : '<c:url value="/match/cansel/clup"/>',
				data : {},
				dataType : 'json',
				success : function(data) {
					
				}
			});
		}
	}
	</script>
</body>
</html>
