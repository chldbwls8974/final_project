<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1 class="text1">111</h1>
<h1 class="text2">222</h1>
${member.me_state1}
${member.me_state2}
</body>
<script type="text/javascript">
	let matchBan = ${member.me_state1};
	let boardBan = ${member.me_state2};
	
	$(document).ready(function() {
		if(matchBan == '1'){
			$('.text1').text("매치밴")
		}
		if(boardBan == '1'){
			$('.text2').text("보드밴")
		}
	});
</script>
</html>