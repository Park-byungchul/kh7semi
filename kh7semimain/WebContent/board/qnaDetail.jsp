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

<jsp:include page="/board/boardMenuSidebar.jsp"></jsp:include>

<script>
	$(function(){
		$(".board-delete-btn").click(function(e) {
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if(!choice){
				e.preventDefault();
			}
		});
	});
</script>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title"><%=boardListDto.getBoardTypeName() %></span>
		</div>
				
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 열린 공간 > <%=boardListDto.getBoardTypeName() %></span>
		</div>
	</div>
	
	<div class="row">
		<table class="table table-border table-hover board-table">
			<tbody>
				<tr>
					<th>제목</th>
					<td colspan="5"><%=boardDto.getBoardTitle()%></td>
				</tr>
				<tr>
					<th>도서관</th>
					<td>
						<%if(boardDto.getAreaNo() != 0){ %>
							<%=areaDto.getAreaName() %>
						<%} else { %>
							전체
						<%} %>
					</td>
					<th>작성자</th>
					<td><%=clientDto.getClientName()%></td>
					<th>작성일</th>
					<td><%=boardDto.getBoardDate()%></td>
				</tr>
				<tr>
					<td colspan="6">
						<div class="row text-left">
							<pre><%=boardDto.getBoardField()%></pre>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="row">
		<table class="table table-border table-hover board-table">
			<tbody>
				<tr>
					<th>작성자</th>
					<td>
						<%if(answerDto.getClientNo() != 0) {%>
							<%=answerDao.getClientName(answerDto.getClientNo()) %>
						<%} %>
					</td>
					<th>답변일</th>
					<td>
						<%if(answerDto.getAnswerDate() != null) {%>
							<%=answerDto.getAnswerDate() %>
						<%} %>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<div class="row text-left">
							<pre><%=answerDto.getAnswerContent()%></pre>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
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
				<a href="boardDelete.kh?boardTypeNo=<%=boardDto.getBoardTypeNo()%>&boardNo=<%=boardNo%>" class="link-btn board-delete-btn">삭제</a>
			<%} %>                                                                                      
		<%} %>
		<a href="qnaList.jsp" class="link-btn">목록</a>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>