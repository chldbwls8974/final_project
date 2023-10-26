<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 프로필 수정</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
<body>
	<form class="myprofile-photo" action="<c:url value='/member/myedit'/>" method="post" enctype="multipart/form-data">			
	  <h1 class="h3 mb-3 fw-normal">내 정보 수정</h1>
		<div class="myprofile">
			<input type="file" name="profileImage" id="profileUpdate">
		    <input type="submit" value="사진 수정">
		    <input type="button" value="초기화" onclick="">
		</div>	
        <hr>

        <input type="hidden" id="id" value="${member.me_id}" readonly >

        <div class="myprofile">
            <label for="nickname">닉네임</label>
            <input type="text" class="form-control" value="${member.me_nickname}" oninput="nicknameModify()">
            <span class="nickname_ok">사용 가능한 닉네임입니다.</span>
            <span class="nickname_already">이미 사용 중인 닉네임입니다.</span>
        </div>
         <div class="myprofile">
            <label for="age">나이</label>
            <input type="text" class="form-control" id="age" readonly>
        </div>
        <div class="myprofile">
            <label for="gender">성별</label>
			<input type="radio" name="me_gender" value="M">남
			<input type="radio" name="me_gender" value="F">여
        </div>
        <div class="myprofile">
            <label for="email">이메일</label>
            <input type="email" class="form-control" id="email" value="${member.me_email}">
        </div>
		<div>
		<button class="btn-update btn-outline-warning col-12" onclick="updateProfile()">수정</button>
		</div>
	</form>
</body>
<script type="text/javascript">
	//수정버튼 누르면 업데이트
	function updateProfile(){
		$("#btn-update").on("click",()=>{
			this.update();
		});
		let data = {
			searchType = $("[name='profileImage']").val();	
			id : $("#id").val(),
			id : $("#nickname").val(),
			id : $("#age").val(),
			id : $("#gender").val(),
			id : $("#email").val()
		}
		ajaxJsonToJson2(false, "post", "/member/myedit", data, (a)=>{
			console.log(a)
// 				if(a.res){
// 					$('#membertable').empty();
// 					str=``;
					
// 					for(me of a.memberList){
// 						str += `
// 							<li>
// 								<a href="#" class="member-link">
// 									<img src=""/>
// 									<span>\${me.me_name}</span>
// 									<span>\${me.me_id}</span>
// 								</a>
// 							</li>
// 						`;
// 					}
// 					$('#membertable').html(str); 
// 				}else{
// 					alert('실패');
// 				}
	       });
	}
</script>
</html>