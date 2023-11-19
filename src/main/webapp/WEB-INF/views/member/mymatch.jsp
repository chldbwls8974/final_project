<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
      	<th>매치 일시</th>
      	<th>매치 타입</th>
        <th>시설</th>
        <th>경기장</th>
        <th>주소</th>
        <th>매치 인원</th>
        <th>자세히</th>
      </tr>
    </thead>
    <tbody>
   	 <c:forEach items="${matchList}" var="mt" >
	      <tr>
	      	<td>${mt.mt_date_str}<br>${mt.ti_time_str}</td>
	      	<td>${mt.mt_type == 1 ? '개인' : '클럽'} ${mt.mt_rule == 0 ? '친선전' : '경쟁전'} (${mt.mt_personnel} vs ${mt.mt_personnel})</td>
	        <td>${mt.fa_name}</td>
	        <td>${mt.st_name}</td>
	        <td>${mt.fa_add} ${mt.fa_add_detail}</td>
	        <td>${mt.entry_count}/ ${mt.mt_personnel * (mt.mt_rule == 0 ? 2 : 3)}</td>
	        <td>
	        	<input type="number" class="mt_num" value="${mt.mt_num}" hidden disabled>
	        	<input type="number" class="cl_num" value="${mt.cl_num}" hidden disabled>
	        	<button class="btn">바로가기</button>
	        </td>
	      </tr>
      </c:forEach>
    </tbody>
  </table>
  </div>
  <script type="text/javascript">
  $(document).on('click', '.btn', function() {
	mt_num = $(this).siblings('.mt_num').val();
	cl_num = $(this).siblings('.cl_num').val();
	location.href = '<c:url value="/match/application?mt_num="/>' + mt_num + '&cl_num=' + cl_num;
  })
  </script>
</body>
</html>