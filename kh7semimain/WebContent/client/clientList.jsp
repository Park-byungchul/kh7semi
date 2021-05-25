<%@page import="library.beans.ClientDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	ClientDao clientDao = new ClientDao();
	List<ClientDto> list = clientDao.list();
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
			<tr>
				<td><%=clientDto.getClientNo() %></td>
				<td><%=clientDto.getClientId() %></td>
				<td><%=clientDto.getClientName() %></td>
				<td><%=clientDto.getClientEmail() %></td>
				<td><%=clientDto.getClientMade() %></td>
				<td><%=clientDto.getClientPossible() %></td>
				<td><%=clientDto.getClientType() %></td>
				<td><a href="clientEdit.jsp?clientNo=<%=clientDto.getClientNo() %>">수정</a></td>
				<td><a href="clientDelete.kh?clientNo=<%=clientDto.getClientNo() %>">삭제</a></td>
			</tr>
		<%} %>
	</table>

<jsp:include page="/template/footer.jsp"></jsp:include>