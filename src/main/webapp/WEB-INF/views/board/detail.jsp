<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지게시글 상세보기</title>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<style>
	h1{
		text-align : center;
	}
	.form-control{
		margin-bottom : 10px;
	}
	.btn{
		margin-bottom : 10px;
	}
	.comment-box{
		display : flex;

	}
	/* 프로필 사진 */
	.profile-image {
	    width: 60px; 
	    height: 60px; 
	    border-radius: 50%; /* 둥글두그륵 만들기 */
	    object-fit: cover; /* 이미지가 찌그러지지 않도록 설정하는 것 */
	    float:left;
	}
	/* 댓글 내용 */
	.comment-list{
		list-style : none;
		padding : 10px;
		width : 100%;
	}
	/* 수정 삭제 버튼 */
	.comment-item{
		float : right;
		position : relative;
	}
	/* 날짜 */
	.comment-date{
		position : absolute;
		transform: translateX(580px);
		transform: translateY(25px);
		display : block;
		margin-left : 80px;
	}
	.comment-1{
		position : relative;
	}
	.comment-contents{
		margin-left : 20px;
	}
	
</style>    
</head>
</head>
<body>
	<br>
	<h1>&#x2709 공지글 보는 곳 &#x2709</h1>
	<form action="<c:url value='/board/detail'/>" method="post">
		<div class="form-group">
			<label>제목</label>
			<input type="text" class="form-control" name="bo_title" value="${board.bo_title}" readonly>
		</div>
		<div class="form-group">
			<label>작성자</label>
			<input type="text" class="form-control" name="bo_me_id" value="${user.me_id}" readonly>
		</div>
		<div class="input-group mb-3">
		    <div class="input-group">
		    	<div class="form-control"
					 style="height : 600px; overflow-y: auto; text-align: center;" >${board.bo_contents}</div>
		    </div>
		</div>
		<div class="form-group">
			<c:choose>
				<c:when test="${fileList.size() != 0 }">
					<label>첨부파일</label><br>
						<c:forEach items="${fileList}" var="file">
							<a  href="<c:url value='/download${file.fi_name}'/>" 
								download="${file.fi_ori_name}">${file.fi_ori_name}</a><br>
						</c:forEach>
				</c:when>
				<c:otherwise>
					<label>첨부파일 없음</label>
					<hr>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="comment-contaier mt-5">
		<!-- 프로필사진 -->
			<%-- <c:forEach items="${list}" var="ma">
				<c:choose>
					<c:when test="${empty ma.me_profile}">
				 		<img src="<c:url value='/resources/images/sample.jpg'/>" class="rounded-circle profile-image" alt="기본프로필 사진">
				 	</c:when>
				 	<c:otherwise>
				 		<img src="${ma.me_profile}" class="rounded-circle profile-image" alt="프로필 사진">
				 	</c:otherwise>
				</c:choose>
			</c:forEach> --%>
		<!-- 댓글 입력창  -->
		<label>댓글</label><br>
		<div class="input-group-append mb-3">
			<textarea class="form-control" placeholder="댓글을 입력해주세요." id="inputComment"></textarea>
		    <button type="button"  class="btn btn-outline-success" id="btnCommentInsert">등록</button>
		 </div>
		<!-- 댓글 목록창 -->
		<div class="box-comment">
			<div class="comment-box">
				<div class="comment-list">
					<div class="comment-1">
						<span class="comment-contents">${comment.co_comments}</span>
						<span class="comment-writer">${comment.co_me_num}</span>
						<span class="comment-date">${comment.co_date}</span>	
					</div>
					<div class="comment-item">
						<button type="button" class="btn btn-outline-info btn-sm btn-update" data-num="${comment.co_num}">수정</button>
						<button type="button" class="btn btn-outline-info btn-sm btn-del" data-num="${comment.co_num}">삭제</button>
						<button type="button" class="btn btn-outline-primary btn-sm btn-reply" value="${comment.co_num}">답글</button>						
					</div>
				</div>
			</div>
						
							<%-- <div class="box-comment" style="margin-left:30px;">
								<div class="comment-box">
									<div class="comment-list">	
										<img src="<c:url value='/resources/images/sample.jpg'/>" class="rounded-circle profile-image" alt="기본프로필 사진">
										<div class="comment-1">
											<span class="comment-contents">${comment.co_comments}</span>
											<span class="comment-writer">[${comment.co_me_num}]</span>
											<span class="comment-date">${comment.co_date}</span>
										</div>	
										<div class="comment-item">
											<button type="button" class="btn btn-outline-info btn-sm btn-update" data-num="${comment.co_num}">수정</button>
											<button type="button" class="btn btn-outline-info btn-sm btn-del" data-num="${comment.co_num}">삭제</button>
										</div>
									</div>
								</div>
							</div> --%>

		<!-- 댓글 페이지네이션 -->
			<div class="pagination justify-content-center">
				<a class="page-link" href="#"> 이전</a>
				<a class="page-link" href="#"> 1</a>
				<a class="page-link" href="#"> 다음</a>
			</div>
		</div>
		<hr>
		<button type="button"
				class="btn btn-outline-info col-12 btn-return" 
				onclick="location.href='<c:url value='/board/notice'/>'">돌아가기
		</button>
		<c:if test="${user != null && user.me_authority == 'ADMIN'}">
			<button type="button"
					class="btn btn-outline-warning col-12 btn-update"
					onclick="location.href='<c:url value='/board/update?bo_num=${board.bo_num}'/>'">수정하기
			</button><br>
		</c:if>
		<c:if test="${user != null && user.me_authority == 'ADMIN'}">
			<button type="button"
					class="btn btn-outline-danger col-12 btn-delete"
					onclick="location.href='<c:url value='/board/delete?bo_num=${board.bo_num}'/>'">삭제하기
			</button><br>
		</c:if>
	</form>

<script type="text/javascript">
     $('#summernote').summernote({
       placeholder: '내용을 입력하세요.',
       tabsize: 2,
       height: 400
     });
</script>

<!-- 댓글 기능 자바스크립트 -->
<script type="text/javascript">
//등록버튼을 클릭하면 함수가 실행됨
	$('#btnCommentInsert').click(function(){
		let co_contents = $('#inputComment').val();
		let co_me_num = '${user.me_num}';
		let co_bo_num = '${board.bo_num}';
		
		if(co_me_num == 0){
			if(confirm('로그인이 필요한 서비스입니다. 로그인하시겠습니까?')){
				location.href = '<c:url value="/member/login"/>'
			}
			return;
		}
		if(co_contents.trim() == ''){
			alert('댓글 내용을 입력하세요.');
			// 사용자가 입력할 수 있게 focus를 맞춰줌
			$('#inputComment').focus();
			return;
		}
		
		let comment = {
				co_comments : co_contents,
				co_me_num : co_me_num,
				co_bo_num : co_bo_num
		}
		$.ajax({
			async : false,
			method: 'post',
			url : '<c:url value="/comment/insert"/>',
			data: JSON.stringify(comment),
			contentType : 'application/json; charset=utf-8',
			dataType : 'json',
			success : function(data){
				if(data.res){
					alert('댓글 등록 성공');
					$('#inputComment').val('');
					getCommentList(cri);
				}else{
					alert('댓글 등록 실패');
				}
			}
		})
	});
		// 답글 버튼 클릭시 이벤트
		$(document).on('click', '.comment-list .btn-reply', function(){
			let co_ori_num = $(this).data('num');
			let co_me_num = '${user.me_num}';
			if(co_me_num == 0){
				if(confirm('로그인이 필요한 서비스입니다. 로그인하시겠습니까?')){
					location.href = '<c:url value="/member/login"/>'
				}
				return;
			}
			// 원래 댓글 번호를 저장
			let str = '';
			str += `
				<hr>
					<div class="input-group-append mb-3 reply-box" >
						 <textarea class="form-control" placeholder="답글을 입력해주세요." name="co_content_reply" id="inputComment2"></textarea>
						 <button type="button" 
						 		 class="btn btn-outline-primary btn-sm btn-reply-insert" 
						 		 data-num="\${co_ori_num}">답글2</button>
					</div>
			`;
			$(this).parents('.comment-box').after(str);
			$(this).hide('.btn-reply');
		});
		
		/* 답글 등록 버튼 클릭 이벤트  */
		$(document).on('click','.btn-reply-insert', function(){
// 			let co_ori_num = '${comment.co_num}';
			let co_ori_num = $(this).data('num');
			let co_me_num = '${user.me_num}';
			let co_bo_num = '${board.bo_num}';
			let co_contents = $('#inputComment2').val();
			
			let comment = {
					co_ori_num : co_ori_num,
					co_me_num : co_me_num,
					co_bo_num : co_bo_num,
					co_comments : co_contents
			}
			$.ajax({
				async : false,
				method: 'post',
				url : '<c:url value="/comment/insert2"/>',
				data: JSON.stringify(comment),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(data){
					if(data.res){
						alert('답글 등록 성공');
						$('#inputComment2').val('');
						getCommentList(cri);
					}else{
						alert('답글 등록 실패');
					}
				}
			})
		});
		/* 답글 조회하기 */
			function getCommentList2(cri){
				$.ajax({
					async : false,
					method: 'post',
					url : '<c:url value="/comment/list2/"/>'+'${board.bo_num}',
					data: JSON.stringify(cri),
					contentType : 'application/json; charset=utf-8',
					dataType : 'json',
					success : function(data){
						let str ='';
						for(comment of data.list){
							str += `
								<div class="box-comment" style="margin-left:30px;">
									<div class="comment-box">
										<div class="comment-list">	
											<img src="<c:url value='/resources/images/sample.jpg'/>" class="rounded-circle profile-image" alt="기본프로필 사진">
											<div class="comment-1">
												<span class="comment-contents">\${comment.co_comments}</span>
												<span class="comment-writer">[\${comment.co_me_num}]</span>
												<span class="comment-date">\${comment.co_date}</span>
											</div>	
											<div class="comment-item">
												<button type="button" class="btn btn-outline-info btn-sm btn-update" data-num="\${comment.co_num}">수정</button>
												<button type="button" class="btn btn-outline-info btn-sm btn-del" data-num="\${comment.co_num}">삭제</button>
											</div>
										</div>
									</div>
								</div>
						`
						}
						$('.comment-list').html(str);
					}
				});
			
		} 
		
		/* 댓글 수정하기 이벤트 */
		$(document).on('click', '.btn-update', function(){
			// 클릭한 조상 클래스가 comment-list인 것을 찾아 list에 넣는다.
			let th = $(this);
			let list = $(this).parent().prev(); 
			list.find('.comment-contents').hide();
			list.find('.comment-writer').hide();
			list.find('.comment-date').hide();
			list.find('.btn-update').hide();
			list.find('.btn-del').hide();
			list.find('.btn-reply').hide();

			// 클릭한 데이터 숫자를 co_num에 넣는다.
			let co_num = $(this).data('num');
			// 클릭한 데이터 list에서 클래스가 comment-contents의 값을 co_contents에 넣는다.
			let co_contents = list.find('.comment-contents').text();
			
			str = '';
			str +=`
				<div class="input-group-append" style="float : left; width:80%">
				<textarea class="form-control comment-update" style="float : left">\${co_contents}</textarea>
				</div>
			`;
			btn='';
			btn=`
				<button type="button" class="btn btn-complete btn-outline-info" data-num="\${co_num}">수정완료</button>			
			`;
			list.find('.comment-contents').after(str)
			th.hide(); // 버튼 박스 숨기기(수정버튼)
			th.next().hide();
			th.after(btn);
		});
		
	
		/* 댓글 수정완료 이벤트 */

		$(document).on('click','.btn-complete',function(){
			let co_num = $(this).data('num');
			let co_contents = $(this).parents('.comment-list').find('.comment-update').val();
			let comment = {
					co_num : co_num,
					co_comments: co_contents
			}
			$.ajax({
				async : false,
				method: 'post',
				url : '<c:url value="/comment/update"/>',
				data: JSON.stringify(comment),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(data){
					console.log(data)
					if(data.res){
						alert('댓글 수정 성공!')
						getCommentList(cri);
					}else{
						alert('댓글 수정 실패!');
					}
				}
			});
		})
		
		/* 댓글 삭제하기 이벤트 */
		$(document).on('click', '.btn-del', function(){
			if(confirm("댓글을 정말 삭제하시겠습니까...?")){
			let comment = {
					co_num : $(this).data('num')
			}
			
			//ajax로 서버에 전송
			$.ajax({
				async : false,
				method: 'post',
				url : '<c:url value="/comment/delete"/>',
				data: JSON.stringify(comment),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(data){
					if(data.res){
						alert('댓글 삭제 성공!')
						getCommentList(cri);
					}else{
						alert('댓글 삭제 실패!');
					}
				}
			});
		}
	})
		 let cri = {
				page : 1
		}
		 // 게시글이 화면에 출력되고 이어서 댓글이 화면에 출력되어야 하기 때문에 이벤트 등록없이 바로 호출해준다.
		getCommentList(cri);
		
		function getCommentList(cri){
			$.ajax({
				async : false,
				method: 'post',
				url : '<c:url value="/comment/list/"/>'+'${board.bo_num}',
				data: JSON.stringify(cri),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(data){
					let str ='';
					for(comment of data.list){
						str += `
							<div class="box-comment">
								<div class="comment-box">
										<div class="comment-list">	
											<img src="<c:url value='/resources/images/sample.jpg'/>" class="rounded-circle profile-image" alt="기본프로필 사진">
											<div class="comment-1">
												<span class="comment-contents">\${comment.co_comments}</span>
												<span class="comment-writer">[\${comment.co_me_num}]</span>
												<span class="comment-date">\${comment.co_date}</span>
											</div>	
											<div class="comment-item">
												<button type="button" class="btn btn-outline-info btn-sm btn-update" data-num="\${comment.co_num}">수정</button>
												<button type="button" class="btn btn-outline-info btn-sm btn-del" data-num="\${comment.co_num}">삭제</button>
												<button type="button" class="btn btn-outline-primary btn-sm btn-reply" data-num="\${comment.co_num}" >답글</button>						
											</div>
										</div>
									</div>
								</div>
							<hr>
							`
					}
					$('.comment-list').html(str);
					
					let pm = data.pm;
					str = '';
					//이전버튼을 배치
					if(pm.prev){
						str += `<a class="page-link" href="javascript:void(0);" onclick="changePage(\${pm.startPage-1})"> 이전</a>`
					}
					//숫자버튼을 배치
					for(i = pm.startPage; i<=pm.endPage; i++){
						str += `<a class="page-link" href="javascript:void(0);" onclick="changePage(\${i})"> \${i}</a>`
					}
					//다음버튼을 배치
					if(pm.next){
						str += `<a class="page-link" href="javascript:void(0);" onclick="changePage(\${pm.endPage+1})"> 다음</a>`
					}
					$('.pagination').html(str);
					
				}
			});
		} 
		function changePage(page){
			cri.page = page;
			getCommentList(cri);
		}
</script>
</body>
</html>