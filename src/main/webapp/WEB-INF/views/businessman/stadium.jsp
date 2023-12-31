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
	    height: 60px;
	    margin-top: 20px;
		border-radius: 5px;
		border: 1px solid #999;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
	.search-btn{
		width: 80px;
		height: 60px;
	    margin-top: 20px;
		border-radius: 5px;
		border: none;
		background-color: #c2f296;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}

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
	
	/* 슬라이드쇼 */
	.slider__wrap {
        width: 100%;
        height: 450px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    /* 이미지 보이는 부분 */
    .slider__img {
        position: relative;
        width: 600px;
        height: 400px;
        overflow: hidden;
    }
     /* 이미지 감싸고 있는 부모 : 움직이는 부분 */
    .slider__inner {
        display: flex;
        flex-wrap: wrap;
        /* 총 이미지 5개 */
        width: 3600px;
        height: 400px;
    }
    
	/* 개별 이미지 */
	.slider{
		position: relative;
		width: 800px;
		height: 400px;
	}
	
	.slider img{
		width: 100%;
	}
	.slider::before {
        position: absolute;
        left: 5px;
        top: 5px;
        background: rgba(0, 0, 0, 0.4);
        color: #fff;
        padding: 5px 10px;
    }
    
	.slider__btn {
	    position: absolute;
	    width: 43%;
	    display: flex;
	    justify-content: space-between;
	    transform: translateY(-50%);
  	}
	.controller span{
	  position:absolute;
	  background-color: transparent;
	  color: black;
	  text-align: center;
	  border-radius: 50%;
	  padding: 10px 20px;
	  top: 50%;
	  font-size: 1.3em;
	  cursor: pointer;
	}
  .prev,
  .next {
    background-color: transparent;
    border: none;
    font-size: 20px;
    cursor: pointer;
  }
  .prev{ margin-left: 30px;}
  .next{ margin-right: 30px;}
	.add-btn, .link-btn{
		border-radius: 10px !important; width: 150px; height: 40px; border: none;
		background-color: #c2f296; color: black; margin: 10px; line-height: 35px;
	}
	.up-btn{
		border-radius: 10px !important; padding: 10px; border: none;
		background-color: #c2f296; color: black; line-height: 35px;
	}
	tr, td{ text-align: center;}
	.btn-group>.btn:not(:last-child):not(.dropdown-toggle),
	.btn-group>.btn:not(:first-child){ border-radius: 0;}

  
	.title-detail{margin: 0px auto; background-color: white; border-radius: 30px;
		padding: 30px; width: 500px; height: auto; text-align: center; background-color: #f2f2f2;
	}
	.facility-info-box{ justify-content: space-between; display: flex;}
	.facility-info-icon{ display: flex;}
	.facility-info-icon img{ margin-right: 5px;}
	.facility-info-icon p{padding: 2px; margin-top: 10px;}
	.a-btn{ border-radius: 10px; width: 200px; height: 45px; border: none; display: block; padding-top: 10px;
		background-color: #c2f296; color: black; margin: 0 auto;}
	
</style>
<body>
	<div class="stadium-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 38%; font-weight: bolder; margin: 10px auto; padding: 20px 0 10px 0;">
		[${facility.fa_name}] 경기장 목록</p>
	</div>
	
	<div style="text-align: center;">
		<div class="btn-group btn-group">	    
				<a class="add-btn" role="button" 
				 href="<c:url value='/businessman/stadiumInsert/${facility.fa_num}'/>"
						>경기장 등록하기</a>		
				<a class="link-btn" role="button" 
				 href="<c:url value='/businessman/facility'/>"
						>시설 목록으로 이동</a>		
		</div>
	</div>		
	<!-- 	시설 사진 슬라이드쇼 -->
	<div class="sliderType01">
		<div class="slider__wrap">
			<div class="slider__img">
				<div class="slider__inner">
				<c:if test="${files != null && files != '' }">
					<c:forEach items="${files}" var="file">
						<div class="slider">
								<img class="item" src="<c:url value='/facilityimg${file.fp_name }'/>" alt="Image">
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty files}">
				    <div class="slider">
				        <img class="item" src="<c:url value='/resources/images/add.png'/>" alt="Image">
				    </div>
				</c:if>
				</div>
			</div>	
	      <!-- 화살표 -->
			<div class="slider__btn">
		    	<button class="prev">＜</button>
		    	<button class="next">＞</button>  
		    </div>
	    </div>
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
					</div>
				</div>	
			</div>
		</div>
		<c:if test="${facility.fa_note != null && facility.fa_note != ''}">
			<div class="title-detail" style="margin: 10px auto;">
				<div class="facility-info-box">
					<div class="facility-info-icon">
						<img
							src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_level.svg"
							class="match-icon">
						<p>특이사항</p>
					</div>
					<div>
						<p>${facility.fa_note}</p>
					</div>
				</div>
			</div>
		</c:if>	
	
<!-- 	검색창 -->
	<form action="<c:url value='/businessman/stadium/${facility.fa_num}'/>" method="get">
		<div class="stadium-navigation" style="margin: 30px 0 30px 0; text-align: center; display: flex;">
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
		      	<!-- st_available 값이 '2(삭제)'아닌것만 화면에 보이게 함 -->
		      	<c:if test="${stadium.st_available != 2}">
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
			          <c:if test="${stadium.st_available == 0}">
						    <td>
						        <strong>가능</strong><br>
						    </td>
					  </c:if>
			          <c:if test="${stadium.st_available == 1}">
						    <td>
						        <strong>불가능</strong><br>
						        <span>날짜: ${stadium.availability.av_notdate_str}</span><br>
						        <span>사유: ${stadium.availability.av_reason}</span>
						    </td>
					  </c:if>
					  <td>${stadium.st_note}</td>
			          <td hidden="hidden">${stadium.st_fa_num}</td>
			          <td style=""><a href="<c:url value='/businessman/stadiumUpdate?st_num=${stadium.st_num}'/>"
								class="up-btn" role="button">수정</a></td>
		         	 </tr>
    	         </c:if>
		     </c:forEach>
	      </tbody>
	    </table>
	    
	    <ul class="pagination justify-content-center">
			<c:if test="${pm.prev}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/businessman/stadium/${facility.fa_num}${pm.cri.getUrl(pm.startPage-1) }'/>">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
				<li class="page-item <c:if test='${pm.cri.page == i }'>active</c:if>">
					<a class="page-link" 
						href="<c:url value='/businessman/stadium/${facility.fa_num}${pm.cri.getUrl(i)}'/>">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pm.next}">
				<li class="page-item">
					<a class="page-link" 
						href="<c:url value='/businessman/stadium/${facility.fa_num}${pm.cri.getUrl(pm.endPage+1) }'/>">다음</a>
				</li>
			</c:if>
	    </ul>
	</div>
<script>
	
	//이미지 자동 슬라이드
	var slideIndex = 0;
	showSlides();
	
	function showSlides() {
	    var i;
	    var slides = document.getElementsByClassName("myslider");
	   
	    for (i = 0; i < slides.length; i++) {
	        slides[i].style.display = "none";
	    }
	    slideIndex++;
	    if (slideIndex > slides.length) {
	        slideIndex = 1
	    }
	    slides[slideIndex - 1].style.display = "block";
	
	    setTimeout(showSlides, 3000); // 2초마다 이미지가 체인지됩니다
	}

	
</script>
</body>
</html>