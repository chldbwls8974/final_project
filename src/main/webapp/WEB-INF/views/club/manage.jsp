<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">
.tag{
display:inline;
}
</style>
</head>
<body>
	<div class="container">
		  <div class="btn-group">
		    <button type="button" class="btn btn-primary" name="member-tag">회원</button>
		    <button type="button" class="btn btn-primary" name="rookie-tag">승인대기</button>
		  </div>
		<div class="table member-table">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>회원 닉네임</th>
						<th>권한</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="list">
						<c:if test="${list.cm_authority !='ROOKIE'}">
							<tr>
								<td>${list.cm_num}</td>
								<td>${list.me_nickname}</td>
								<td>${list.cm_authority}</td>
								<td>
								<c:if test="${list.cm_authority =='MEMBER'}">
									<button type="button" class="btn btn-outline-warning" data-num="${list.cm_me_num}" value="${list.cm_authority}" name="delegate-btn">위임</button>
									<button type="button" class="btn btn-outline-warning" data-num="${list.cm_me_num}" value="${list.cm_authority}" name="discharge-btn">강퇴</button>
								</c:if>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="table rookie-table">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>회원 닉네임</th>
						<th>권한</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="list">
						<c:if test="${list.cm_authority =='ROOKIE'}">
							<tr>
								<td>${list.cm_num}</td>
								<td>${list.me_nickname}</td>
								<td>${list.cm_authority}</td>
								<td>
									<button type="button" class="btn btn-outline-warning" data-num="${list.cm_me_num}" value="${list.cm_authority}" name="approval-btn">승인</button>
									<button type="button" class="btn btn-outline-warning" data-num="${list.cm_me_num}" value="${list.cm_authority}" name="refuse-btn">거절</button>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>

	<script type="text/javascript">
		let cl_num = ${club.cl_num}
		// 표 전환
		$('.rookie-table').hide();
		
		$(document).on('click','[name = member-tag]',function(){
			$('.member-table').show();
			$('.rookie-table').hide();
		})
		$(document).on('click','[name=rookie-tag]',function(){
			$('.member-table').hide();
			$('.rookie-table').show();
			
		})
		
		// 멤버 테이블 관리
		// 강퇴 버튼 클릭시
		
		
		// 위임 버튼 클릭시
		
		
		
		
		// 루키 테이블 관리
		// 승인버튼 클릭시
		$(document).on('click','[name=approval-btn]',function(){
			let me_num = $(this).data('num')
			let type="approval"
			let authority = $(this).val();
			
			data={
					cl_num : cl_num,
					me_num : me_num,
					authority : authority,
					type : type
			}
			
			ajaxJsonToJson2(false, 'post','/club/mbmanage',data, (a)=>{
				alert("팀원 신청을 승인하였습니다.")
			})
			
		})

		// 거절버튼 클릭시
		$(document).on('click','[name=refuse-btn]',function(){
			let me = $(this).data('num')
			let type="refuse"
			let authority = $(this).val();
			
			data={
					cl_num : cl_num,
					me_num : me_num,
					authority : authority,
					type : type
			}
			
			ajaxJsonToJson2(false, 'post','/club/mbmanage',data, (a)=>{
			 	alert("팀원 신청을 거절하였습니다.")
			})
		})
		
	</script>

</body>
</html>