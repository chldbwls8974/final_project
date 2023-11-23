<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">
	.tag{ display:inline;}
	.container-body{ width: 100%; height: auto; margin-top: 50px;}
	
	.text{ border-left: 7px solid #c2f296; padding-left: 10px;}
	.top-btn{width: 120px; height: 40px; margin: auto auto 10px; border: none;
		border-radius: 10px; background-color: #c2f296; color: black;}
	.btn{
		width: 90px; height: 40px; margin: auto auto 10px; border: none;
		border-radius: 10px; background-color: #fcfff8; color: black;
	}
	.table{
		background-color: #f2f2f2;
	    padding: 10px;
	    border-radius: 25px;
	}
	
	th{ padding: 20px; vertical-align: baseline;}
	.table th{ border: none;}
	.table thead th, .table tbody td{ border-bottom: none; text-align: center;}
	.table tbody tr:hover{ background-color: #f4f8f1;}
	.btn-group{
		display: flex;
	    justify-content: center;
	    margin-bottom: 50px;
	}
	a{
		color:black;
	}
	img{
		width: 70px; height: 70px; border-radius: 50%;
		margin-right: 10px;
	}
</style>
</head>
<body>
	<div class="container-body">
	<p style="font-size: 35px; font-weight: bolder; margin: 20px auto; border-bottom: 8px solid #c2f296;
	width: 23%; padding: 10px 0 10px 0; text-align: center;">클럽 멤버 관리</p>
		  <div class="btn-group">
			  <div style="margin-right: 10px;">
			    <button type="button" class="top-btn" name="member-tag">멤버 조회</button>
			  </div>
			  <div>
			    <button type="button" class="top-btn" name="rookie-tag">승인 대기 중</button>
			  </div> 
		  </div>
		<div id="table">
			<div class="table member-table" id="mtable">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>회원 번호</th>
							<th>프로필사진</th>
							<th>회원 닉네임</th>
							<th>권한</th>
							<th style="width: 25%;"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="list">
							<c:if test="${list.cm_authority =='LEADER'}">
								<tr>
									<td>${list.cm_num}</td>
									<td><img alt=""
										src="<c:url value='/memberimg${list.me_profile}'/>" name="profile"></td>
									<td>${list.me_nickname}</td>
									<td>${list.cm_authority}</td>
									<td style="width: 25%;"></td>
								</tr>
							</c:if>
						</c:forEach>
						<c:forEach items="${list }" var="list">
							<c:if test="${list.cm_authority =='MEMBER'}">
								<tr>
									<td>${list.cm_num}</td>
									<td><a
										href="<c:url value='/member/myprofile?me_num=${list.cm_num}'/>"
										class="member-link"><img alt=""
										src="<c:url value='/memberimg${list.me_profile}'/>" name="profile"></a></td>
									<td><a
										href="<c:url value='/member/myprofile?me_num=${list.cm_num}'/>"
										class="member-link"> ${list.me_nickname}</a></td>
									<td>${list.cm_authority}</td>
									<td style="width: 25%;"><c:if
											test="${list.cm_authority =='MEMBER'}">
											<button type="button" class="btn"
												data-num="${list.cm_me_num}" value="${list.cm_authority}"
												name="delegate-btn" style="margin-right: 10px;">위임</button>
											<button type="button" class="btn"
												data-num="${list.cm_me_num}" value="${list.cm_authority}"
												name="discharge-btn">강퇴</button>
										</c:if></td>

								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="table rookie-table" id="rtable">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>프로필사진</th>
							<th>회원 닉네임</th>
							<th>자기소개</th>
							<th style="width: 25%;"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="list">
							<c:if test="${list.cm_authority =='ROOKIE'}">
								<tr>
									<td>${list.cm_num}</td>
									<td><a
										href="<c:url value='/member/myprofile?me_num=${list.cm_num}'/>"
										class="member-link"><img alt=""
										src="<c:url value='/memberimg${list.me_profile}'/>" name="profile"></a></td>
									<td>${list.me_nickname}</td>
									<td><a
										href="<c:url value='/member/myprofile?me_num=${list.cm_num}'/>"
										class="member-link"> ${list.me_nickname}</a></td>
									<td>${list.cm_introduction}</td>
									<td style="width: 25%;">
										<button type="button" class="btn" data-num="${list.cm_me_num}"
											value="${list.cm_authority}" name="approval-btn">승인</button>
										<button type="button" class="btn" data-num="${list.cm_me_num}"
											value="${list.cm_authority}" name="refuse-btn">거절</button>
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		let cl_num = ${club.cl_num}
		let url =  '/final_project/club/detail?cl_num=';
		url += cl_num;
		// 표 전환
		$('.rookie-table').hide();
		
		$(document).on('click','[name = member-tag]',function(){
			$('.member-table').show();
			$('.rookie-table').hide();
		})
		$(document).on('click','[name=rookie-tag]',function(){
			$('.member-table').hide();
			$('.rookie-table').show();
			
		})
		
		// 멤버 테이블 관리
		// 강퇴 버튼 클릭시
		$(document).on('click','[name=discharge-btn]',function(){
			let obj = $(this);
			if(confirm("정말 팀원을 강퇴시키시겠습니까?")){
				let me_num = $(this).data('num')
				let type="discharge"
				
				data={
						cl_num : cl_num,
						me_num : me_num,
						type : type
				}
				
				ajaxJsonToJson2(false, 'post','/club/mbmanage',data, (a)=>{
					alert("팀원을 퇴장시켰습니다.")
// 					여기 물어봐야함
					$('#mtable').load(location.href+' #mtable');
					//location.reload();
					//obj.parents('tr').remove();
				})
			}
		})
				
		
		// 위임 버튼 클릭시
		$(document).on('click','[name=delegate-btn]',function(){
			if(confirm("정말 클럽장 권한을 위임하시겠습니까?")){
				let me_num = $(this).data('num')
				let type="delegate"
				
				data={
						cl_num : cl_num,
						me_num : me_num,
						type : type
				}
				
				ajaxJsonToJson2(false, 'post','/club/mbmanage',data, (a)=>{
					alert("클럽장을 위임하였습니다.")
					location.replace(url);
				})
			}
		})
		
		
		
		// 루키 테이블 관리
		// 승인버튼 클릭시
		$(document).on('click','[name=approval-btn]',function(){
			if(confirm("정말 승인하시겠습니까?")){
				let me_num = $('[name=approval-btn]').data('num')
				let type="approval"
				
				data={
						cl_num : cl_num,
						me_num : me_num,
						type : type
				}
				ajaxJsonToJson2(false, 'post','/club/mbmanage',data, (a)=>{
					alert("팀원 신청을 승인하였습니다.") 
					$('#rtable').load(location.href+' #rtable');
// 					$('.member-table').hide();
// 					$('.rookie-table').show();
				})
				
			}
			
			
		})

		// 거절버튼 클릭시
		$(document).on('click','[name=refuse-btn]',function(){
			if(confirm("정말 거절하시겠습니까?")){
					let me_num = $(this).data('num')
					let type="refuse"
					
					data={
							cl_num : cl_num,
							me_num : me_num,
							type : type
					}
					
					ajaxJsonToJson2(false, 'post','/club/mbmanage',data, (a)=>{
					 	alert("팀원 신청을 거절하였습니다.")
					 	$('#rtable').load(location.href+' #rtable');
					})
			}else{
				return;
			}
		
		})
		
	</script>

</body>
</html>