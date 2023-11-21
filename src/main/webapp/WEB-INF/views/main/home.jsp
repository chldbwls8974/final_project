<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Home</title>
	<style>
	
	.navbar-container,
	.navbar1, .navbar2,
	.jumbotron,
	.container-footer{ background-color: transparent !important;}
	.navbar-brand{ display: none !important;}
	.navbar1, .navbar2{display: inline-block; margin-bottom: 10px;}
	.nav-link{ color: white;}
	.dropdown-menu show{ background-color: #e5e5e5;}
	
	body{
		background-image:url("https://cdn.pixabay.com/photo/2015/10/21/23/32/football-1000569_1280.jpg");
		background-repeat: repeat-y;
		background-size: cover;
		position: relative;
	}
	body::before{
		content: ""; /* 가상 요소 생성 */
	    position: absolute;
	    top: 0;
	    right: 0;
	    bottom: 0;
	    left: 0;
	    background: rgba(0, 0, 0, 0.3);
	}
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
        width: 800px;
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

	.slider__btn {
    position: absolute;
    top: 40%;
    width: 68%;
    display: flex;
    justify-content: space-between;
    transform: translateY(-50%);
  }

  .prev,
  .next {
    background-color: transparent;
    border: none;
    font-size: 20px;
    cursor: pointer;
    color: white;
    font-size: 30px;
    font-weight: bolder;
  }
  .prev:hover,
  .next:hover{
  	
  }

	</style>
</head>
<body>
	<div class="sliderType01">
		<div class="slider__wrap">
			<div class="slider__img">
				<div class="slider__inner">
					<div class="slider">
						<a href="<c:url value='/'/>">
							<img class="item" src="<c:url value='/resources/main/main6.png'/>" alt="Image1">
						</a>
					</div>
					<div class="slider">
						<a href="<c:url value='/match/search/solo'/>">
							<img class="item" src="<c:url value='/resources/main/main7.png'/>" alt="Image2">
						</a>
					</div>
					<div class="slider">
						<a href="<c:url value='/application/manager'/>">
							<img class="item" src="<c:url value='/resources/main/main8.png'/>" alt="Image3">
						</a>
					</div>
					<div class="slider">
						<a href="<c:url value='/match/search/club'/>">
							<img class="item" src="<c:url value='/resources/main/main4.png'/>" alt="Image4">
						</a>
					</div>
					<div class="slider">
						<a href="<c:url value='/'/>">
							<img class="item" src="<c:url value='/resources/main/main5.png'/>" alt="Image5">
						</a>
					</div>
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
	
	//이미지 자동 슬라이드
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
