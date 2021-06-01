<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String root = request.getContextPath();
ClientDao clientDao = new ClientDao();
List<ClientDto> list = clientDao.list();

AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "회원관리";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

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
				<%for (ClientDto clientDto : list) { %>
				<tr>
					<td><a href=<%=root%>/client/clientInfo.jsp?clientNo=<%=clientDto.getClientNo()%>><%=clientDto.getClientId()%></a></td>
					<td><%=clientDto.getClientName()%></td>
					<td><%=clientDto.getClientEmail()%></td>
					<td><%=clientDto.getClientPossible()%></td>
					<td><%=clientDto.getClientType()%></td>
					<td>
					<%if(clientDto.getClientType().equals("일반관리자") || clientDto.getClientType().equals("일반사용자")){ %>
						<button><a href="clientPartialEdit.jsp?clientNo=<%=clientDto.getClientNo()%>">수정</a></button>
						<button class="clientDelete"><a href="clientDelete.kh?clientNo=<%=clientDto.getClientNo()%>">삭제</a></button>
					<%} %>
					</td>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>