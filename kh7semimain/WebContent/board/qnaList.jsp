<%@page import="library.beans.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	BoardDao boardDao = new BoardDao();
	List<BoardDto> boardList = boardDao.list();
	
	int p;

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
		<h2>질문 답변</h2>
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
				<%for(BoardDto boardDto : boardList) { %>
				<tr>
					<td><%=boardDto.getBoardNo() %></td>
					<td><%=boardDto.getAreaNo() %></td>
					<td align=left>
						<a href="boardDetail.jsp?boardNo=<%=boardDto.getBoardNo()%>">
						<%=boardDto.getBoardTitle() %>
						</a>
					</td>
					<td><%=boardDto.getClientNo() %></td>
					<td><%=boardDto.getBoardDate() %></td>
					<td><%=boardDto.getBoardRead() %></td>
					<td><%=boardDto.getBoardLike() %></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	
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