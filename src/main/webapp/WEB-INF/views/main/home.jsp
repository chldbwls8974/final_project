<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Home</title>
	<style>

	/* 초기화 */
	*{
	  margin: 0;
	  padding: 0;
	  box-sizing: border-box;
	}
	
	.slideshow{
		width: 100%;
		height: 300px;
		position: relative;
		margin: 50px auto;
		overflow: hidden;
	}
	.slider li{ list-style-type: none; float: left;}
	.slider{
	  position: absolute;
	  left: 0;
	  top: 0;
	  width: 100%; /* 슬라이드할 사진과 마진 총 넓이 */
	  transition: left 0.5s ease-out; 
	  /*ease-out: 느렸다가 빨라짐*/
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


	</style>
</head>
<body>
	<div class="slideshow">
		<ul class="slider">
			<li>
				<img class="item" src="<c:url value='/resources/main/main1.png'/>" alt="Image1">
			</li>
			<li>
				<img class="item" src="<c:url value='/resources/main/main2.png'/>" alt="Image2">
			</li>
			<li>
				<img class="item" src="<c:url value='/resources/main/main3.png'/>" alt="Image3">
			</li>
		</ul>
      <!-- 화살표 -->
		<div class="btn">
	       <button type="button" id="prev"><</button>
    		<button type="button" id="next">></button>
	    </div>
	</div>
<script>
	
$(function(){
	  var $slider = $('.slider'),
	      $firstSlide = $slider.find('li').first() // 첫번째 슬라이드
	      .stop(true).animate({'opacity':1},200); // 첫번째 슬라이드만 보이게 하기

	  function PrevSlide(){ // 이전버튼 함수
	    stopSlide();startSlide(); //타이머 초기화
	    var $lastSlide = $slider.find('li').last() //마지막 슬라이드
	    .prependTo($slider); //마지막 슬라이드를 맨 앞으로 보내기  
	    $secondSlide = $slider.find('li').eq(1)//두 번째 슬라이드 구하기
	    .stop(true).animate({'opacity':0},400); //밀려난 두 번째 슬라이드는 fadeOut 시키고
	    $firstSlide = $slider.find('li').first() //맨 처음 슬라이드 다시 구하기
	    .stop(true).animate({'opacity':1},400);//새로 들어온 첫 번째 슬라이드는 fadeIn 시키기
	  }
	  
	  function NextSlide(){ // 다음 버튼 함수
	    stopSlide();startSlide(); //타이머 초기화
	    $firstSlide = $slider.find('li').first() // 첫 번째 슬라이드
	    .appendTo($slider); // 맨 마지막으로 보내기
	    var $lastSlide = $slider.find('li').last() // 맨 마지막으로 보낸 슬라이드
	    .stop(true).animate({'opacity':0},400); // fadeOut시키기
	    $firstSlide = $slider.find('li').first()// 맨 처음 슬라이드
	    .stop(true).animate({'opacity':1},400);// fadeIn 시키기
	  }
	  
	  $('#next').on('click', function(){ //다음버튼 클릭
	    NextSlide();
	  });
	  $('#prev').on('click', function(){ //이전 버튼 클릭
	    PrevSlide();
	  });

	  startSlide(); // 자동 슬라이드 시작
	  
	  var theInterval;

	  function startSlide() {
	    theInterval = setInterval(NextSlide, 5000); //자동 슬라이드 설정
	  }

	  function stopSlide() { //자동 멈추기
	    clearInterval(theInterval);
	  }
	  
	  $('.slider').hover(function(){ //마우스 오버시 슬라이드 멈춤
	    stopSlide();
	  }, function (){
	    startSlide();
	  });
	});


	
</script>
</body>
</html>
