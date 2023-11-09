<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>스프링</title>
	<jsp:include page="/WEB-INF/views/include/head.jsp"></jsp:include>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script crossorigin src="https://unpkg.com/react@17.0.2/umd/react.development.js"></script>
	<script crossorigin src="https://unpkg.com/react-dom@17.0.2/umd/react-dom.development.js"></script>
	<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
</head>
<style>
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
	body{ letter-spacing: -2px;}
</style>
<body>
	<tiles:insertAttribute name="header"/>
    <div class="container" style="min-height: calc(100vh - 10px - 184px)">        
        <tiles:insertAttribute name="body"/>
    </div>                                                  
    <tiles:insertAttribute name="footer" />
</body>
<script type="text/javascript">
function ajaxJsonToJson(async, type, url, sendObject, successFunc){
	$.ajax({
		async : async, 
		type : type, 
		url : '<c:url value="/"/>'+url, 
		data : JSON.stringify(sendObject), 
		contentType : "application/json; charset=UTF-8", 
		dataType : "json",
		success : successFunc,
		error : function(a,b,c){
			console.log(a);
			console.log(b);
			console.log(c);
		}
	});
}

function ajaxJsonToJson2(async, type, url, sendObject, successFunc){
	$.ajax({
		async : async, 
		type : type, 
		url : '<c:url value="/"/>'+url, 
		data : sendObject, 
		dataType : "json",
		success : successFunc,
		error : function(a,b,c){
			console.log(a);
			console.log(b);
			console.log(c);
		}
	});
}
</script>
</html>