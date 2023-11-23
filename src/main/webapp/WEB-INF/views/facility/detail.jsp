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
	padding: 30px; width: 42%; height: auto;}

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
	.text{ border-left: 6px solid #c2f296; padding-left: 10px; height: 25px;}
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
	
	/* 슬라이드쇼 */
	.slider__wrap {
        width: 100%;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    /* 이미지 보이는 부분 */
    .slider__img {
        position: relative;
        width: 600px;
        height: 600px;
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
		height: 800px;
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
    width: 68%;
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
	
</style>
<body>
	<div class="stadium-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 38%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		[${facility.fa_name}] 경기장 목록</p>
	</div>
	<!-- 	시설 사진 슬라이드쇼 -->
	<div class="sliderType01">
		<div class="slider__wrap">
			<div class="slider__img">
				<div class="slider__inner">
					<c:forEach items="${files}" var="file">
						<div class="slider">
								<img class="item" src="<c:url value='/facilityimg${file.fp_name }'/>" alt="Image">
						</div>
					</c:forEach>
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
			<div class="match-info-box1 match-info justify-content: space-between">
				<div>
					<label class="text">주소 </label>
					<div>
						<p>${facility.fa_add}${facility.fa_add_detail}</p>
					</div>
				</div>
				<div>
					<label class="text">연락처</label>
					<div>
						<p>${facility.fa_phone}</p>
					</div>
				</div>	
			</div>
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
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_toilet.svg"
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
								src="https://d31wz4d3hgve8q.cloudfront.net/static/img/ic_info_stadium.svg"
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
						href="<c:url value='/facility/list'/>"
						>시설 목록으로 이동</a>		
		</div>
	</div>		
<script type="text/javascript">
	//이미지 슬라이드
	const sliderWrap = document.querySelector(".slider__wrap");
	const sliderImg = document.querySelector(".slider__img");       // 보여지는 영역
	const sliderInner = document.querySelector(".slider__inner");   // 움직이는 영역
	const slider = document.querySelectorAll(".slider"); 
	const sliderBtn = document.querySelector(".slider__btn");    //버튼
	const sliderBtnPrev = document.querySelector(".prev");       //왼쪽버튼
	const sliderBtnNext = document.querySelector(".next");       //오른쪽버튼
	
	let currentIndex = 0;                       //현재 이미지
	let sliderCount = slider.length;            //이미지 갯수
	let sliderWidth = sliderImg.offsetWidth;    //이미지 가로값
	
		// 이미지 움직이는 영역
	function gotoSlider(num){
	    sliderInner.style.transition = "all 400ms";
	    sliderInner.style.transform = "translateX("+ -sliderWidth * num +"px)";
	    currentIndex = num;
	}
	
	//슬라이드 버튼
	// 왼쪽 버튼을 클릭했을 때
	sliderBtnPrev.addEventListener("click", () => {
	    let prevIndex = (currentIndex + (sliderCount -1)) % sliderCount
	    // 4, 1, 2, 3, 4, 1, 2, ...
	    gotoSlider(prevIndex);
	});
	
	// 오른쪽 버튼을 클릭했을 때
	sliderBtnNext.addEventListener("click", () => {
	    let nextIndex = (currentIndex + 1) % sliderCount
	    // 1, 2, 3, 4, 0, 1, 2, ...
	    gotoSlider(nextIndex);
	});
</script>
</body>
</html>