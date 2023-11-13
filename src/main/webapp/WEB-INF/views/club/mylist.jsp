<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">

.container{ padding: 50px 0 50px 0;}
.body-container{
	display: flex; justify-content: center; text-align: center;
}

.memberlist-box, .rookielist-box{ margin: 20px; text-align: center;}
.title{ font-size: 30px; font-weight: bolder; text-align: center;
		 letter-spacing: -3px;
}
.memberlist-control, .rookielist-control{
	padding: 20px; background-color: #f0f0f0; border-radius: 40px;
	margin-bottom: 30px;
}
.memberlist-link, .rookielist-link{ display:inline-block; }


</style>
</head>
<body>
	<div class="body-container">
		<div class="memberlist-box">
			<p class="title">‘MEMBER’ 등급인 클럽</p>
			<ul class="memberlist-control">
				<c:forEach items="${memberlist}" var="list">
					<li class="memberlist-link">
						<a href="<c:url value='/club/detail?cl_num=${list.cl_num}'/>">
							<div class="emblem">
								<img alt="엠블럼"
									src="<c:url value='https://ifh.cc/g/v9LAF1.jpg'/>"
									style="width: 70px; height: 70px; border-radius: 50%">
							</div>
							<div>
								<span>${list.cl_name }</span> <span>${list.cl_rg_num }</span>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="rookielist-box">
			<p class="title">‘ROOKIE’ 등급인 클럽</p>
			<ul class="rookielist-control">
				<c:forEach items="${rookielist}" var="list">
					<li class="rookielist-link">
						<a href="<c:url value='/club/detail?cl_num=${list.cl_num}'/>">
							<div>
								<img alt="엠블럼"
									src="<c:url value='https://ifh.cc/g/RyG30R.jpg'/>"
									style="width: 70px; height: 70px; border-radius: 50%">
							</div>
							<div>
								<span>${list.cl_name }</span> <span>${list.cl_rg_num }</span>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</body>
</html>