<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 검색</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
</head>
<body>
	<div class="member-search">
		<div class="member-search-navigation">
				<h3>전체 회원 조회</h3>
				<select  name="searchType">
					<option value="id">아이디</option>
					<option value="name">이름</option>
				</select>
				<input type="search" name="keyword"></input>
				<button type="submit" onclick="getSearchList()">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
		</div>
		<div>
			<ul id="membertable">
				<c:forEach items="${memberList}" var="member">
				<li>
					<a href="#" class="member-link">
						<img src=""/>
						<span>${member.me_name}</span>
						<span>${member.me_id}</span>
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
		
		ajaxJsonToJson2(false, "get", "/member/searchfilter", data, (a)=>{
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