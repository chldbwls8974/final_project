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
				<img class="item" src="<c:url value='/resources/main/main1.png'/>" alt="Image1">
			</div>
			<div class="myslider fade">
				<img class="item" src="<c:url value='/resources/main/main2.png'/>" alt="Image2">
			</div>
			<div class="myslider fade">
				<img class="item" src="<c:url value='/resources/main/main3.png'/>" alt="Image3">
			</div>
		</div>
      <!-- 화살표 -->
		<div class="btn">
	       <button type="button" id="prev"><</button>
    		<button type="button" id="next">></button>
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

	
</script>
</body>
</html>
