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
</head>
<body>
	<div class="member-search">
		<div class="member-search-navigation">
				<h3>전체 회원 조회</h3>
				<select  name="searchType">
					<option value="id">아이디</option>
					<option value="name">이름</option>
				</select>
				<input type="text" name="keyword"></input>
				<input type="button" onclick="getSearchList()" value="검색"></input>
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
	function getSearchList(){
		var searchType = $("[name='searchType']").val();
		var keyword = $("[name='keyword']").val();
		data = {
			searchType : searchType,
			keyword : keyword
		}
	
		ajaxJsonToJson2(false, "get", "/member/searchfilter", data, (a)=>{
			console.log(a)
				if(a.res){
					$('#membertable').empty();
					str=``;
					
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
</script>
</html>