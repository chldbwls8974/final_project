<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 조회</title>
<style type="text/css">
	.searchType {
		width: 150px;
		padding: .8em .5em;
		border: 1px solid #999;
		font-family: inherit;
		background: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F99761B495C84AA8716') no-repeat 95% 50%;
		border-radius: 5px;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		margin-top: 20px;
	}
	.keyword{
		width: 500px;
		padding: .8em .5em;
		border-radius: 5px;
		border: 1px solid #999;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
	.search-btn{
		width: 80px;
		padding: .8em .5em;
		border-radius: 5px;
		border: 1px solid #999;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
	.main{
		padding: 40px; height: auto;
		background-color: #f2f2f2; border-radius: 20px;
	}

</style>
</head>
<body>
	<p style="font-size: 35px; width: 17%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
	시설 조회</p>

	<div class="main">
		<c:forEach items="${list}" var="facility">
			<div>
				<p>${facility.fa_name}</p>
			</div>
			<c:forEach  items="${sublist}" var="stadium">
				<c:if test="${stadium.st_fa_num == facility.fa_num}">
					<div>
					 	<p>${stadium.st_name}</p>
					</div>
				</c:if>
			</c:forEach>
		</c:forEach>
	</div>

<script type="text/javascript">
 $(document).on('click','[name=all-btn]',function(){
	 $('.all').show();
	 $('.available').hide();
	 $('.unavailable').hide();
	 $(".btn2").removeClass("active");
     // 클릭된 버튼에 active 클래스 추가
     $(this).addClass("active");
 })
 $(document).on('click','[name=available-btn]',function(){
	 $('.all').hide();
	 $('.available').show();
	 $('.unavailable').hide();
	 $(".btn2").removeClass("active");
     // 클릭된 버튼에 active 클래스 추가
     $(this).addClass("active");
 })
 $(document).on('click','[name=unavailable-btn]',function(){
	 $('.all').hide();
	 $('.available').hide();
	 $('.unavailable').show();
	 $(".btn2").removeClass("active");
     // 클릭된 버튼에 active 클래스 추가
     $(this).addClass("active");
 })
</script>
</body>
</html>