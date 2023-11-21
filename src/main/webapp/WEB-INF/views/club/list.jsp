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

.container-body{ position:relative; width: 100%; height: auto; }
.clublist-control{
	width: 600px; padding: 20px; background-color: #f0f0f0; margin: 0 auto;
	margin-bottom: 30px; display: grid;	border-radius: 40px;
}
.clublist-control li{ margin: 10px;}
.clublist-link a{ text-decoration: none; color: black;}

div, ul, li {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;padding:0;margin:0}
.quickmenu {
	position:absolute; width:90px; height:90px; border-radius:45px;
	 top:70%; margin-top:-50px; right:10px; background:#c2f296;
	 margin-right: 200px;
}
.quickmenu ul {
	position:relative; float:left; width:100%; display:inline-block; *display:inline; border:none;
}
.quickmenu ul li {float:left;width:100%; text-align:center;display:inline-block;}
.quickmenu ul li a {
	position:relative; float:left; width:100%; height:30px; line-height:30px; 
	text-align:center; color:white; font-size:50px;
	margin-top:25px; text-decoration:none;
	}
</style>
</head>
<body>
<div class="quickmenu">
  <ul>
    <li><a href="<c:url value='/club/make'/>">+</a></li>
  </ul>
</div>
<div class="container-body">
	<p style="font-size: 35px; font-weight: bolder; margin: 30px auto; border-bottom: 8px solid #c2f296;
	width: 20%; padding: 30px 0 10px 0; text-align: center;">모든 클럽 조회</p>
	<ul class="clublist-control">
	<c:forEach items="${list}" var="list">
		<li class="clublist-link">
			<div>
				<a href="<c:url value='/club/detail?cl_num=${list.cl_num}'/>">
				 	<img alt="팀엠블럼" src="<c:url value='/clubimg${list.cl_emblem}'/>" style="width: 70px; height: 70px; border-radius: 50%">
				  	<p>${list.cl_name}</p> 
				</a> 
			</div>	
  		</li>
  </c:forEach>
  </ul>
</div>
<script type="text/javascript">
$(document).ready(function(){
	  var currentPosition = parseInt($(".quickmenu").css("top"));
	  $(window).scroll(function() {
	    var position = $(window).scrollTop(); 
	    $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000);
	  });
	});
</script>
</body>
</html>