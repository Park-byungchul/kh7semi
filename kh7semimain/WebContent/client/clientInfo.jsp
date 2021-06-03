<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(clientNo);
	
	String title = "회원 정보";
%>
<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<div class="row text-left">
		<h2>회원 정보</h2>
	</div>
	
	<div class="row">
		<table class="table table-border">
			<tr>
				<th>
					<label>회원번호</label>
				</th>
				<td>
				<span><%=clientDto.getClientNo()%></span>
				</td>
			</tr>
			
			<tr>	
				<th>
					<label>아이디</label>
				</th>
				<td>
					<span><%=clientDto.getClientId()%></span>
				</td>
			</tr>
			
			<tr>
				<th>
					<label>이름</label>
				</th>
				<td>
				<span><%=clientDto.getClientName()%></span>
				</td>
			</tr>
			
			<tr>
				<th>
					<label>휴대폰번호</label>
				</th>
				<td>
					<span><%=clientDto.getClientPhone()%></span>
				</td>
			</tr>
				
			<tr>
				<th>
					<label>이메일</label>
				</th>
				<td>
					<span><%=clientDto.getClientEmail()%></span>
				</td>
			</tr>
			
			<tr>
				<th>
					<label>생성일</label>
				</th>
				<td>
					<span><%=clientDto.getClientMade()%></span>
				</td>
			</tr>
			
			<tr>
				<th>
					<label>대출가능일</label>
				</th>
				<td>
					<span><%=clientDto.getClientPossible()%></span>
				</td>
			</tr>
			
			<tr>
				<th>
					<label>등급</label>
				</th>
				<td>
					<span><%=clientDto.getClientType()%></span>
				</td>
			</tr>
		</table>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>