<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int clientNo = (int)session.getAttribute("clientNo");
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(clientNo);
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

	<h2>마이페이지</h2>
	<ul>
		<li><a href="<%=request.getContextPath() %>/client/clientDetail.jsp">회원 정보</a></li>
		<li><a href="#">대출/예약/신청 도서 관리</a></li>
		<li><a href="#">관심도서</a></li>
	</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>

	<div class="row text-left">
		<h2>회원 정보</h2>
	</div>
	
	<div class="row">
		<table class="table table-border">
			<tr>
				<th>
					<label>이름</label>
				</th>
				<td>
				<span><%=clientDto.getClientName()%></span>
					<%if(clientDto.getClientType().equals("관리")){ %>
						<span>(관리자)</span>
					<%} %>
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
					<label>대출가능일</label>
				</th>
				<td>
					<span><%=clientDto.getClientPossible()%></span>
				</td>
			</tr>
		</table>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>