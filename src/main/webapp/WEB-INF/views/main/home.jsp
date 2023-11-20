<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Home</title>
	<style>
	
	.slideshow{
		display: flex;
	    justify-content: center;
	    position: relative;
	    margin: auto;
	}

	/* 초기화 */
	.slider{
	  margin: 0;
	  padding: 0;
	}
	
	.myslider img{
    width: 100%;
    height: 100%;
    overflow: hidden;
	}
	
	.myslider{
		border-radius:3%;
	    width: 100%;
	    height: 350px;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	
	/* 첫 번째 슬라이드 가운데에 정렬*/
	.slider li:first-child{
	  margin-left: 100px;
	}
	
	/* 슬라이드 옆으로 정렬 */
	.slider li:not(:last-child){
	  float: left;
	  margin-right: 100px;
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
	
	.fade {
	    animation-name: fade;
	    animation-duration: 1.5s;
	}
	@keyframes fade {
	    from {
	        opacity: .4
	    }
	    to {
	        opacity: 1
	    }
	}
	
	.btn {
    position: absolute;
    top: 50%;
    width: 100%;
    display: flex;
    justify-content: space-between;
    transform: translateY(-50%);
  }

  #prev,
  #next {
    background-color: transparent;
    border: none;
    font-size: 20px;
    cursor: pointer;
  }
  #prev{ margin-left: 30px;}
  #next{ margin-right: 30px;}


	</style>
</head>
<body>
	<div class="slideshow">
		<div class="slider">
			<div class="myslider fade">
				<a href="<c:url value='/'/>">
					<img class="item" src="<c:url value='/resources/main/main1.png'/>" alt="Image1">
				</a>
			</div>
			<div class="myslider fade">
				<a href="<c:url value='/match/search/solo'/>">
					<img class="item" src="<c:url value='/resources/main/main2.png'/>" alt="Image2">
				</a>
			</div>
			<div class="myslider fade">
				<a href="<c:url value='/application/manager'/>">
					<img class="item" src="<c:url value='/resources/main/main3.png'/>" alt="Image3">
				</a>
			</div>
			<div class="myslider fade">
				<a href="<c:url value='/application/manager'/>">
					<img class="item" src="<c:url value='/resources/main/main4.png'/>" alt="Image4">
				</a>
			</div>
			<div class="myslider fade">
				<a href="<c:url value='/application/manager'/>">
					<img class="item" src="<c:url value='/resources/main/main5.png'/>" alt="Image5">
				</a>
			</div>
		</div>
      <!-- 화살표 -->
		<div class="btn">
	       <button class="prev">＜</button>
    		<button class="next">＞</button>
	    </div>
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

	//슬라이드 버튼
	let pages = 0;//현재 인덱스 번호
	let positionValue = 0;//images 위치값
	const IMAGE_WIDTH = 250;//한번 이동 시 IMAGE_WIDTH만큼 이동한다.
	
	const prevBtn = document.querySelector(".prev")
	const nextBtn = document.querySelector(".next")
	const images = document.querySelector(".images")

	function next() {
	  if (pages< 4) {
		prevBtn.removeAttribute('disabled')//뒤로 이동해 더이상 disabled가 아니여서 속성을 삭제한다.
	    positionValue -= IMAGE_WIDTH;//IMAGE_WIDTH의 증감을 positionValue에 저장한다.
	    images.style.transform = `translateX(${positionValue}px)`;
			//x축으로 positionValue만큼의 px을 이동한다.
	    pages += 1; //다음 페이지로 이동해서 pages를 1증가 시킨다.
	  }
	  if (pages === 4) { //
	    nextBtn.setAttribute('disabled', 'true')//마지막 장일 때 next버튼이 disabled된다.
	  }
	}
	
	function prev() {
	  if (pages > 0) {
	    nextBtn.removeAttribute('disabled')
	    positionValue += IMAGE_WIDTH;
	    images.style.transform = `translateX(${positionValue}px)`;
	    pages -= 1; //이전 페이지로 이동해서 pages를 1감소 시킨다.
	  }
	  if (pages === 0) {
		 prevBtn.setAttribute('disabled', 'true')//마지막 장일 때 back버튼이 disabled된다.
	  }
	}
	
	function init() {  //초기 화면 상태
	  backBtn.setAttribute('disabled', 'true'); //속성이 disabled가 된다.
	  prevBtn.addEventListener("click", prev); //클릭시 다음으로 이동한다.
	  nextBtn.addEventListener("click", next);//클릭시 이전으로 이동한다.
	}
	init();
	
</script>
</body>
</html>
