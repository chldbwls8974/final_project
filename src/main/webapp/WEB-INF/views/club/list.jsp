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
	margin-bottom: 30px; display: flex;	border-radius: 40px; 
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
	z-index: 10;
}
.quickmenu ul li {float:left;width:100%; text-align:center;display:inline-block;}
.quickmenu ul li a {
	position:relative; float:left; width:100%; height:30px; line-height:30px; 
	text-align:center; color:white; font-size:50px;
	margin-top:25px; text-decoration:none;
	}

/* 검색창 */
.searchType {
		width: 100px;
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
		width: 400px;
		padding: .8em .5em;
		border-radius: 5px;
		border: 1px solid #999;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		margin-bottom: 20px
	}
	.search-btn{
		width: 80px;
		padding: .8em .5em;
		border-radius: 5px;
		border: none;
		background-color: #c2f296;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
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
		<!-- 검색창 -->
		<div class="search-navigation" style="margin-top: 20px; text-align: center;">
				<select class="searchType" name="searchType">
					<option value="전체">전체</option>
					<c:forEach items="${regionList}" var="list">
						<option value="${list.rg_main}">${list.rg_main}</option>
					</c:forEach>
				</select>
				<input type="search" class="keyword" name="keyword" placeholder="클럽명을 입력하세요."></input>
				<button type="submit" class="search-btn" onclick="getSearchList()">검색</button>
		</div>
		<!-- 리스트 --> 
		<ul class="clublist-control clubList">
		
		</ul>
	</div>
	
<script type="text/javascript">

	let str = '';
	
	$(document).ready(function(){
		getSearchList();
	});
	
	
	//검색결과 가져오기
	function getSearchList(){
		
		var searchType = $("[name='searchType']").val(); //검색유형
		var keyword = $("[name='keyword']").val();	//내가 검색할 키워드
		data = {
			searchType : searchType,
			keyword : keyword
		}
		
		ajaxJsonToJson2(false, "post", "/club/search", data, (a)=>{
			
			console.log(a)
			console.log("성공");
			
			$('.clubList').empty();
			str=``;
			for(item of a.list){
				str += `
					<div class="box box-emblem">
						<li class="clublist-link clubItem">
							<div>
								<a href="<c:url value='/club/detail?cl_num=\${item.cl_num}'/>">
								 	<img alt="팀엠블럼" src="<c:url value='/clubimg\${item.cl_emblem}'/>" style="width: 70px; height: 70px; border-radius: 50%">
								  	<p>\${item.cl_name}</p> 
								</a> 
							</div>	
			  			</li>
		  			</div>
				`;
			}
			$('.clubList').html(str);
					
	       });
	}
	
	function enterkey() {
	    if (window.event.keyCode == 13) {
	         document.getElementById("member-search-navigation").submit();
	    }
	}




	//클럽 생성 버튼
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