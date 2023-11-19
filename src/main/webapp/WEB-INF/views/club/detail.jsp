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
	.container-body{ width: 100%; height: auto; display: flex; margin-top: 100px;}
	
	.form-control{border-radius: 30px; width: 500px;}
	.form-group{ display: flex; justify-content: space-between; text-align: center;}
	.form-group button, .form-group select, .form-group input{ margin: 0 auto;}
	.text{ border-left: 7px solid #c2f296; padding-left: 10px;}
	.form-group p{ font-weight: bold;}
	
	.signup-btn{ width: 500px; margin: 0 auto;
		border-radius: 10px; border: none;
		background-color: #0c0c0c; height: 40px; color: white;}
	.next-btn, .prev-btn{width: 500px; margin: 0 auto;
		border-radius: 10px; border: none; height: 40px;
		background-color: #c2f296; color: black;}
	
	input, progress {
	  accent-color: #0c0c0c;
	}

	.profile-head{ 
		text-align: center; padding: 60px 60px 20px 60px;
		background-color: #f2f2f2; border-radius: 20px;
		margin: 0 30px 0 30px; height: auto; width: 250px;
	}
	.title{ 
		font-size: 22px; font-weight: bolder;
		padding: 10px 0; text-align: center; margin: 0;
	}
	.myprofile-image-thumb{
		width: 110px; height: 110px; border-radius: 50%; margin: 0 auto;
	}
	.profile-body{ 
		background-color: #f2f2f2; border-radius: 20px; display: flex; flex-direction: column;
		height: auto; width: 70%; text-align: center; padding: 80px 50px 50px 50px;
	}
	.profile-head2{
		width: 80%; display: flex; margin: 10px auto;
	}
	

	.btn{
		width: 120px; height: 40px; margin: auto auto 10px; border: none;
		border-radius: 5px; background-color: #c2f296; color: black;
	}
	
	.myedit a, .mytime-edit a, .myregion-edit a{
		text-decoration: none; color: black; display: flex;
	}
	.myedit p, .mytime-edit p, .myregion-edit p{
	 	margin: 3px 0 0 0;
	 }
	.myedit a:hover, .mytime-edit a:hover, .myregion-edit a:hover{
		text-decoration: none; color: black;
	}
</style>

</head>
<body>
<div class="container-body">
	<hr style="margin-top: 30px;">
	<div>
		<div class="profile-head">
			<img src="<c:url value='/clubimg${club.cl_emblem}'/>" class="myprofile-image-thumb" alt="팀 엠블럼">
			<p class="title">${club.cl_name}</p> 
			<p style="color: #777777; font-size: 18px;">${member.me_id}</p>
			<!-- 	 클럽의 팀장인 사람은 클럽관리를 할 수 있다. -->
			 <c:if test="${authority.cm_authority == 'LEADER'}">
				 <div style="margin-top: 50px;">
					<div class="myedit">
						<a href="<c:url value='/club/update?cl_num=${club.cl_num}'/>" class="myprofile-btn">
							<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_setting_color.svg"
								style="width: 20px; height: 20px; margin-right: 5px;" alt="프로필 수정">
							<p style="font-size: 14px;">팀 수정</p>
						</a>
					</div>
					<div class="myedit">
						<a class="nav-link" id="email-signout" href="<c:url value='/club/manage?cl_num=${club.cl_num}'/>" style="padding: 0;">
							<img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_profile.svg"
							style="width: 24px; height: 24px; margin-right: 5px;" alt="회원 탈퇴">
							<p style="font-size: 14px;">멤버 관리</p>
						</a>
					</div>
				</div>
			 </c:if>
		</div>	
		<div class="profile-head2">
		<!-- 이거 밑에 있는 이것들은 버튼들임. -->
	<div class="box btn-box"> 
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

	</div>
		
		</div>
	</div>
	
	<div class="profile-body">
		<div class="form-group">
			<label class="text">클럽 소개 </label>
			<div>
				<p> ${club.cl_introduction }</p>
			</div>
		</div>
		<div class="form-group">
			<label class="text">클럽 규칙</label>
			<div>
				<p> ${club.cl_rule }</p>
			</div>
		</div>
		<div class="form-group">
			<label class="text">클럽 외부 url</label>
			<div>
				<p> ${club.cl_url }</p>
			</div>
		</div>
		
		
		
	
	
	</div>
	<hr>
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