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
	<script type="text/javascript">
		let msg = '${requestScope.msg}';
		
		if(msg != null && msg != ''){
			alert(msg);
		}
		
		location.href = '${requestScope.url}';
	</script>
</body>
</html>