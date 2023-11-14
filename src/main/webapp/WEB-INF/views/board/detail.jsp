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

form{
	margin-top: 50px;
}

.form-control {
	margin-bottom: 10px;
}

.btn {
	margin-bottom: 10px;
}

.comment-box {
	background-color: #ededed;
	border-radius: 20px; padding: 10px; margin: 0 0 20px 0;
	display : flex;
}


.comment-box1 {
	display: flex;
}
/* 프로필 사진 */
.profile-image {
	width: 70px;
	height: 70px;
	border-radius: 50%; /* 둥글두그륵 만들기 */
	object-fit: cover; /* 이미지가 찌그러지지 않도록 설정하는 것 */
	float: left;
}
/* 댓글 내용 */
.comment-list {
	list-style: none;
	padding: 10px;
	width: 100%;
}
/* 수정 삭제 버튼 */
.comment-item {
	float: right;
	position: relative;
}
/* 날짜 */
.comment-date {
	display: block;
	margin-left: 80px;
	padding-top: 50px;
}

/* 댓글, 답글 내용만 */
.comment-contents {
	margin-left: 91px;
	margin-top: 20px;
	display: flex;
}

.comment-nickname {
	margin-left: 20px;
	font-weight: bold;
}

/* 모달 */
.modal--bg {
	display: none;
	position: fixed;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.3);
	justify-content: center;
	align-items: center;
}

.modal--content {
	background-color: white;
	padding: 20px;
	border-radius: 5px;
	max-width: 400px;
	margin: 200px auto;
	
}
</style>    
</head>
</head>
<body>

	<br>
	<form action="<c:url value='/board/detail'/>" method="post">
		<div class="form-group">
			<label>제목</label>
			<input type="text" class="form-control" name="bo_title" value="${board.bo_title}" readonly>
		</div>
		<div class="form-group">
			<label>작성자</label>
			<input type="text" class="form-control" name="bo_me_id" value="${board.me_nickname}" readonly>
		</div>
		<c:if test="${board.bo_contents != null}">
			<div class="input-group mb-3">
			    <div class="input-group">
			    	<div class="form-control"
						 style="height : 600px; overflow-y: auto; text-align: center;" >${board.bo_contents}</div>
			    </div>
			</div>
		</c:if>
		<div class="form-group">
			<c:choose>
				<c:when test="${fileList.size() != 0 }">
					<label>첨부파일</label><br>
						<c:forEach items="${fileList}" var="file">
							<a  href="<c:url value='/download${file.fi_ori_name}'/>" 
								download="${file.fi_name}">${file.fi_name}</a><br>
						</c:forEach>
				</c:when>
				<c:otherwise>
					<label>첨부파일 없음</label>
					<hr>
				</c:otherwise>
			</c:choose>
		</div>
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
		<c:if test="${board.bo_bt_num != 6 && board.bo_bt_num != 7}">
			<!-- 댓글 입력창  -->
			<label>댓글</label><br>
			<div class="input-group-append mb-3">
				<textarea class="form-control" placeholder="댓글을 입력해주세요." id="inputComment"></textarea>
			    <button type="button"  class="btn" id="btnCommentInsert"
					style="background-color: #c2f296; border-radius: 5px; width: 70px;">등록</button>
			 </div>
		</c:if>
		<!-- 댓글 목록창 -->
		<div class="box-comment">
			<div class="comment-box1" >
				<div class="comment-list">
					<div class="comment-1">
						<span class="comment-nickname">${comment.me_nickname}</span>
						<span class="comment-contents">${comment.co_comments}</span>
<%-- 						<span class="comment-writer">${comment.co_me_num}</span> --%>
						<span class="comment-date" style="color: #5b5b5b">${comment.co_date}</span>	
					</div>
					<div class="comment-item">
						<c:if test="${comment.co_me_num == user.me_num}">
							<button type="button" class="btn btn-update" style="background-color: #f2f2f2; border-radius: 5px; width: 70px;"
								data-num="${comment.co_num}">수정</button>
							<button type="button" class="btn btn-sm btn-del" data-num="${comment.co_num}">삭제</button>
						</c:if>
						<c:if test="${comment.co_num == comment.co_ori_num}">						
							<button type="button" class="btn btn-outline-primary btn-sm btn-reply" value="${comment.co_num}">답글</button>						
						</c:if>
					</div>
				</div>
			</div>
			<!-- 모달버튼 -->
			<c:if test="${board.bo_bt_num != 5 && board.bo_bt_num != 6 && board.bo_bt_num != 7 }">
				<div style="text-align: right; ">
					<button type="button" class="btn button--open"
						 style="background-color: black; color: white; border-radius: 10px; height: 40px; width: 120px; margin: 0 20px 30px 10px;"
						 data-value="${board.bo_num}">게시글 신고</button>
				</div>	 
			</c:if>
			<%-- <c:forEach items="${list}" var="replyComment">	
				<c:if test="${replyComment.co_ori_num != replyComment.co_num}">		
					 <div class="box-comment-reply" >
						<div class="comment-box-reply">
							<div class="comment-list2" style="margin-left:100px">	
								<img src="/final_project${user.me_profile}" class="rounded-circle profile-image" alt="기본프로필 사진">
								<div class="comment-1-reply">
									<span class="comment-contents-reply">${replyComment.co_comments}</span>
									<span class="comment-writer-reply">[${replyComment.co_me_num}]</span>
									<span class="comment-date-reply">${replyComment.co_date}</span>
								</div>	
								<div class="comment-item">
									<button type="button" class="btn btn-outline-info btn-sm btn-update-reply" data-num="${replyComment.co_num}">수정</button>
									<button type="button" class="btn btn-outline-info btn-sm btn-del-reply" data-num="${replyComment.co_num}">삭제</button>
								</div>
							</div>
						</div>
					</div> 
				</c:if>
			</c:forEach> --%>
		<!-- 댓글 페이지네이션 -->
			<div class="pagination justify-content-center">
				<a class="page-link" href="#"> 이전</a>
				<a class="page-link" href="#"> 1</a>
				<a class="page-link" href="#"> 다음</a>
			</div>
		</div>
		
	
		<!-- 자신이 쓴 게시글만 수정,삭제 버튼 나오게 -->
			<c:if test="${user != null && user.me_num == board.bo_me_num}">
				<div style="text-align: center; margin-top: 80px;">
					<button type="button"
							class="btn btn-board-update"
							style="background-color: #d7fdb5; color: black; height: 45px; border-radius: 10px; width: 400px; margin-bottom: 20px;"
							onclick="location.href='<c:url value='/board/update?bo_num=${board.bo_num}'/>'">수정하기
					</button>
				</div>	
			</c:if>
			<c:if test="${user != null && user.me_num == board.bo_me_num}">
				<div style="text-align: center;">
					<button type="button"
							class="btn btn-delete"
							style="background-color: #d7fdb5; color: black; border-radius: 10px; height: 45px; width: 400px;"
							onclick="location.href='<c:url value='/board/delete?bo_num=${board.bo_num}'/>'">삭제하기
					</button><br>
				</div>
			</c:if>
		
	</form>
	<!-- 모달창 -->
	<div class="modal--bg">
		<div class="modal--content">
			<p style="font-size: 20px; font-weight: bolder; margin: 0 auto; border-bottom: 8px solid #c2f296;
			width: 20%; padding: 20px 0 10px 0; text-align: center;">신고하기</p>
			<form class="modal-form" action="<c:url value='/admin/boardReport/insert'/>" method="post">
				<input type="hidden" class="form-control" name="rp_me_num" value="${user.me_num}" readonly>
				<input type="hidden" class="form-control" name="rp_bo_num" value="${board.bo_num}" readonly>
				<input type="hidden" class="form-control" name="rp_me_num2" value="${board.bo_me_num}" readonly>
				<div class="form-group">
					<select class="form-control isSelected" name="rp_rc_num">
						<option value="0">분류</option>
						<option value="6">음란물</option>
						<option value="7">스팸</option>
						<option value="8">홍보</option>
						<option value="9">광고</option>
						<option value="10">분란 조장</option>
						<option value="11">혐오</option>
						<option value="12">욕설</option>
						<option value="13">기타</option>
					</select>
					<textarea cols="46" rows="6" name="rp_content"></textarea>
				</div>
				<div style="text-align: center; margin-top: 40px;">
					<button type="button" style="background-color: black; color: white; border-radius: 10px; width: 80px;"
						class="btn button--close">닫기</button> 
					<button  style="background-color: black; color: white; border-radius: 10px; width: 80px;"
						class="btn">신고</button> 
				</div>	
			</form> 
		</div>
	</div>
	<!-- 썸머노트 -->
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
					<div class="input-group-append mb-3 reply-box" style="margin-left: 30px;">
						 <textarea class="form-control" placeholder="답글을 입력해주세요." name="co_content_reply" id="inputComment2"></textarea>
						 <button type="button" 
						 		 class="btn btn-reply-insert" 
						 		 style="background-color: #d0f7ad; border-radius: 5px; width: 60px;"
						 		 data-num="\${co_ori_num}">답글</button>
					</div>
			`;
			
			$(this).parents('.comment-box').after(str);
			$(this).hide('.btn-reply');
		});
		
		/* 답글 등록 버튼 클릭 이벤트  */
		$(document).on('click','.btn-reply-insert', function(){
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
			/* function getCommentList2(cri){
				$.ajax({
					async : false,
					method: 'post',
					url : '<c:url value="/reply/comment/list/"/>'+'${board.bo_num}',
					data: JSON.stringify(cri),
					contentType : 'application/json; charset=utf-8',
					dataType : 'json',
					success : function(data){
						let str ='';
						for(comment of data.list){
							str += `
						<c:forEach items="\${list}" var="replyComment">	
							<c:if test="\${replyComment.co_ori_num eq comment.co_num}">		
								<div class="box-comment-reply">
									<div class="comment-box-reply">
										<div class="comment-list2">	
											<img src="<c:url value='/resources/images/sample.jpg'/>" class="rounded-circle profile-image" alt="기본프로필 사진">
											<div class="comment-1-reply">
												<span class="comment-contents-reply">\${replyComment.co_comments}</span>
												<span class="comment-writer-reply">[\${replyComment.co_me_num}]</span>
												<span class="comment-date-reply">\${replyComment.co_date}</span>
											</div>	
											<div class="comment-item-reply">
												<button type="button" class="btn btn-outline-info btn-sm btn-update-reply" data-num="\${replyComment.co_num}">수정</button>
												<button type="button" class="btn btn-outline-info btn-sm btn-de-replyl" data-num="\${replyComment.co_num}">삭제</button>
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
						`
						}
						
						$('.comment-list2').html(str);
					}
				});
			}   */
		
		/* 댓글 수정하기 이벤트 */
		$(document).on('click', '.btn-update', function(){
			// 클릭한 조상 클래스가 comment-list인 것을 찾아 list에 넣는다.
			let th = $(this);
			let list = $(this).parent().prev(); 
			list.find('.comment-nickname').hide();
			list.find('.comment-contents').hide();
// 			list.find('.comment-writer').hide();
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
				<div class="input-group-append" style="float : left; width:80%; margin-left : 5px">
				<textarea class="form-control comment-update" style="float : left">\${co_contents}</textarea>
				</div>
			`;
			btn='';
			btn=`
				<button type="button" class="btn btn-complete"
					style="background-color: #dddddd; border-radius: 5px; width: 90px;"
					data-num="\${co_num}">수정완료</button>			
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
			if(confirm("댓글을 삭제하시겠습니까?")){
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
						let btnStr = '';
						if (comment.co_num == comment.co_ori_num){
							btnStr =`<button type="button" class="btn btn-reply" style="background-color: #d0f7ad; border-radius: 5px; width: 60px;"
								data-num="\${comment.co_num}" >답글</button>`
							}
						
						 let updateButton = '';
			             let deleteButton = '';
			             if (comment.co_me_num == '${user.me_num}') {
			                    updateButton = `<button type="button" class="btn btn-update" style="background-color: #dddddd; border-radius: 5px; width: 60px;"
			                    	data-num="\${comment.co_num}">수정</button>`;
			                    deleteButton = `<button type="button" class="btn btn-del"  style="background-color: #dddddd; border-radius: 5px; width: 60px;"
			                    	data-num="\${comment.co_num}">삭제</button>`;
			                }
			            
			             let comments = ''; 
			            if (comment.bl_blocked_num == 0){
			            	comments = `<span class="comment-contents">\${comment.co_comments}</span>`
			            }else{
			            	comments = `<span class="comment-contents">차단된 사람의 댓글입니다.</span>`
			            }
						
			            str += `
							<div class="box-comment">
								<div class="comment-box" \${comment.co_num != comment.co_ori_num ? 'style="margin-left: 50px; background-color: #f2f2f2;"' : ''}>
										<div class="comment-list">	
											<img src="<c:url value='/memberimg\${comment.me_profile}'/>" class="rounded-circle profile-image" alt="기본프로필 사진">
											<div class="comment-1">
												<span class="comment-nickname">\${comment.me_nickname}</span>
												\${comments}
												<span class="comment-date">\${comment.co_date}</span>
											</div>	
											<div class="comment-item">
											  	\${updateButton}
			                                    \${deleteButton}
												\${btnStr}
											</div>
										</div>
									</div>
								</div>
							<hr>
							`;
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
	
		
		 //모달 
		 $(document).ready(function() {
		        $('.button--open').click(function() {
		            showModal();
		        });

		        $('.button--close').click(function() {
		            closeModal();
		        });

		        function showModal() {
		            $('.modal--bg').fadeIn();
		        }

		        function closeModal() {
		            $('.modal--bg').fadeOut();
		        }
		    });
		 //모달 옵션 선택여부에 따라 알림창 또는 제출
		 $(document).ready(function () {
            $(".modal-form").submit(function (e) {
                // 선택된 값이 0이면 제출을 막고 알림창 띄우기
                var selectedValue = $(".isSelected").val();
                if (selectedValue == 0) {
                    alert("옵션을 선택하세요.");
                    e.preventDefault(); // 제출 막기
                }
                // 선택된 값이 유효하면 폼이 계속 제출됨
            });
        });
</script>
</body>
</html>