<%@page import="library.beans.BoardAnswerDto"%>
<%@page import="library.beans.BoardAnswerDao"%>
<%@page import="library.beans.BoardCommentDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.BoardCommentDao"%>
<%@page import="library.beans.BoardLikeDto"%>
<%@page import="library.beans.BoardLikeDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="library.beans.BoardListDto"%>
<%@page import="library.beans.BoardListDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.BoardDao"%>
<%@page import="library.beans.BoardDto"%>
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

	// 현재 보드 번호
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	BoardDao boardDao = new BoardDao();

	// 조회수를 위한 set
	Set<Integer> boardNoSet;
	if(session.getAttribute("boardNoSet") != null) {
		boardNoSet = (Set<Integer>)session.getAttribute("boardNoSet");
	}
	else {
		boardNoSet = new HashSet<>();
	}
	
	if(boardNoSet.add(boardNo)) {
		boardDao.read(boardNo, clientNo);
	}

	session.setAttribute("boardNoSet", boardNoSet);
	
	// board Data 가져옴
	BoardDto boardDto = boardDao.find(boardNo);
	
	// board List View 가져옴
	BoardListDao boardListDao = new BoardListDao();
	BoardListDto boardListDto = boardListDao.find(boardNo);
	
	// 관리자 체크
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(boardDto.getClientNo());
	
	boolean isAdmin = false;
	if(clientNo != 0) {
		ClientDto tmp = clientDao.get(clientNo);
		if(!tmp.getClientType().equals("일반사용자")) {
			isAdmin = true;
		}
	}

	// 지점 체크
	AreaDao areaDao = new AreaDao();
	AreaDto areaDto;
	if(boardDto.getAreaNo() != 0) {
		areaDto = areaDao.detail(boardDto.getAreaNo());
	}
	else {
		areaDto = null;
	}
	
	// 좋아요 체크
	boolean isLike = false;
	if(clientNo != 0) {
		BoardLikeDao boardLikeDao = new BoardLikeDao();
		BoardLikeDto boardLikeDto = new BoardLikeDto();
		boardLikeDto.setBoardNo(boardNo);
		boardLikeDto.setClientNo(clientNo);
		isLike = boardLikeDao.check(boardLikeDto);
	}
	
	//이전글 정보 불러오기
	BoardDto prevBoardDto = boardDao.getPrevious(boardListDto.getBoardTypeNo(), boardListDto.getBoardSepNo());
	
	//다음글 정보 불러오기
	BoardDto nextBoardDto = boardDao.getNext(boardListDto.getBoardTypeNo(), boardListDto.getBoardSepNo());

	// 댓글 목록 출력
	BoardCommentDao commentDao = new BoardCommentDao();
	List<BoardCommentDto> commentList = commentDao.list(boardNo);
	
	BoardAnswerDao answerDao = new BoardAnswerDao();
	BoardAnswerDto answerDto = answerDao.get(boardNo);
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
	// 목록 눌렀을 때 돌아가는 함수
	function chooseList() {
		var boardTypeNo = <%=boardListDto.getBoardTypeNo()%>;
		
		if(boardTypeNo === 1) {
			location.href = "noticeList.jsp";
		}
		else if(boardTypeNo === 2) {
			location.href = "qnaList.jsp";
		}
		else if(boardTypeNo === 3) {
			location.href = "freeBoardList.jsp";
		}
		else if(boardTypeNo === 4) {
			location.href = "reviewList.jsp";
		}
	}
	
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
		<h1><%=boardListDto.getBoardTypeName() %></h1>
	</div>
	
	<div class="row text-left">
		<h3>
			<%if(boardDto.getAreaNo() != 0){ %>
				[<%=areaDto.getAreaName() %>]
			<%} else if(boardDto.getBoardTypeNo() == 1 || boardDto.getBoardTypeNo() == 2) { %>
				[전체]
			<%} %>
			<%=boardDto.getBoardTitle()%>
		</h3>
	</div>
	
	<div class="row float-container">
		<div class="left">
			<%=clientDto.getClientName()%>
		</div>
		<div class="right">
			조회수 <%=boardDto.getBoardRead()%>
			좋아요 <%=boardDto.getBoardLike()%>				
		</div>		
		<div class="right">
			<%=boardDto.getBoardDate().toLocaleString()%>
		</div>
	</div>
	
	<div class="row text-left" style="min-height:300px;">
		<pre><%=boardDto.getBoardField()%></pre>
	</div>
	
	<!-- 질문답변 게시판에는 댓글이 없음 -->
	<%if(boardDto.getBoardTypeNo() != 2) { %>
		<form action="commentInsert.kh" method="post">
			<input type="hidden" name="boardNo" value="<%=boardNo%>">
			<input type="hidden" name="boardTypeNo" value="<%=boardListDto.getBoardTypeNo()%>">
			<div class="row">
				<textarea id="commentContent" name="commentContent" required></textarea>
			</div>
			<div class="row">
				<input type="submit" value="댓글 작성">
			</div>
		</form>
		
		<div class="row text-left">
			<h4>댓글 목록</h4>
		</div>
		<%for(BoardCommentDto commentDto : commentList) { %>
			<div class="row text-left" style="border:1px solid gray;">
				<div class="float-container">
					<div class="left"><%=commentDao.getClientName(commentDto.getClientNo()) %></div>
					
					 <%if(commentDto.getClientNo() == clientNo) { %>
						<div class="right">
							<a class="comment-edit-btn">수정</a>
							| 
							<a class="comment-delete-btn" href="commentDelete.kh?commentNo=<%=commentDto.getCommentNo()%>&boardNo=<%=boardNo%>">삭제</a>
						</div>
					<%} %>
				</div>
				<!-- 화면 표시 댓글 -->
				<div class="comment-display-area">
					<pre><%=commentDto.getCommentContent() %></pre>
				</div>
				<%if(commentDto.getClientNo() == clientNo) { %>
					<div class="comment-edit-area">
						<form action="commentEdit.kh" method="post">
							<input type="hidden" name="commentNo" value="<%=commentDto.getCommentNo()%>">
							<input type="hidden" name="boardNo" value="<%=boardNo%>">
							<textarea name="commentContent" required><%=commentDto.getCommentContent()%></textarea>
							<input type="submit" value="댓글 수정">
							<input type="button" value="작성 취소" class="comment-edit-cancel-btn">
						</form>
					</div>
				<%} %>
				<div><%=commentDto.getCommentDate().toLocaleString() %></div>
			</div>
		<%} %>
	<%} else { %>
		<!-- 대신 답변이 들어감 -->
		<div class="row float-container">
			<div class="left">
				작성자 | 
				<%if(answerDto != null) {%>
					<%=answerDto.getClientNo() %>
				<%} %>
			</div>
			<div class="right">
				답변일 | 
				<%if(answerDto != null) {%>
					<%=answerDto.getAnswerDate().toLocaleString() %>
				<%} %>
			</div>		
		</div>
		
		<div class="row text-left" style="min-height:300px;">
			<pre>
				<%if(answerDto == null) {%>
					아직 답변이 등록되지 않았습니다.
				<%} else { %>
					<%=answerDto.getAnswerContent() %>
				<%} %>
			</pre>
		</div>
	</div>
	<%} %>
	
	<div class="row text-right">
		<!-- 본인 및 관리자에게만 표시되도록 하는 것이 좋다 -->
		<%if(clientNo != 0) {%>
			<%if(boardDto.getClientNo() == clientNo) { %>
				<a href="boardEdit.jsp?boardNo=<%=boardNo%>" class="link-btn">수정</a>
			<%} %>
			<%if(isAdmin && boardDto.getBoardTypeNo() == 2 && answerDto.getBoardStatus().equals("접수중")) { %>
				<a href="boardAnswer.jsp?boardNo=<%=boardNo%>" class="link-btn">답변</a>
			<%} %>
			<%if(isAdmin || boardDto.getClientNo() == clientNo) {%>
				<a href="boardDelete.kh?boardTypeNo=<%=boardDto.getBoardTypeNo()%>&boardNo=<%=boardNo%>" class="link-btn">삭제</a>
			<%} %>
			<%if(isLike) { %>
				<span class="heart">
				<a href="boardLikeDelete.kh?boardNo=<%=boardNo%>&clientNo=<%=clientNo%>" class="link-btn">♥</a>
				</span>
			<%} else { %>
				<span class="heart">
				<a href="boardLikeInsert.kh?boardNo=<%=boardNo%>&clientNo=<%=clientNo%>" class="link-btn">♡</a>
				</span>
			<%} %>
		<%} %>
		<a href="#" onclick="chooseList()" class="link-btn">목록</a>
	</div>
	
	<div class="row text-left">
		다음글 : 
		<%if(nextBoardDto == null){%>
		다음글이 없습니다.
		<%}else{ %>
		<a href="boardDetail.jsp?boardNo=<%=nextBoardDto.getBoardNo()%>">
			<%=nextBoardDto.getBoardTitle()%>
		</a>
		<%} %>
	</div>
	<div class="row text-left">
		이전글 : 
		<%if(prevBoardDto == null){%>
		이전글이 없습니다.
		<%}else{ %>
		<a href="boardDetail.jsp?boardNo=<%=prevBoardDto.getBoardNo()%>">
			<%=prevBoardDto.getBoardTitle()%>
		</a>
		<%} %>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>