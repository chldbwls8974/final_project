<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<title>포인트 환급 관리</title>
</head>
<style>
	.error {
		color: #f00;
		display: block;
	}
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
	<div class="refund-navigation" style="margin-top: 50px; text-align: center;">
		<p style="font-size: 35px; width: 27%; font-weight: bolder; margin: 30px auto; padding: 20px 0 10px 0; border-bottom: 10px solid #c2f296;">
		포인트 환급 관리</p>
	</div>>

	<form action="<c:url value='/admin/refund'/>" method="post">
		<div class="refund-navigation" style="margin: 30px 0 30px 0; text-align: center;">
		    <select class="search-type-1">
		      <option value="all">상태</option>
		      <option value="second">미완료</option>
		      <option value="third">완료</option>
		    </select>
		    <select class="search-type-2">
		      <option value="all">전체</option>
		      <option value="second">아이디</option>
		      <option value="third">닉네임</option>
		      <option value="fourth">이름</option>
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
						<th>아이디</th>
						<th>닉네임</th>
						<th>이름</th>
						<th>전화번호</th>
						<th>보유 포인트</th>
						<th>환급 신청 금액</th>
						<th>상태</th>
						<th>은행명</th>
						<th>계좌번호</th>
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
		searchType2 : "all"
	}   
	
	$(document).ready(function() {
   	 	getPointHistoryListBySearch(data);
   	 	console.log(data);
	})
	
	//이벤트 발생되면 리스트를 받아와서 생성
	$(document).on('click','.btn-search',function(){
		let data = createSearchData()
		getPointHistoryListBySearch(data);
	})
	//이벤트 발생되면 리스트를 받아와서 생성
	$(document).on('change','.search-type-1',function(){
		let data = createSearchData()
		getPointHistoryListBySearch(data);
	})
	//Data에 객체들의 정보를 저장해서 반환하는 메서드
	function createSearchData() {
	    let searchType1 = $('.search-type-1').val();
	    let searchType2 = $('.search-type-2').val();
	    let searchContents = $('.input-search').val();
	    let currentPage = $('.active').data('page');
	    let data = {
	        cri: { page: currentPage, perPageNum: cri.perPageNum, s: searchContents },
	        searchType1: searchType1,
	        searchType2: searchType2
	    };
	    return data;
	}
	//입력되어있는 필터값을 data에 저장해서 리스트를 생성하는 함수
	function updatePage(page) {
		console.log(page);
	    data.cri.page = page;
	    data.cri.s = $('.input-search').val();
	    data.searchType1 = $('.search-type-1').val();
	    data.searchType2 = $('.search-type-2').val();
	    getPointHistoryListBySearch(data);
	}
	
	function getPointHistoryListBySearch(data){
		
		ajaxJsonToJson(false, 'post', '/admin/refund/search', data ,(data)=>{
			//테이블 생성
			createPointHistoryListBySearch(data.refundList, '.list-tbody');
			//페이지네이션 생성
			createPagination(data.pm, '.pagination');
		});
	}
	
	function getPointHistoryListBySearch(data){
		
		ajaxJsonToJson(false, 'post', '/admin/refund/search', data ,(data)=>{
			//테이블 생성
			console.log(data.refundList);
			createPointHistoryListBySearch(data.refundList, '.list-tbody');
			//페이지네이션 생성
			createPagination(data.pm, '.pagination');
		});
	}
	
	//리스트를 받아서 테이블 생성하는 함수
	function createPointHistoryListBySearch(refundList, target){
		let str ='';
		for(a of refundList){
			let btnStr = '';
			let state = '';
			let price = -parseInt(a.ph_price);
			if(a.ph_source == '4'){
				state = '처리중'
				btnStr = `
					<div class="btn-group">
						<button class="btn btn-outline-success btn-approval"  onclick="approvalRefund(\${a.ph_num})" >승인</button>
					</div>
					`;
			}else{
				state = '환급 완료'
				btnStr = `
					<div class="btn-group">
						<label class="btn btn-outline-dark disabled" >완료</label>
					</div>
					`
			} 
			str += `
				<tr>
					<td>\${a.me_id}</td>
					<td>\${a.me_nickname}</td>
					<td>\${a.me_name}</td>
					<td>\${a.me_phone}</td>
					<td>\${a.me_point}</td>
					<td>\${price}</td>
					<td>\${state}</td>
					<td>\${a.ac_ba_name}</td>
					<td>\${a.ac_num}</td>
					<td>\${btnStr}</td>
				</tr>
			`;
		}
		$(target).html(str);
	}
	
	//페이지네이션
	function createPagination(pm, target){
		let str = '';
		if(pm.prev){
			str += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="updatePage(\${pm.startPage - 1});">이전</a></li>`;
		}
		//현재페이지 = active 클래스 추가
		for(i=pm.startPage; i<=pm.endPage; i++){
			let active = pm.cri.page == i ? 'active' : '';
			str += `
			<li class="page-item \${active}" data-page="\${i}">
				<a class="page-link" href="javascript:void(0);" onclick="updatePage(\${i});">\${i}</a>
			</li>`;
		}
		if(pm.next){
			str += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="updatePage(\${pm.endPage + 1});">다음</a></li>`;
		}
		$(target).html(str);
	}
	
	
	//환급을 승인하는 함수
	function approvalRefund(ph_num){
		let data = { 
				ph_num : ph_num
		}
		 
		ajaxJsonToJson(false,'post','/admin/refund/approval', data ,(data)=>{
			if(data.res){
				alert('환급완료 처리했습니다.')
			}else{
				alert('환급 처리에 실패했습니다.')
			}
		}); 
		let dbData = createSearchData()
		getPointHistoryListBySearch(dbData);
	}  
	
	//인풋태그에서 엔터시 폼 제출되는것 막기
	document.getElementById("input-search").addEventListener("keypress", function(event) {
	    if (event.key === "Enter") {
	        event.preventDefault(); // 엔터 키 동작을 막음
	    }
	});
</script>
</html>