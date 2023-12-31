<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<title>커뮤니티 신고 관리</title>
</head>
<style type="text/css">
	.btn-info{
		color : outline-info;
		background-color : white;
		border : 1px solid outline-info;
	}
	.btn-info:hover{
		background-color : outline-info;
		color : white;
	}
	tr{
		text-align : center
	}
	.content-row {
	color : #4A90E2;
    display: none;
	}
	
	.search-type-1 {
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
	.search-type-2 {
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
	.input-search {
		width: 500px;
		padding: .8em .5em;
		border-radius: 5px;
		border: 1px solid #999;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
	.btn-search{
		width: 80px;
		padding: .8em .5em;
		border-radius: 5px;
		border: 1px solid #999;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
    
	.main{
		padding: 40px; height: auto;
		background-color: #f2f2f2; border-radius: 20px;
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
	
</style>
<body>
	<div class="board-report-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 31%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 8px solid #c2f296;">
		커뮤니티 신고 관리</p>
	</div>
	
	<div style="text-align: center; margin-right: 10px;">
		<div class="btn-group btn-group">
		  <button type="button"
				    class="btn-info"
				    style="
						border-radius: 10px; width: 130px; height: 40px; border: none;
						background-color: #c2f296; color: black; margin: 10px 10px 10px 0;"
						onclick="location.href='<c:url value='/admin/boardReport'/>'"
				>커뮤니티 신고</button>
		 <button type="button"
				    class="btn-info"
				    style="
						border-radius: 10px; width: 130px; height: 40px; border: none;
						background-color: #c2f296; color: black; margin: 10px 0 10px 0;"
						onclick="location.href='<c:url value='/admin/matchReport'/>'"
				>매치 신고</button>
		</div>
	</div>
	
	<form>
		<div class="board-report-navigation" style="margin: 30px 0 30px 0; text-align: center;">
			<select class="search-type-1">
		      <option value="all">상태</option>
		      <option value="second">제재</option>
		      <option value="third">확인</option>
		      <option value="fourth">미확인</option>
		    </select>
		    <select class="search-type-2">
		      <option value="all">전체</option>
		      <option value="second">신고자</option>
		      <option value="third">대상자</option>
		      <option value="fourth">카테고리</option>
		      <option value="fifth">신고일</option>
		    </select>
	   		<input type="text" class="input-search" name="s" id="input-search" placeholder="검색어를 입력하세요." value="${pm.cri.s}">
	   		<button type="button" class="btn-search">찾기</button>
		</div>
	</form>
	<div class="main">
		<div>
			<table class="table table-hover mt-4">
				<thead>
					<tr>
						<th>번호</th>
						<th>신고일</th>
						<th>카테고리</th>
						<th>게시글 번호</th>
						<th>내용</th>
						<th>신고자 ID</th>
						<th>대상자 ID</th>
						<th>상태</th>
						<th></th>
					</tr>
				</thead>
				<tbody class="list-tbody">
				
				</tbody>
			</table>
		</div>
		<!-- 페이지네이션 -->
		<ul class="pagination justify-content-center mt-3 pagination">
		
		</ul>
	</div>
</body>

<script type="text/javascript">
	let cri = {
			page : 1,
			perPageNum : 5
	}
	
	let data = {
		cri : {page : cri.page, perPageNum : cri.perPageNum, s : ''},
		searchType1 : "all",
		searchType2 : "all",
		reportType : "커뮤니티"
	}   
	
	$(document).ready(function() {
		 	getReportListBySearch(data);
	})
	
	//버튼을 누를때 페이지네이션의 페이지값을 같이 보내야 함?
	//처리상태를 변경하는 함수 (0 : 제재, 1 : 확인)
	function changeState(rp_num, num){
		let data = { 
				rp_num : rp_num,
				rp_state : num
		}
		ajaxJsonToJson(false,'post','/admin/report/handle', data ,(data)=>{
		}); 
		let dbData = createSearchData()
		getReportListBySearch(dbData); 
	} 
	
	//이벤트 발생되면 리스트를 받아와서 생성
	$(document).on('change','.search-type-1',function(){
		let data = createSearchData()
		getReportListBySearch(data);
	})
	
	//검색버튼 이벤트발생되면 리스트를 받아와서 생성
	$(document).on('click','.btn-search',function(){
		let data = createSearchData()
		getReportListBySearch(data);
	})
			
	//이벤트 발생 시 데이터를 담아서 보내기 위한 함수
	function createSearchData() {
	    let searchType1 = $('.search-type-1').val();
	    let searchType2 = $('.search-type-2').val();
	    let searchContents = $('.input-search').val();
	    let currentPage = $('.active').data('page');
	    console.log(currentPage);
	    let data = {
	        cri: { page: currentPage, perPageNum: cri.perPageNum, s: searchContents },
	        searchType1: searchType1,
	        searchType2: searchType2,
	        reportType : "커뮤니티"
	    };
	    return data;
	}
	
	//입력되어있는 필터값을 data에 저장해서 리스트를 생성하는 함수
	function updatePage(page) {
	    data.cri.page = page;
	    data.cri.s = $('.input-search').val();
	    data.searchType1 = $('.search-type-1').val();
	    data.searchType2 = $('.search-type-2').val();
	    getReportListBySearch(data);
	}
	//리스트를 가져오는 함수
	function getReportListBySearch(data){
		ajaxJsonToJson(false, 'post', '/admin/report/search', data ,(data)=>{
			//테이블 생성
			createReportListBySearch(data.reportList, '.list-tbody');
			//페이지네이션 생성
			createPagination(data.pm, '.pagination');
		});
	}
	

	//리스트를 받아서 테이블 생성하는 함수
	function createReportListBySearch(reportList, target){
		let str ='';
		
		for(a of reportList){
			let btnStr = '';
			let toggleBtnStr = '';
			let content = a.rp_content == null ? '없음' : a.rp_content;
			if(a.rp_state == '미확인'){
				btnStr = `
					<div class="btn-group">
						<button class="btn btn-outline-success btn-state-change" onclick="changeState(\${a.rp_num}, 0)" >제재</button>
					</div>
					<div class="btn-group">
						<button class="btn btn-outline-success btn-state-change" onclick="changeState(\${a.rp_num}, 1)" >확인</button>
					</div>
					`;
			}else{
				btnStr = `
					<div class="btn-group">
						<label class="btn btn-outline-dark disabled">처리 완료</label>
					</div>
					`
			}
			toggleBtnStr = `
				<div class="btn-group">
				<button class="btn btn-outline-success btn-content-toggle" >상세보기</button>
				</div>
			`;
			str += `
				<tr>
					<td>\${a.rp_num}</td>
					<td>\${a.rp_date}</td>
					<td>\${a.rc_detail}</td>
					<td><a href="<c:url value='/board/detail?bo_num=\${a.rp_bo_num}'/>">\${a.rp_bo_num}</a></td>
					<td>\${toggleBtnStr}</td>
					<td>\${a.me_id}</td>
					<td>\${a.me_id2}</td>
					<td>\${a.rp_state}</td>
					<td>\${btnStr}</td>
				</tr>
				<tr class="content-row">
               		<td colspan="9">내용 : \${content}</td>
            	</tr>
			`;
		}
		$(target).html(str);
	}
	
	
	

	//페이지네이션
	//좌,우 버튼 또는 숫자를 클릭했을 때 updataPage함수 실행됨.
	//li태그에 현재 페이지의 숫자 data-page로 저장
	function createPagination(pm, target){
		let str = '';
		if(pm.prev){
			str += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="updatePage(\${pm.startPage - 1});">&lt;</a></li>`;
		}
		//현재페이지 = active 클래스 추가
		for(i=pm.startPage; i<=pm.endPage; i++){
			let active = pm.cri.page == i ? 'active' : '';
			str += `
			<li class="page-item \${active}" data-page="\${i}" >
				<a class="page-link" href="javascript:void(0);" onclick="updatePage(\${i});">\${i}</a>
			</li>`;
		}
		if(pm.next){
			str += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="updatePage(\${pm.endPage + 1});">&gt;</a></li>`;
		}
		$(target).html(str);
	}
	
	 
	
    // 버튼 클릭 토글
	$(document).ready(function() {
	    $(document).on("click", ".btn-content-toggle", function() {
	        $(this).closest("tr").next(".content-row").toggle();
	    });
	});
	//인풋태그에서 엔터시 폼 제출되는것 막기
	document.getElementById("input-search").addEventListener("keypress", function(event) {
	    if (event.key === "Enter") {
	        event.preventDefault(); // 엔터 키 동작을 막음
	    }
	});
</script>
</html>