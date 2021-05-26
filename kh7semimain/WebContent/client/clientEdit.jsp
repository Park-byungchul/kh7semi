<%@page import="library.beans.ClientDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	ClientDao clientDao = new ClientDao();
	List<ClientDto> list = clientDao.list();
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<table>
		<tr>
			<th>회원번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>생성일</th>
			<th>대출가능일</th>
			<th>등급</th>
		</tr>
		<%for(ClientDto clientDto : list){ %>
		<%boolean isEdit = clientNo == clientDto.getClientNo(); %>
			<tr>
				<td><%=clientDto.getClientNo() %></td>
				<td><%=clientDto.getClientId() %></td>
				<%if(isEdit){ %>
					<form action="clientEdit.kh" method="post">
						<input type="hidden" name="clientNo"
						value="<%=clientDto.getClientNo() %>">
						<td><input type="text" name="clientName" required
						value="<%=clientDto.getClientName() %>"></td>
						<td><input type="text" name="clientEmail" required
						value="<%=clientDto.getClientEmail() %>"></td>
				<%}else{ %>
					<td><%=clientDto.getClientName() %></td>
					<td><%=clientDto.getClientEmail() %></td>
				<%} %>
				<td><%=clientDto.getClientMade() %></td>
				<%if(isEdit){ %>
						<td><input type="date" name="clientPossible" required
						value="<%=clientDto.getClientPossible() %>"></td>
						<td><select name="clientType">
							<option>일반</option>
							<option>관리</option>
						</select></td>
						<td><input type="submit" value="수정하기"></td>
						<td><a href="clientList.jsp">취소</a></td>
					</form>	
				<%}else{ %>
					<td><%=clientDto.getClientPossible() %></td>
					<td><%=clientDto.getClientType() %></td>
					<td><a href="clientEdit.jsp?clientNo=<%=clientDto.getClientNo() %>">수정</a></td>
					<td><a href="clientDelete.kh?clientNo=<%=clientDto.getClientNo() %>">삭제</a></td>
				<%} %>
			</tr>
		<%} %>
	</table>

<jsp:include page="/template/footer.jsp"></jsp:include>