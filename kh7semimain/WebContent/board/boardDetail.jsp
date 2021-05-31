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
		if(tmp.getClientType().equals("관리")) {
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
		var boardTypeNo = <%=boardListDto.getBoardTypeNo()%>
		
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
	
	<div class="row text-right">
		<!-- 본인 및 관리자에게만 표시되도록 하는 것이 좋다 -->
		<%if(clientNo != 0) {%>
			<%if(boardDto.getClientNo() == clientNo) { %>
				<a href="boardEdit.jsp?boardNo=<%=boardNo%>" class="link-btn">수정</a>
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
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>