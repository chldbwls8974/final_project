<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 검색</title>
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
	li{list-style: none;}
	p, span{text-decoration: none; color: black;}
	p:hover, span:hover {text-decoration: none;}
	
	
</style>
</head>
<body>
	<div class="member-search">
		<div class="member-search-navigation" style="text-align: center;">
				<select class="searchType" name="searchType">
					<option value="id">아이디</option>
					<option value="name">이름</option>
				</select>
				<input type="search" class="keyword" name="keyword"></input>
				<button type="submit" class="search-btn" onclick="getSearchList()">검색
				</button>
		</div>
			<div>
				<ul id="membertable">
					<c:forEach items="${memberList}" var="member">
					<li style="margin-left: 80px;">
						<a href="#" class="member-link">
							<img src=""/>
							<p style="font-weight: bold; font-size: large;">${member.me_name}</p>
							<span style="font-size: small; color: gray; margin-top: 0">${member.me_id}</span>
						</a>
					</li>
					</c:forEach>
				</ul>
			</div>
	</div>
</body>
<script type="text/javascript">

	let str = '';
	//검색결과 가져오기
	function getSearchList(){
		var searchType = $("[name='searchType']").val(); //검색유형
		var keyword = $("[name='keyword']").val();	//내가 검색할 키워드
		data = {
			searchType : searchType,
			keyword : keyword
		}
		
		ajaxJsonToJson2(false, "post", "/member/searchfilter", data, (a)=>{
			console.log(a)
				if(a.res){
					$('#membertable').empty();
					str=``;
					//검색값을 반복
					for(me of a.memberList){
						str += `
							<li>
								<a href="#" class="member-link">
									<img src=""/>
									<span>\${me.me_name}</span>
									<span>\${me.me_id}</span>
								</a>
							</li>
						`;
					}
					$('#membertable').html(str); 
				}else{
					alert('실패');
				}
	       });
	}
	
	function enterkey() {
        if (window.event.keyCode == 13) {
             document.getElementById("member-search-navigation").submit();
        }
	}
	
</script>
</html>