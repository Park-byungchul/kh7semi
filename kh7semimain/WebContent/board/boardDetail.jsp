<%@page import="library.beans.board.BoardAnswerDto"%>
<%@page import="library.beans.board.BoardAnswerDao"%>
<%@page import="library.beans.board.BoardCommentDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.board.BoardCommentDao"%>
<%@page import="library.beans.board.BoardLikeDto"%>
<%@page import="library.beans.board.BoardLikeDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="library.beans.board.BoardListDto"%>
<%@page import="library.beans.board.BoardListDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.board.BoardDao"%>
<%@page import="library.beans.board.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	
	String root = request.getContextPath();

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
	
	System.out.println(boardNo);

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

<jsp:include page="/board/boardMenuSidebar.jsp"></jsp:include>

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
	
	// 댓글 높이 자동 설정
	function resize(obj) {
  		obj.style.height = "1px";
  		obj.style.height = (12+obj.scrollHeight)+"px";
	}
</script>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">공지사항</span>
		</div>
				
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 열린 공간 > 공지사항</span>
		</div>
	</div>
	
	<div class="row">
		<table class="table table-border table-hover">
			<tbody>
				<%if(boardDto.getBoardTypeNo() == 1 || boardDto.getBoardTypeNo() == 2) {%>
					<tr>
						<th>도서관</th>
						<td>
							<%if(boardDto.getAreaNo() != 0){ %>
								<%=areaDto.getAreaName() %>
							<%} else if(boardDto.getBoardTypeNo() == 1 || boardDto.getBoardTypeNo() == 2) { %>
								전체
							<%} %>
						</td>
					</tr>
				<%} %>
				<tr>
					<th>제목</th>
					<td><%=boardDto.getBoardTitle()%></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><%=clientDto.getClientName()%></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td><%=boardDto.getBoardDate().toLocaleString()%></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td><%=boardDto.getBoardRead()%></td>
				</tr>
				<tr>
					<th>추천</th>
					<td><%=boardDto.getBoardLike()%></td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="row text-left">
							<pre><%=boardDto.getBoardField()%></pre>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="row text-right">
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
	
	<ul class="comment-area">
		<%if(boardDto.getBoardTypeNo() != 2) { %>
			<!-- 댓글 목록 출력 -->
			<%for(BoardCommentDto commentDto : commentList) { %>
				<li class="row text-left comment-list">
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
				</li>
			<%} %>
			
			<!-- 댓글 작성 -->
			<form action="commentInsert.kh" method="post">
				<input type="hidden" name="boardNo" value="<%=boardNo%>">
				<input type="hidden" name="boardTypeNo" value="<%=boardListDto.getBoardTypeNo()%>">
				<div class="row">
					<textarea maxlength="300" cols="146" onkeydown="resize(this)" onkeyup="resize(this)" class="comment-textarea" id="commentContent" name="commentContent" required></textarea>
				</div>
				<div class="row">
					<input type="submit" value="댓글 작성">
				</div>
			</form>
		<%} else { %>
			<!-- 대신 답변이 들어감 -->
			<li class="row float-container">
				<div class="left">
					작성자 | 
					<%if(answerDto.getClientNo() != 0) {%>
						<%=answerDao.getClientName(answerDto.getClientNo()) %>
					<%} %>
				</div>
				<div class="right">
					답변일 | 
					<%if(answerDto.getAnswerDate() != null) {%>
						<%=answerDto.getAnswerDate().toLocaleString() %>
					<%} %>
				</div>		
			</li>
			
			<li class="row text-left" style="min-height:300px;">
				<pre>
					<%=answerDto.getAnswerContent() %>
				</pre>
			</li>
		<%} %>
	</ul>
	
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