<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Home</title>
	<style>
	
	.navbar-container,
	.container-footer{margin: 0 !important;}
	.navbar-brand, footer{ display: none !important;}
	.navbar1, .navbar2{
		display: inline-block; margin-bottom: 10px; opacity: 1;
		background-color: transparent !important;
	}
	.navbar1-nav-link{margin-top: 10px;}
	.navbar2-nav-link{position: absolute;  right: 20px !important; top: 10px; }
	.nav-link{ color: white;}
	.dropdown-menu .nav-link{ color: black;}
	.dropdown-menu .nav-link:hover{ color: #999999;}
	.dropdown-menu show{ background-color: #e5e5e5;}
	
	body{
		background-image:url("https://cdn.pixabay.com/photo/2014/10/14/20/24/ball-488701_1280.jpg");
		background-repeat: repeat-y;
		background-size: cover;
		background-repeat: no-repeat;
		position: relative;
	}
	body::before{
 		content: ""; /* 가상 요소 생성 */ 
	    top: 0;
	    right: 0;
	    bottom: 0;
	    left: 0;
	    background: rgba(0, 0, 0, 0.3);
	    position: fixed;
/* 	    content: none; /* 가상 요소 내용 없음으로 설정 */
    	pointer-events: none;
	}
	.slider__wrap {
        width: 100%;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 50px;
    }
    /* 이미지 보이는 부분 */
    .slider__img {
        position: relative;
        width: 800px;
        height: 800px;
        overflow: hidden;
    }
     /* 이미지 감싸고 있는 부모 : 움직이는 부분 */
    .slider__inner {
        display: flex;
        flex-wrap: wrap;
        /* 총 이미지 5개 */
        width: 3600px;
        height: 400px;
        opacity: 1;
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
    width: 62%;
    opacity: 0.5;
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
    background-color: #f3f6f4;
    color: black;
    border: none;
    font-size: 20px;
    cursor: pointer;
  }
  .prev{ margin-left: 30px;}
  .next{ margin-right: 30px;}

	</style>
</head>
<body>
	<div class="sliderType01">
		<div class="slider__wrap">
			<div class="slider__img">
				<div class="slider__inner">
					<div class="slider">
						<a href="<c:url value='/'/>">
							<img class="item" src="<c:url value='/resources/main/main10.png'/>" alt="Image1">
						</a>
					</div>
					<div class="slider">
						<a href="<c:url value='/member/signup'/>">
							<img class="item" src="<c:url value='/resources/main/main6.png'/>" alt="Image3">
						</a>
					</div>
					<div class="slider">
						<a href="<c:url value='/match/search/solo'/>">
							<img class="item" src="<c:url value='/resources/main/main7.png'/>" alt="Image4">
						</a>
					</div>
					<div class="slider">
						<a href="<c:url value='/match/search/club'/>">
							<img class="item" src="<c:url value='/resources/main/main9.png'/>" alt="Image2">
						</a>
					</div>
<!-- 					<div class="slider"> -->
<%-- 						<a href="<c:url value='/match/search/club'/>"> --%>
<%-- 							<img class="item" src="<c:url value='/resources/main/main8.png'/>" alt="Image5"> --%>
<!-- 						</a> -->
<!-- 					</div> -->
				</div>
			</div>
	    	<!-- 화살표 -->
			<div class="slider__btn">
		       <button class="prev">＜</button>
	    		<button class="next">＞</button>
		    </div>
		</div>
	</div>
<script>

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
	let sliderClone = sliderInner.firstElementChild.cloneNode(true);    // 첫번째 이미지 복사
	sliderInner.appendChild(sliderClone);                               // 첫번째 이미지를 마지막에 넣어줌
	
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
	
	
	//자동 슬라이더
	function sliderEffect() {
	    currentIndex++;
	    sliderInner.style.transition = "all 1.5s";
	
	    sliderInner.style.transform = "translateX(-"+ sliderWidth * currentIndex +"px)";
	
// 	    sliderInner.style.transform = "translateX(-600px)";      600*1
// 	    sliderInner.style.transform = "translateX(-1200px)";     600*2
// 	    sliderInner.style.transform = "translateX(-1800px)";     600*3
// 	    sliderInner.style.transform = "translateX(-2400px)";     600*4
// 	    sliderInner.style.transform = "translateX(-3000px)";     600*5
// 	    sliderInner.style.transform = "translateX(-3600px)";     600*1
	
	    // 마지막 사진이면 0번째로 이동
	    if(currentIndex == sliderCount){
	        setTimeout(()=>{
	            sliderInner.style.transition = "0s";
	            sliderInner.style.transform = "translateX(0px)";
	        }, 1000);
	        
	        currentIndex = 0;
	    }
	
	
	}
	setInterval(sliderEffect, 4000); //2초마다 넘김

</script>
</body>
</html>
