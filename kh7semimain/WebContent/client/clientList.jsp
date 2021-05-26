<%@page import="library.beans.ClientDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ClientDao clientDao = new ClientDao();
List<ClientDto> list = clientDao.list();

int p;

try {
	p = Integer.parseInt(request.getParameter("p"));
}
catch (Exception e) {
	p = 1;
}

%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	// 목표 : 삭제버튼을 누르면 확인창 출력 후 확인을 누르면 전송
	$(function(){
		$(".clientDelete").click(function(){
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if (choice) {
				return true;
			} else {
				return false;
			}
		});
	});
</script>

<div class="container-1000">
	<div class="row text-left">
		<h2>회원 목록</h2>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>생성일</th>
					<th>대출가능일</th>
					<th>등급</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<%for (ClientDto clientDto : list) { %>
				<tr>
					<td><%=clientDto.getClientNo()%></td>
					<td><%=clientDto.getClientId()%></td>
					<td><%=clientDto.getClientName()%></td>
					<td><%=clientDto.getClientEmail()%></td>
					<td><%=clientDto.getClientMade()%></td>
					<td><%=clientDto.getClientPossible()%></td>
					<td><%=clientDto.getClientType()%></td>
					<td>
					<button><a href="clientEdit.jsp?clientNo=<%=clientDto.getClientNo()%>">수정</a></button>
					<button class="clientDelete"><a href="clientDelete.kh?clientNo=<%=clientDto.getClientNo()%>">삭제</a></button>
					</td>
				</tr>
				<%}%>
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