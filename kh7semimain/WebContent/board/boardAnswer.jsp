<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));

	Integer clientNo = (Integer)session.getAttribute("clientNo");

	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(clientNo);
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<h1>답변쓰기</h1>

<div class="container-800">
	<form action="boardAnswer.kh" method="post">
		<input type="hidden" name="boardNo" value="<%=boardNo%>">
		<table>
			<tbody>
				<tr>
					<th class="text-left" style="background-color:lightgray;">작성자</th>
					<td>
						<p><%=clientDto.getClientName()%></p>
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">내용</th>
					<td>
						<textarea name="answerContent" rows="15" class="text-right form-input"></textarea>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="row">
			<button class="link-btn">등록</button>
		</div>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>