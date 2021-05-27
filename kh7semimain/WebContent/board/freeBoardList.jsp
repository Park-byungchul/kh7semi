<%@page import="library.beans.BoardListDto"%>
<%@page import="library.beans.BoardListDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	BoardListDao boardListDao = new BoardListDao();
	List<BoardListDto> boardList = boardListDao.list(3);
	
	Integer clientNo = (Integer)session.getAttribute("clientNo");
	boolean isLogin = (clientNo != null);
	
	int p;
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto;
	
	if(clientNo == null)
		clientDto = null;
	else
		clientDto = clientDao.get(clientNo);

	try {
		p = Integer.parseInt(request.getParameter("p"));
	}
	catch (Exception e) {
		p = 1;
	}
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-1000">
	<div class="row text-left">
		<h2>자유게시판</h2>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
					<th>좋아요</th>
				</tr>
			</thead>
			
			<tbody>
				<%for(BoardListDto boardListDto : boardList) { %>
				<tr>
					<td><%=boardListDto.getBoardSepNo() %></td>
					<td align=left>
						<a href="boardDetail.jsp?boardNo=<%=boardListDto.getBoardNo()%>">
							<%=boardListDto.getBoardTitle() %>
						</a>
					</td>
					<td><%=boardListDto.getClientName() %></td>
					<td><%=boardListDto.getBoardDate() %></td>
					<td><%=boardListDto.getBoardRead() %></td>
					<td><%=boardListDto.getBoardLike() %></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>

	<%if(isLogin) { %>
		<div class="row text-right">
			<a href="boardWrite.jsp?boardTypeNo=3" class="link-btn">글쓰기</a>
		</div>
	<%} %>
	
	<div class="row">
		<ol class="pagination-list">
		<li><a href="#">&lt;이전</a></li>
		
		<%for(int i = 1; i <= 10; i++) { %>
			<%if(p == i) { %>
				<li class="on"><a href="#"><%=i%></a></li>
			<%} else {%>
				<li><a href="#"><%=i%></a></li>
			<%} %>
		<%} %>

		<li><a href="#">다음&gt;</a></li>
		</ol>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>