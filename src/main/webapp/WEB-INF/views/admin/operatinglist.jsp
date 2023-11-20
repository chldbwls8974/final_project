<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운영시간</title>
</head>
<style type="text/css">
    .table-responsive {
        display: inline-block;
    }
     .table-bordered td, .table-bordered th {
        text-align: center; /* 테이블 셀 안의 텍스트 가운데 정렬 */
    }
</style>
<body>
  	<div class="operating-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 16%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		운영시간</p>
	</div>

	<div style="text-align: center; margin-right: 10px;">
		<div class="btn-group btn-group">	   
		   <a class="btn" role="button" 
		   		style="
					border-radius: 10px; width: 130px; height: 40px; border: none;
					background-color: #c2f296; color: black; margin: 10px 10px 10px 0;"
		   		href="<c:url value='/admin/operatinglistUpdate/${facility.fa_num}'/>">수정하기</a>
		   <a class="btn" role="button" 
		   		style="
					border-radius: 10px; width: 150px; height: 40px; border: none;
					background-color: #c2f296; color: black; margin: 10px 10px 10px 0;"
		   		href="<c:url value='/admin/facilitylist'/>">시설 목록으로 이동</a>
		</div>
	</div>		
	<br>

	<form action="<c:url value='/admin/operatinglist'/>" method="get">
  	  <div class="table-responsive">
	    <table class="table table-bordered">
	      <thead>
	        <tr class="table-Info">
	          <th hidden="hidden">운영시간 번호</th>
	          <th>요일</th>
	          <th>오픈시간</th>
	          <th>마감시간</th>
	          <th hidden="hideen">시설번호</th>
	        </tr>
	      </thead>
		  <tbody>
	      	<c:forEach items="${operatingList}" var="operating">
		        <tr>
		          <td hidden="hidden">${operating.op_num}</td>
		          <td>${operating.op_day}</td>
		          <td>${operating.op_open}시</td>
		          <td>${operating.op_close}시</td>
		          <td hidden="hideen">${operating.op_fa_num}</td>
	         	</tr>
		     </c:forEach>
	       </tbody>
	     </table>
	   </div>
	</form>
	  
</body>
</html>