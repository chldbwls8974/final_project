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

.error{
	color:#f00;
}
body{height: 100%; justify-content: center; align-content: center;}
.kakao-login{ width: 180px;}
.form-control{border-radius: 30px; width: 500px;}
.btn{border-radius: 30px; width: 500px; height: 35px; margin-top: 5px;
	background-color: rgb(190, 226, 250); border-radius: 4px;}

</style>
</head>
<body>

	<div >
		<form action="<c:url value='/member/login'/>" method="post">
			<div class="form-group">
				<label>아이디</label>
				<input type="text" class="form-control" name="me_id" placeholder="아이디">
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" class="form-control" name="me_pw" id="pw" placeholder="비밀번호">
			</div>
			
			<div class="form-check-inline" style="margin-bottom: 20px;">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="true" name="autoLogin">자동로그인
			  </label>
			</div>
			<button class="btn">로그인</button>
		</form>
			<div class="col-lg-12 text-center mt-3">
	<!--     <button class="btn btn-block waves-effect waves-light btn-rounded btn-outline-info mb-3" >로그인하기</button> -->
	  		  <img alt="카카오로그인" src="${pageContext.request.contextPath}/resources/images/kakao_login_medium_wide.png" onclick="loginWithKakao()" class="kakao-login">
			</div>
	</div>

<!-- 카카오 로그인 -->
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>
<script type="text/javascript">
    $(document).ready(function(){
        Kakao.init('51f4399f27ccdb44e2e0f8674689d5ce');
        Kakao.isInitialized();
    });

    function loginWithKakao() {
        Kakao.Auth.authorize({ 
        redirectUri: 'http://localhost:8080/final_project/kakao_callback' 
        }); // 등록한 리다이렉트uri 입력
    }
</script>
</body>
</html>