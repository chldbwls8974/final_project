<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 목록</title>
</head>
<style type="text/css">
	.btn:hover{
		background-color : outline-info;
		color : white;
	}
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
		width: 870px;
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
		border: none;
		background-color: #c2f296;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
	
	.title-detail{ margin: 50px auto; background-color: #f2f2f2; border-radius: 30px;
	padding: 30px; width: 42%; height: auto; text-align: center;}

	.page-link {
	  color: #000; 
	  background-color: #fff;
	  border: 1px solid #ccc; 
	}
	.page-item.active .page-link {
	 z-index: 1;
	 color: #555;
	 background-color: #f1f1f1;
	 border-color: #ccc;
	 
	}
	.page-link:focus, .page-link:hover {
	  color: #000;
	  background-color: #fafafa; 
	  border-color: #ccc;
	}
	
	.facility-info-box{ justify-content: space-between; display: flex;}
	.facility-info-icon{ display: flex;}
	.facility-info-icon img{ margin-right: 5px;}
	.facility-info-icon p{padding: 2px; margin-top: 10px;}
	.a-btn{ border-radius: 10px; width: 200px; height: 45px; border: none; display: block; padding-top: 10px;
		background-color: #c2f296; color: black; margin: 0 auto;}
	.btn{ border-radius: 10px; width: 90px; height: 45px; border: none;
		background-color: #c2f296; color: black; margin: 0 auto;}	
	.btn-box{text-align: center;}
	tr, td{ text-align: center;}
	.table thead th{ border: none; padding-bottom: 20px;}
	
</style>
<body>
  	<div class="facility-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 18%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		시설 목록</p>
	</div>
	<div class="btn-box">
		<a class="a-btn"
			href="<c:url value='/businessman/facilityInsert'/>">시설 등록하기</a>
  	</div>
	<div class="title-detail" style="background-color: #eefde1;">
		<p><strong style="font-size: 18px; letter-spacing: -3px;">꼭 읽어주세요!</strong></p>
		<p><b>1)</b> 시설등록 후에는 [운영시간] 을 반드시 입력해주세요.
		<br><b>2)</b> [시설명] 클릭 시, 해당 시설의 [경기장 목록] 으로 이동됩니다.</p>
	</div>
	<div class="title-detail">
		<div class="info-box match-box">
			<div class="match-info-box2 facility-info">
				<p style="font-size: 19px; font-weight: bold; margin: 20px 0 30px 0; text-align: center;">
					편의시설</p>
				<div style="flex-direction: column; align-items: center;">
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_park.svg"
								class="match-icon">
							<p>주차장</p>
						</div>
						<div>
							<p>${facility.fa_pay == 0 ? '없음' : facility.fa_pay == 1 ? '무료' : '유료'}</p>
						</div>
					</div>
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_gender.svg"
								class="match-icon">
							<p>탈의실</p>
						</div>
						<div>
							<p>${facility.fa_locker == 0 ? '없음' : '있음'}</p>
						</div>
					</div>
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_toilet.svg"
								class="match-icon">
							<p>화장실</p>
						</div>
						<div>
							<p>${facility.fa_toilet == 0 ? '없음' : '있음'}</p>
						</div>
					</div>
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_shower.svg"
								class="match-icon">
							<p>샤워실</p>
						</div>
						<div>
							<p>${facility.fa_shower == 0 ? '없음' : '있음'}</p>
						</div>
					</div>
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_stadium.svg"
								class="match-icon">
							<p>흡연장</p>
						</div>
						<div>
							<p>${facility.fa_smoking == 0 ? '없음' : '있음'}</p>
						</div>
					</div>
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_beverage.svg"
								class="match-icon" style="margin-left: 8px;">
							<p>자판기</p>
						</div>
						<div>
							<p>${facility.fa_machine == 0 ? '없음' : '있음'}</p>
						</div>
					</div>
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_level.svg"
								class="match-icon">
							<p style="margin-top: 20px;">특이사항</p>
						</div>
						<div>
							<p>${facility.fa_note}</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<form action="<c:url value='/businessman/facility'/>" method="get">
		<div class="facility-navigation" style="margin: 30px 0 30px 0; text-align: center;">
			<select class="searchType" name="t">
				<option value="all" <c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
				<option value="total" <c:if test="${pm.cri.t == 'total'}">selected</c:if>>시설명 + 주소</option>
				<option value="phone" <c:if test="${pm.cri.t == 'phone'}">selected</c:if>>전화번호</option>
			</select>
			<input type="text" class="keyword" name="s" value="${pm.cri.s}">
			<button class="search-btn">검색</button>
		</div>
	</form>

  	
  	
  	<div class="table-responsive">
		<table class="table">
	      <thead class="thead">
	        <tr>
	          <th hidden="hidden">시설 번호</th>
	          <th hidden="hidden">사업자 번호</th>
	          <th hidden="hidden">지역</th>
	          <th>시설명</th>
	          <th>주소</th>
	          <th>상세주소</th>
	          <th>전화번호</th>
	          <th>경기장 수</th>
	          <th>운영시간</th>
	          <th>수정</th>
	          <th>삭제</th>
	        </tr>
	      </thead>
		  <tbody>
	      	<c:forEach items="${list}" var="facility">
	      		<c:if test="${facility.fa_deleted != 1}">
			        <tr>
			          <td hidden="hidden">${facility.fa_num}</td>
			          <td hidden="hidden">${facility.fa_bu_num}</td>
			          <td hidden="hidden">${facility.fa_rg_num}</td>
			          <td><a href="<c:url value='/businessman/stadium/${facility.fa_num}'/>"
			          style="text-align: left; color: #1179b1f5;">${facility.fa_name}</a></td>
			          <td>${facility.fa_add}</td>
			          <td>${facility.fa_add_detail}</td>
			          <td>${facility.fa_phone}</td>
	 				  <td>${facility.st_count}</td>
			       	  <td><a href="<c:url value='/businessman/operating/${facility.fa_num}'/>"
								class="btn" role="button" style="background-color: #bee5eb;">운영시간</a></td>
			          <td><a href="<c:url value='/businessman/facilityUpdate?fa_num=${facility.fa_num}'/>"
								class="btn" role="button">수정</a></td>
					  <td><a href="<c:url value='/businessman/facilityDelete?fa_num=${facility.fa_num}'/>"
						    	class="btn" role="button">삭제</a></td>
		           </tr>
	          </c:if>
		    </c:forEach>
	     </tbody>
	   </table>
	</div>
	
	<ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
			<li class="page-item">
				<a class="page-link" 
					href="<c:url value='/businessman/facility${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
			</li>
		</c:if>
		<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
				<a class="page-link" 
					href="<c:url value='/businessman/facility${pm.cri.getUrl(i)}'/>">${i}</a>
			</li>
		</c:forEach>
		<c:if test="${pm.next}">
			<li class="page-item">
				<a class="page-link" 
					href="<c:url value='/businessman/facility${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
			</li>
		</c:if>
	</ul>


</body>
</html>