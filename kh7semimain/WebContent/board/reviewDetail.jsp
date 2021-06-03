<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.ReviewCommentDto"%>
<%@page import="library.beans.ReviewCommentDao"%>
<%@page import="library.beans.ReviewListDto"%>
<%@page import="library.beans.ReviewListDao"%>
<%@page import="library.beans.ReviewDto"%>
<%@page import="library.beans.ReviewDao"%>
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

	session.setAttribute("boardNoSet", reviewNoSet);
	
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
// 	boolean isLike = false;
// 	if(clientNo != 0) {
// 		BoardLikeDao boardLikeDao = new BoardLikeDao();
// 		BoardLikeDto boardLikeDto = new BoardLikeDto();
// 		boardLikeDto.setBoardNo(boardNo);
// 		boardLikeDto.setClientNo(clientNo);
// 		isLike = boardLikeDao.check(boardLikeDto);
// 	}
	
	//이전글 정보 불러오기
// 	ReviewDto prevReviewDto = reviewDao.getPrevious(reviewNo);
	
// 	//다음글 정보 불러오기
// 	ReviewDto nextReviewDto = reviewDao.getNext(reviewNo);

// 	// 댓글 목록 출력
// 	ReviewCommentDao commentDao = new ReviewCommentDao();
// 	List<ReviewCommentDto> commentList = commentDao.list(reviewNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

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
			$("#commentContent").attr("readonly", true);
			$("#commentContent").val("로그인 후 이용하세요");
		}
		else {
			$("#commentContent").removeAttr("readonly");
			$("#commentContent").val("");
		}
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
			$(this).parent().parent().next().hide();
			$(this).parent().parent().next().next().show();
		});
		$(".comment-edit-cancel-btn").click(function() {
			$(this).parent().parent().hide();
			$(this).parent().parent().prwv.show();
		});
	});
</script>

<div class="container-800">
	<div class="row text-left">
		<h1>리뷰 게시판</h1>
	</div>
	
	<div class="row text-left">
		<h3><%=reviewDto.getReviewSubject() %></h3>
	</div>

	<div class="row float-container">
		<div class="left">
			<%=clientDto.getClientName()%>
		</div>
		<div class="right">
			조회수 <%=reviewDto.getReviewRead()%>
			좋아요 <%=reviewDto.getReviewLike()%>				
		</div>		
		<div class="right">
			<%=reviewDto.getReviewDate().toLocaleString()%>
		</div>
	</div>
	
	<div class="row float-container">
		<div class="left">
			도서명 <%=bookDto.getBookTitle()%>
			저자	<%=bookDto.getBookAuthor()%>
			출판사 <%=bookDto.getBookPublisher()%>
			출판일 <%=bookDto.getBookDate()%>			
		</div>
	</div>
	
	<div class="row text-left" style="min-height:300px;">
		<pre><%=reviewDto.getReviewContent()%></pre>
	</div>
	
	<form action="commentInsert.kh" method="post">
			<input type="hidden" name="reviewNo" value="<%=reviewNo%>">
			<div class="row">
				<textarea id="commentContent" name="commentContent" required></textarea>
			</div>
			<div class="row">
				<input type="submit" value="댓글 작성">
			</div>
		</form>
		
<!-- 		<div class="row text-left"> -->
<!-- 			<h4>댓글 목록</h4> -->
<!-- 		</div> -->
<%-- 		<%for(ReviewCommentDto commentDto : commentList) { %> --%>
<!-- 			<div class="row text-left" style="border:1px solid gray;"> -->
<!-- 				<div class="float-container"> -->
<%-- 					<div class="left"><%=commentDao.getClientName(commentDto.getClientNo()) %></div> --%>
					
<%-- 					 <%if(commentDto.getClientNo() == clientNo) { %> --%>
<!-- 						<div class="right"> -->
<!-- 							<a class="comment-edit-btn">수정</a> -->
<!-- 							|  -->
<%-- 							<a class="comment-delete-btn" href="commentDelete.kh?commentNo=<%=commentDto.getCommentNo()%>&reviewNo=<%=reviewNo%>">삭제</a> --%>
<!-- 						</div> -->
<%-- 					<%} %> --%>
<!-- 				</div> -->
<!-- 				화면 표시 댓글 -->
<!-- 				<div class="comment-display-area"> -->
<%-- 					<pre><%=commentDto.getCommentContent() %></pre> --%>
<!-- 				</div> -->
<%-- 				<%if(commentDto.getClientNo() == clientNo) { %> --%>
<!-- 					<div class="comment-edit-area"> -->
<!-- 						<form action="commentEdit.kh" method="post"> -->
<%-- 							<input type="hidden" name="commentNo" value="<%=commentDto.getCommentNo()%>"> --%>
<%-- 							<input type="hidden" name="reviewNo" value="<%=reviewNo%>"> --%>
<%-- 							<textarea name="commentContent" required><%=commentDto.getCommentContent()%></textarea> --%>
<!-- 							<input type="submit" value="댓글 수정"> -->
<!-- 							<input type="button" value="작성 취소" class="comment-edit-cancel-btn"> -->
<!-- 						</form> -->
<!-- 					</div> -->
<%-- 				<%} %> --%>
<%-- 				<div><%=commentDto.getCommentDate().toLocaleString() %></div> --%>
<!-- 			</div> -->
<%-- 		<%} %> --%>
	
	<div class="row text-right">
		<!-- 본인 및 관리자에게만 표시되도록 하는 것이 좋다 -->
		<%if(clientNo != 0) {%>
			<%if(reviewDto.getClientNo() == clientNo) { %>
				<a href="boardEdit.jsp?reviewNo=<%=reviewNo%>" class="link-btn">수정</a>
			<%} %>
			<%if(isAdmin || reviewDto.getClientNo() == clientNo) {%>
				<a href="boardDelete.kh?reviewNo=<%=reviewNo%>" class="link-btn">삭제</a>
			<%} %>
<%-- 			<%if(isLike) { %> --%>
<!-- 				<span class="heart"> -->
<%-- 				<a href="boardLikeDelete.kh?reviewNo=<%=reviewNo%>&clientNo=<%=clientNo%>" class="link-btn">♥</a> --%>
<!-- 				</span> -->
<%-- 			<%} else { %> --%>
<!-- 				<span class="heart"> -->
<%-- 				<a href="boardLikeInsert.kh?reviewNo=<%=reviewNo%>&clientNo=<%=clientNo%>" class="link-btn">♡</a> --%>
<!-- 				</span> -->
<%-- 			<%} %> --%>
		<%} %>
		<a href="reviewList.jsp" class="link-btn">목록</a>
	</div>
	
<!-- 	<div class="row text-left"> -->
<!-- 		다음글 :  -->
<%-- 		<%if(nextReviewDto == null){%> --%>
<!-- 		다음글이 없습니다. -->
<%-- 		<%}else{ %> --%>
<%-- 		<a href="boardDetail.jsp?reviewNo=<%=nextReviewDto.getReviewNo()%>"> --%>
<%-- 			<%=nextReviewDto.getReviewSubject()%> --%>
<!-- 		</a> -->
<%-- 		<%} %> --%>
<!-- 	</div> -->
<!-- 	<div class="row text-left"> -->
<!-- 		이전글 :  -->
<%-- 		<%if(prevReviewDto == null){%> --%>
<!-- 		이전글이 없습니다. -->
<%-- 		<%}else{ %> --%>
<%-- 		<a href="boardDetail.jsp?reviewNo=<%=prevReviewDto.getReviewNo()%>"> --%>
<%-- 			<%=prevReviewDto.getReviewSubject()%> --%>
<!-- 		</a> -->
<%-- 		<%} %> --%>
<!-- 	</div> -->
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>