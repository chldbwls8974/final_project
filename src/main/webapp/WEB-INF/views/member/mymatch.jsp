<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신청 경기</title>
</head>
<body>
	<h3>신청 경기 조회</h3>
  <div class="container">
  <table class="table table-hover">
    <thead>
      <tr>
      	<th>매치 날짜</th>
      	<th>매치 타입</th>
        <th>경기장 이름</th>
        <th>매치 인원</th>
      </tr>
    </thead>
    <tbody>
   	 <c:forEach items="${matchList}" var="mt" >
	      <tr>
	      	<td>${mt.mt_date}</td>
	      	<td>${mt.mt_type}</td>
	        <td>${st_name}</td>
	        <td>${mt.mt_personnel}</td>
	      </tr>
      </c:forEach>
    </tbody>
  </table>
  </div>
</body>
</html>