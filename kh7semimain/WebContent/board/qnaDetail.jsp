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

	//이전글 정보 불러오기
	BoardDto prevBoardDto = boardDao.getPrevious(boardListDto.getBoardTypeNo(), boardListDto.getBoardSepNo());
	
	//다음글 정보 불러오기
	BoardDto nextBoardDto = boardDao.getNext(boardListDto.getBoardTypeNo(), boardListDto.getBoardSepNo());

	// 답글 출력
	BoardAnswerDao answerDao = new BoardAnswerDao();
	BoardAnswerDto answerDto = answerDao.get(boardNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-800">
	<div class="row text-left">
		<h1><%=boardListDto.getBoardTypeName() %></h1>
	</div>
	
	<div class="row text-left">
		<h3>
			<%if(boardDto.getAreaNo() != 0){ %>
				[<%=areaDto.getAreaName() %>]
			<%} else { %>
				[전체도서관]
			<%} %>
			<%=boardDto.getBoardTitle()%>
		</h3>
	</div>
	
	<div class="row float-container">
		<div class="left">
			<%=clientDto.getClientName()%>
		</div>
		<div class="right">
			<%=boardDto.getBoardDate().toLocaleString()%>
		</div>
	</div>
	
	<div class="row text-left" style="min-height:300px;">
		<pre><%=boardDto.getBoardField()%></pre>
	</div>

	<div class="row float-container">
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
		
		<div class="row text-left" style="min-height:300px;">
			<pre>
				<%=answerDto.getAnswerContent() %>
			</pre>
		</div>
	</div>
	
	<div class="row text-right">
		<%if(clientNo != 0) {%>
			<%if(isAdmin && boardDto.getBoardTypeNo() == 2 && answerDto.getBoardStatus().equals("접수중")) { %>
				<a href="boardAnswer.jsp?boardNo=<%=boardNo%>" class="link-btn">답변</a>
			<%} %>
			<%if(boardDto.getClientNo() == clientNo && answerDto.getBoardStatus().equals("접수중")) { %>
				<a href="boardEdit.jsp?boardNo=<%=boardNo%>" class="link-btn">수정</a>
			<%} %>
			<%if(isAdmin) {%>
				<a href="boardDelete.kh?boardTypeNo=<%=boardDto.getBoardTypeNo()%>&boardNo=<%=boardNo%>" class="link-btn">삭제</a>
			<%} %>                                                                                      
		<%} %>
		<a href="qnaList.jsp" class="link-btn">목록</a>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>