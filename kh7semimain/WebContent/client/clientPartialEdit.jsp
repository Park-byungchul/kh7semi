<%@page import="library.beans.ClientDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String root = request.getContextPath();
ClientDao clientDao = new ClientDao();
List<ClientDto> list = clientDao.list();
int clientNo = Integer.parseInt(request.getParameter("clientNo"));
String currentType = clientDao.get(clientNo).getClientType();
%>

<jsp:include page="/admin/adminMenuSidebar.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	// 목표 : 삭제버튼을 누르면 확인창 출력 후 확인을 누르면 전송
	$(function(){
		$("#clientType").val("<%=currentType%>");
		var currentType = $("#clientType").val();
		
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

	<div class="row text-left">
		<h2>회원 목록</h2>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th width="15%">아이디</th>
					<th width="20%">이름</th>
					<th width="20%">이메일</th>
					<th width="20%">대출가능일</th>
					<th width="12%">등급</th>
					<th width="13%">관리</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (ClientDto clientDto : list) {
				%>
				<%
				boolean isEdit = clientNo == clientDto.getClientNo();
				%>
				<tr>
					<td><span><%=clientDto.getClientId()%></span></td>
					<td><span><%=clientDto.getClientName()%></span></td>
					<td><span><%=clientDto.getClientEmail() %></span></td>
					<td><span><%=clientDto.getClientPossible() %></span></td>
					<%
					if (isEdit) {
					%>
					<form action="clientEdit.kh?type=partial" method="post">
						<input type="hidden" name="clientNo"
							value="<%=clientDto.getClientNo()%>">
						<input type="hidden" name="clientName" 
							value="<%=clientDto.getClientName()%>">
						<input type="hidden" name="clientEmail" 
							value="<%=clientDto.getClientEmail()%>">
						<input type="hidden" name="clientPossible"
							value="<%=clientDto.getClientPossible()%>">
						<td><select id="clientType" name="clientType">
								<option>일반사용자</option>
								<option>일반관리자</option>
						</select></td>
						<td><input type="submit" value="완료">
						<button><a
							href="clientPartialList.jsp">취소</a></button></td>
					</form>
					<%
					} else {
					%>
						<td><%=clientDto.getClientType()%></td>
						<td>
						<%if(clientDto.getClientType().equals("일반관리자") || clientDto.getClientType().equals("일반사용자")){ %>
						<button><a href="clientPartialEdit.jsp?clientNo=<%=clientDto.getClientNo()%>">수정</a></button>
						<button class="clientDelete"><a href="clientDelete.kh?clientNo=<%=clientDto.getClientNo()%>">삭제</a></button>
						<%} %>
						</td>
					<%
					}
					%>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>