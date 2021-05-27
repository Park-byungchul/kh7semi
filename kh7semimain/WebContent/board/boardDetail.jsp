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
	Integer clientNo = (Integer)session.getAttribute("clientNo");

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	BoardDao boardDao = new BoardDao();
	BoardDto boardDto = boardDao.find(boardNo);
	
	BoardListDao boardListDao = new BoardListDao();
	BoardListDto boardListDto = boardListDao.find(boardNo);
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(boardDto.getClientNo());
	
	boolean isAdmin = false;
	if(clientNo != null) {
		ClientDto tmp = clientDao.get(clientNo);
		if(tmp.getClientType().equals("관리")) {
			isAdmin = true;
		}
	}

	AreaDao areaDao = new AreaDao();
	AreaDto areaDto;
	if(boardDto.getAreaNo() != 0) {
		areaDto = areaDao.detail(boardDto.getAreaNo());
	}
	else {
		areaDto = null;
	}
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
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
		<%if(clientNo != null) {%>
			<%if(isAdmin || (boardDto.getBoardTypeNo() != 1 && boardDto.getClientNo() == clientNo)) {%>
				<a href="boardEdit.jsp?boardNo=<%=boardNo%>" class="link-btn">수정</a>
				<a href="boardDelete.kh?boardNo=<%=boardNo%>" class="link-btn">삭제</a>
			<%} %>
		<%} %>
		<a href="#" onclick="chooseList()" class="link-btn">목록</a>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>