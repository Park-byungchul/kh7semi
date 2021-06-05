<%@page import="library.beans.board.ReviewLikeDto"%>
<%@page import="library.beans.board.ReviewLikeDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.board.ReviewCommentDto"%>
<%@page import="library.beans.board.ReviewCommentDao"%>
<%@page import="library.beans.board.ReviewListDto"%>
<%@page import="library.beans.board.ReviewListDao"%>
<%@page import="library.beans.board.ReviewDto"%>
<%@page import="library.beans.board.ReviewDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 테스트
	// 세션 번호
	int clientNo;
	try {
		clientNo = (int)session.getAttribute("clientNo");
	}
	catch (Exception e) {
		clientNo = 0;
	}
	
	String root = request.getContextPath();

	// 현재 리뷰 번호
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	ReviewDao reviewDao = new ReviewDao();

	// 조회수를 위한 set
	Set<Integer> reviewNoSet;
	if(session.getAttribute("reviewNoSet") != null) {
		reviewNoSet = (Set<Integer>)session.getAttribute("reviewNoSet");
	}
	else {
		reviewNoSet = new HashSet<>();
	}

	if(reviewNoSet.add(reviewNo)) {
		reviewDao.read(reviewNo, clientNo);
	}

	session.setAttribute("reviewNoSet", reviewNoSet);
	
	ReviewDto reviewDto = reviewDao.find(reviewNo);
	BookDto bookDto = reviewDao.getBookInfo(reviewDto.getBookIsbn());

	ReviewListDao reviewListDao = new ReviewListDao();
	ReviewListDto reviewListDto = reviewListDao.find(reviewNo);
	
	// 관리자 체크
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(reviewDto.getClientNo());
	
	boolean isAdmin = false;
	if(clientNo != 0) {
		ClientDto tmp = clientDao.get(clientNo);
		if(!tmp.getClientType().equals("일반사용자")) {
			isAdmin = true;
		}
	}

	// 좋아요 체크
	boolean isLike = false;
	if(clientNo != 0) {
		ReviewLikeDao reviewLikeDao = new ReviewLikeDao();
		ReviewLikeDto reviewLikeDto = new ReviewLikeDto();
		reviewLikeDto.setReviewNo(reviewNo);
		reviewLikeDto.setClientNo(clientNo);
		isLike = reviewLikeDao.check(reviewLikeDto);
	}

	// 댓글 목록 출력
	ReviewCommentDao commentDao = new ReviewCommentDao();
	List<ReviewCommentDto> commentList = commentDao.list(reviewNo);
%>

<jsp:include page="/board/boardMenuSidebar.jsp"></jsp:include>

<style>
	.heart > a {
		color:red;
		text-decoration:none;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	// 댓글창 로그인 상태가 아니면 막아놓음
	$(function() {
		var clientNo = <%=session.getAttribute("clientNo")%>;
		if(clientNo == null) {
			clientNo = 0;
		}

		if(clientNo === 0) {
			$("#commentField").attr("readonly", true);
			$("#commentField").val("로그인 후 이용하세요");
		}
		else {
			$("#commentField").removeAttr("readonly");
			$("#commentField").val("");
		}
	});
	
	// 글 삭제
	$(function(){
		$(".board-delete-btn").click(function(e) {
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if(!choice){
				e.preventDefault();
			}
		});
	});

	// 댓글 삭제
	$(function(){
		$(".comment-delete-btn").click(function(e) {
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if(!choice){
				e.preventDefault();
			}
		});
	});
	
	// 댓글 수정
	$(function() {
		$(".comment-edit-area").hide();
		
		$(".comment-edit-btn").click(function() {
			$(this).parent().parent().next().next().show();
			$(this).parent().parent().next().hide();	
		});
		$(".comment-edit-cancel-btn").click(function() {
			$(this).parent().parent().parent().prev().show();
			$(this).parent().parent().parent().hide();
		});
	});
	
	// 댓글 높이 자동 설정
	function resize(obj) {
  		obj.style.height = "1px";
  		obj.style.height = (12+obj.scrollHeight)+"px";
	}
</script>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">도서 리뷰</span>
		</div>
				
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 열린 공간 > 도서 리뷰 </span>
		</div>
	</div>
	
	<div class="row">
		<table class="table table-border table-hover board-table">
			<tbody>
				<tr>
					<td width="15%"><img src=<%=reviewDao.getBookInfo(reviewListDto.getBookIsbn()).getBookImg() %>></td>
					<td>
						<ul class="review-area">
							<li>
								<label>도서명</label>
								<a href="../book/bookDetail.jsp?bookIsbn=<%=reviewListDto.getBookIsbn() %>" class="review-title">
									<%=bookDto.getBookTitle()%>
								</a>
								<hr>
							</li>
							<li>
								<label>저자명</label>
								<span><%=bookDto.getBookAuthor()%></span>
								<hr>
							</li>
							<li>
								<label>발행사항</label>
								<span><%=bookDto.getBookPublisher()%>, <%=bookDto.getBookDate().getYear() + 1900%></span>
								<hr>
							</li>
							<li>
								<label>ISBN</label>
								<span><%=bookDto.getBookIsbn() %></span>
							</li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
		
		<table class="table table-border table-hover board-table">
			<tbody>
				<tr>
					<th>제목</th>
					<td><%=reviewDto.getReviewSubject()%></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><%=clientDto.getClientName()%></td>
					<th>작성일</th>
					<td><%=reviewDto.getReviewDate().toLocaleString()%></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td><%=reviewDto.getReviewRead()%></td>
					<th>추천</th>
					<td><%=reviewDto.getReviewLike()%></td>
				</tr>
				<tr>
					<td colspan="4">
						<div class="row text-left">
							<pre><%=reviewDto.getReviewContent()%></pre>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="row text-right">
		<%if(clientNo != 0) {%>
			<%if(reviewDto.getClientNo() == clientNo) { %>
				<a href="reviewEdit.jsp?reviewNo=<%=reviewNo%>" class="link-btn">수정</a>
			<%} %>
			<%if(isAdmin || reviewDto.getClientNo() == clientNo) {%>
				<a href="reviewDelete.kh?reviewNo=<%=reviewNo%>" class="link-btn board-delete-btn">삭제</a>
			<%} %>
			<%if(isLike) { %>
				<span class="heart">
				<a href="reviewLikeDelete.kh?reviewNo=<%=reviewNo%>&clientNo=<%=clientNo%>" class="link-btn">♥</a>
				</span>
			<%} else { %>
				<span class="heart">
				<a href="reviewLikeInsert.kh?reviewNo=<%=reviewNo%>&clientNo=<%=clientNo%>" class="link-btn">♡</a>
				</span>
			<%} %>
		<%} %>
		<a href="reviewList.jsp" class="link-btn">목록</a>
	</div>
		
	<ul class="comment-area">
		<%for(ReviewCommentDto commentDto : commentList) { %>
			<li class="row text-left comment-list">
				<div class="float-container">
					<div class="left">
						<span style="font-weight:bold"><%=commentDao.getClientName(commentDto.getClientNo()) %>&nbsp;</span>
						<span style="color:gray"><%=commentDto.getCommentDate().toLocaleString() %></span>
					</div>
					
					<%if(commentDto.getClientNo() == clientNo) { %>
						<div class="right">
							<a class="comment-edit-btn">수정</a>
							| 
							<a class="comment-delete-btn" href="reviewCommentDelete.kh?commentNo=<%=commentDto.getCommentNo()%>&reviewNo=<%=reviewNo%>">삭제</a>
						</div>
					<%} %>
				</div>

				<!-- 화면 표시 댓글 -->
				<div class="comment-display-area">
					<pre><%=commentDto.getCommentField() %></pre>
				</div>
				<%if(commentDto.getClientNo() == clientNo) { %>
					<div class="comment-edit-area">
						<form action="reviewCommentEdit.kh" method="post">
							<input type="hidden" name="commentNo" value="<%=commentDto.getCommentNo()%>">
							<input type="hidden" name="reviewNo" value="<%=reviewNo%>">
							<textarea maxlength="300" onkeydown="resize(this)" onkeyup="resize(this)" class="comment-textarea" name="commentField" required><%=commentDto.getCommentField()%></textarea>
							<div class="text-right">
								<input type="submit" class="form-btn form-btn-inline" value="댓글 수정">
								<input type="button" class="form-btn form-btn-inline comment-edit-cancel-btn" value="작성 취소" class="comment-edit-cancel-btn">
							</div>
						</form>
					</div>
				<%} %>
			</li>
		<%} %>
		
		<!-- 댓글 작성 -->
		<form action="reviewCommentInsert.kh" method="post">
			<input type="hidden" name="reviewNo" value="<%=reviewNo%>">
			<div class="row">
				<textarea maxlength="300" onkeydown="resize(this)" onkeyup="resize(this)" class="comment-textarea" id="commentField" name="commentField" required></textarea>
				<div class="text-right">
					<%if(clientNo != 0) {%>
						<input class="form-btn form-btn-inline" type="submit" value="댓글 작성">
					<%} %>
				</div>
			</div>
		</form>
	</ul>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>