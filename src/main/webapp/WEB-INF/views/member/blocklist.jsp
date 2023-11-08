<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	
	li{list-style: none; text-align: start;}
	p, span{text-decoration: none; color: black;}
	p:hover, span:hover {text-decoration: none;}
	#blocktable{ background-color: #f0f0f0; height: 100%; 
		padding: 40px 0 100px 0; margin: 30px 10px 0px 10px; border-radius: 30px;}
	.blocktable-list{
		margin: 0 80px 50px 80px; display: flex; border-bottom: 1px solid rgba(0,0,0,.1);
		height: 100%;
	}
	.text{ font-weight: bold;}
	.myprofile-image-thumb{
		width: 70px; height: 70px; border-radius: 50%;
		 margin-right: 10px;
	}	

</style>
</head>
<body>
	<div class="member-search">
		<div class="member-search-navigation" style="margin-top: 50px; text-align: center;">
			<select class="searchType" name="searchType">
				<option value="id">아이디</option>
				<option value="name">이름</option>
			</select>
			<input type="search" class="keyword" name="keyword" placeholder="검색할 회원을 입력하세요."></input>
			<button type="submit" class="search-btn" onclick="getSearchList()">검색
			</button>
		</div>
	</div>	
	<div style="width: 100%;">
		<ul id="blocktable">
			<div style="display: flex; margin-left: 80px;">
				<p class="text">차단한 회원</p>
			</div>
			<c:forEach items="${memberList}" var="member">
			<li class="blocktable-list">
				<a href="#" class="block-link">
					<img src="/final_project${user.me_profile}" class="myprofile-image-thumb" alt="프로필 사진">
					<span style="font-weight: bold; font-size: large;">${member.me_name}</span>
					<span style="font-size: small; color: gray;">${member.me_id}</span>
				</a>
			</li>
			</c:forEach>
		</ul>
	</div>

</body>
</html>