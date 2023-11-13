<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">
</style>
</head>
<body>
${club }

<!-- 이거 밑에 있는 이것들은 버튼들임. -->
	<div class="container"> 
<!-- 	그 무엇도 아닌 사람은 가입신청을 할 수 있다. -->
	<c:if test="${authority.cm_authority != 'LEADER' && authority.cm_authority != 'ROOKIE' && authority.cm_authority != 'MEMBER'}">
		<a href="<c:url value='/club/join?cl_num=${club.cl_num}'/>">
		 	<button type="button" class="btn btn-outline-success">가입신청하기</button>
		 </a>
	</c:if>
<!-- 	이미 신청한 사람은 중복으로 신청할 수 없으므로 승인대기중을 보여줘야한다. -->
	 <c:if test="${authority.cm_authority == 'ROOKIE'}">
	 	<button type="button" class="btn btn-outline-success">승인대기중</button>
	 	<button type="button" class="btn btn-outline-success" name="withdraw-btn">가입취소</button>
	 </c:if>
<!-- 	멤버는 가입했던 클럽을 탈퇴할 수 있다. -->
	 <c:if test="${authority.cm_authority == 'MEMBER'}">
	 	<button type="button" class="btn btn-outline-success" name="withdraw-btn">탈퇴</button>
	 </c:if>
<!-- 	 클럽의 팀장인 사람은 클럽관리를 할 수 있다. -->
	 <c:if test="${authority.cm_authority == 'LEADER'}">
			<ul>
				<li class="dropdown">
				<a class="dropdown-toggle" href="#" data-toggle="dropdown">
				관리
				</a>
				<div class="dropdown-menu">
						<a class="dropdown-item" href="<c:url value='/club/update?cl_num=${club.cl_num}'/>">수정</a>
						<a class="dropdown-item" href="<c:url value='/club/manage?cl_num=${club.cl_num}'/>">멤버관리</a>
				</div>
			</li>
			</ul>
	
	 </c:if>
	</div>
	
	<script type="text/javascript">
	$(document).on('click','[name=withdraw-btn]',function(){
		if(confirm("정말 그만두시겠습니까")){
			me_num = ${user.me_num}
			cl_num = ${club.cl_num}
			data = {
					me_num : me_num,
					cl_num : cl_num,
					type : "withdraw"
			}
			
			ajaxJsonToJson2(false, 'post','/club/mbmanage',data, (a)=>{
				alert("완료")
			})
		}
	})
	</script>
</body>
</html>