<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	
</style>
<body>
	<h1 class="text1">회원님은 정지상태 입니다.</h1>
	<div class="ban boardBan">
		<span>커뮤니티 정지 ${BoardBanEndDate } 까지</span>
	</div>
	<div class="ban matchBan">
		<span>경기 정지 ${MatchBanEndDate } 까지</span>
	</div>
</body>


<script type="text/javascript">
	let matchBan = ${member.me_state1};
	let boardBan = ${member.me_state2};
	
	$(document).ready(function() {
		$('.ban').hide();
		
		if(matchBan == '1'){
			$('.matchBan').show();
		}
		if(boardBan == '1'){
			$('.boardBan').show();
		}
	});
</script>
</html>