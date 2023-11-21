<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기장 목록</title>
</head>
<style type="text/css">

	.title-detail{ 
		margin: 50px auto; background-color: #f2f2f2; border-radius: 30px;
		padding: 30px; width: 60%;
	}
	
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
	
	.title-detail{ margin: 50px auto; background-color: #f2f2f2; border-radius: 30px;
	padding: 30px; width: 42%;}

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
	.text{ border-left: 7px solid #c2f296; padding-left: 10px;}
	.match-icon{ width: 25px; height: 25px;}
	.match-info-box{flex: 1}
	.match-info-box1 div{ justify-content: space-between; display: flex;}
	.facility-info-box{ justify-content: space-between; display: flex;}
	.facility-info-icon{ display: flex;}
	.facility-info-icon img{ margin-right: 5px;}
	.facility-info-icon p{padding: 2px;}
	
	.btn-box{
		display:flex;  float:right;
	}
</style>
<body>
	<div class="stadium-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 38%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		[${facility.fa_name}] 경기장 목록</p>
	</div>
	<div class="title-detail">
		<div class="info-box match-box">
			<div class="match-info-box1 match-info justify-content: space-between">
				<label class="text">주소 </label>
				<div>
					<p>${facility.fa_add}${facility.fa_add_detail}</p>
				</div>
				<label class="text">연락처</label>
				<div>
					<p>${facility.fa_phone}</p>
				</div>
			</div>
			<div class="match-info-box2 facility-info">
				<p style="font-size: 19px; font-weight: bold; margin-bottom: 30px;">편의시설</p>
				<div style="flex-direction: column; align-items: center;">
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_park.svg"
								class="match-icon">
							<p>주차장</p>
						</div>
						<div>
							<p>${match.fa_pay == 0 ? '없음' : match.fa_pay == 1 ? '무료' : '유료'}</p>
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
							<p>${match.fa_locker == 0 ? '없음' : '있음'}</p>
						</div>
					</div>
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="	https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_toilet.svg"
								class="match-icon">
							<p>화장실</p>
						</div>
						<div>
							<p>${match.fa_toilet == 0 ? '없음' : '있음'}</p>
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
							<p>${match.fa_shower == 0 ? '없음' : '있음'}</p>
						</div>
					</div>
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="	https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_stadium.svg"
								class="match-icon">
							<p>흡연장</p>
						</div>
						<div>
							<p>${match.fa_smoking == 0 ? '없음' : '있음'}</p>
						</div>
					</div>
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_beverage.svg"
								class="match-icon">
							<p>자판기</p>
						</div>
						<div>
							<p>${match.fa_machine == 0 ? '없음' : '있음'}</p>
						</div>
					</div>
					<div class="facility-info-box">
						<div class="facility-info-icon">
							<img
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_level.svg"
								class="match-icon">
							<p>특이사항</p>
						</div>
						<div>
							<p>${match.fa_note}</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="btn-box">
			<a href="<c:url value='/admin/operatinglist/${facility.fa_num}'/>"
				class="btn btn-outline-info" role="button" style="margin-right:10px;">운영시간</a>
			<a
				href="<c:url value='/admin/facilitylistUpdate?fa_num=${facility.fa_num}'/>"
				class="btn btn-outline-secondary" role="button" style="margin-right:10px;">수정</a>
			<a
				href="<c:url value='/businessman/facilityDelete?fa_num=${facility.fa_num}'/>"
				class="btn btn-outline-secondary" role="button" style="margin-right:10px;">삭제</a>
	</div>


	<form action="<c:url value='/admin/stadiumlist/${facility.fa_num}'/>" method="get">
		<div class="stadium-navigation" style="margin: 100px 0 30px 0; text-align: center;">
			<select class="searchType" name="t">
				<option value="all" <c:if test="${pm.cri.t == 'all'}">selected</c:if>>전체</option>
				<option value="name" <c:if test="${pm.cri.t == 'name'}">selected</c:if>>경기장 이름</option>
				<option value="locate" <c:if test="${pm.cri.t == 'locate'}">selected</c:if>>경기장 위치</option>
			</select>
			<input type="text" class="keyword" name="s" value="${pm.cri.s}">
			<button class="search-btn">검색</button>
		</div>
	</form>
	

	
	
	<div class="table-responsive" style="color: green;">
	  	<input type = "text" class="form-control" hidden="hidden" value="${stadium}">
	    <table class="table">
	      <thead class="thead-dark">
	        <tr class="table-Info">
	          <th hidden="hidden">경기장 번호</th>
	          <th>이름</th>
	          <th>위치</th>
	          <th>실내/외</th>
	          <th>바닥종류</th>
	          <th>가로</th>
	          <th>세로</th>
	          <th>최대인원</th>
	          <th>이용가능여부</th>
	          <th>특이사항</th>
	          <th hidden="hidden">시설번호</th>
	          <th>수정</th>
	        </tr>
	      </thead>
		  <tbody>
	      	<c:forEach items="${stadiumList}" var="stadium">
		        <tr>
		          <td hidden="hidden">${stadium.st_num}</td>
		          <td>${stadium.st_name}</td>
		          <td>${stadium.st_locate}</td>
		          <td>
		            <c:choose>
		                <c:when test="${stadium.st_door == 0}">실외</c:when>
		                <c:when test="${stadium.st_door == 1}">실내</c:when>
		            </c:choose>
			      </td>
		          <td>
		            <c:choose>
		                <c:when test="${stadium.st_floortype == 0}">인조잔디</c:when>
		                <c:when test="${stadium.st_floortype == 1}">천연잔디</c:when>
		                <c:when test="${stadium.st_floortype == 2}">모래</c:when>
		                <c:when test="${stadium.st_floortype == 3}">인도어</c:when>
		            </c:choose>
			      </td>
		          <td>${stadium.st_width}m</td>
		          <td>${stadium.st_height}m</td>
		          <td>${stadium.st_max}명</td>
		          <td>
		            <c:choose>
		                <c:when test="${stadium.st_available == 0}">가능</c:when>
		                <c:when test="${stadium.st_available == 1}">불가능</c:when>
		                <c:when test="${stadium.st_available == 2}">삭제</c:when>
		            </c:choose>
			      </td>
		          <td>${stadium.st_note}</td>
		          <td hidden="hidden">${stadium.st_fa_num}</td>
		          <td><a href="<c:url value='/admin/stadiumlistUpdate?st_num=${stadium.st_num}'/>"
							class="btn btn-outline-secondary" role="button">수정</a></td>
	         	 </tr>
		     </c:forEach>
	      </tbody>
	    </table>
	    
	    <ul class="pagination justify-content-center">
			<c:if test="${pm.prev}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/admin/stadiumlist/${facility.fa_num}${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
				<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
					<a class="page-link" 
						href="<c:url value='/admin/stadiumlist/${facility.fa_num}${pm.cri.getUrl(i)}'/>">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pm.next}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/admin/stadiumlist/${facility.fa_num}${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
				</li>
			</c:if>
	    </ul>
	</div>
		<div style="text-align: left; margin-right: 10px;  float:right;">
		<div class="btn-group btn-group">	    
				<a class="btn" role="button" 
				 style="
						border-radius: 10px; width: 150px; height: 40px; border: none;
						background-color: #c2f296; color: black; margin: 10px 10px 10px 0;"
						href="<c:url value='/admin/facilitylist'/>"
						>시설 목록으로 이동</a>		
		</div>
	</div>		

</body>
</html>