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
		display:flex;
		align-items :center;
	}
	.profile-image {
	    width: 60px; 
	    height: 60px; 
	    border-radius: 50%; /* 둥글두그륵 만들기 */
	    object-fit: cover; /* 이미지가 찌그러지지 않도록 설정하는 것 */
	}
	.comment-list{
		list-style : none;
		padding-left:10px;
		margin:0;
		display : flex;
	}
	.comment-item{
		margin-bottom : 10px;
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
					<ul class="comment-list">
						<li class="comment-item">
							<span class="comment-contents">${comment.co_comments}</span>
							<span class="comment-writer">${comment.co_me_num}</span>
							<button class="btn btn-outline-info btn-sm" >수정</button>
							<button class="btn btn-outline-info btn-sm">삭제</button>
						</li>
					</ul>
				
			</div>
			
		<!-- 댓글 페이지네이션 -->
			<div class="pagination justify-content-center">
				<a href="#"> 이전</a>
				<a href="#"> 1</a>
				<a href="#"> 다음</a>
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
			}else{
				alert('댓글 등록 실패');
			}
		}
	})
});
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
							<img src="<c:url value='/resources/images/sample.jpg'/>" class="rounded-circle profile-image" alt="기본프로필 사진">
							<ul class="comment-list">	
								<li class="comment-item">
									<span class="comment-contents">\${comment.co_comments}</span>
									<span class="comment-writer">[\${comment.co_me_num}]</span>
									<button class="btn btn-outline-info btn-sm" >수정</button>
									<button class="btn btn-outline-info btn-sm">삭제</button>
								</li>
							</ul>
							
							`
					}
					$('.comment-list').html(str);
					
					let pm = data.pm;
					str = '';
					//이전버튼을 배치
					if(pm.prev){
						str += `<a href="javascript:void(0);" onclick="changePage(\${pm.startPage-1})"> 이전</a>`;
					}
					//숫자버튼을 배치
					for(i = pm.startPage; i<=pm.endPage; i++){
						str += `<a href="javascript:void(0);" onclick="changePage(\${i})"> \${i}</a>`
					}
					//다음버튼을 배치
					if(pm.next){
						str += `<a href="javascript:void(0);" onclick="changePage(\${pm.endPage+1})"> 다음</a>`
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