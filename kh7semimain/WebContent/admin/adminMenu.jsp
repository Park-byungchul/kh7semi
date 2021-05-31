<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.RoleAreaDto"%>
<%@page import="library.beans.RoleAreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
int clientNo = (int)session.getAttribute("clientNo");
ClientDao clientDao = new ClientDao();
ClientDto clientDto = clientDao.get(clientNo);
RoleAreaDao roleAreaDao = new RoleAreaDao();

AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "관리자 메뉴";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

	<div class="row text-center">
		<h1><%=clientDto.getClientType() %>입니다.</h1>
	</div>
	
	<%if(clientDto.getClientType().equals("권한관리자")){ %>
	<div class="row text-center">
		<%List<RoleAreaDto> roleList = roleAreaDao.areaListByClient(clientDto.getClientNo()); %>
		<h4>		
		<%for (RoleAreaDto roleAreaDto : roleList){ %>
			<%=roleAreaDto.getAreaName() %><br>
		<%} %>
		위의 지점에 대해 권한을 부여할 수 있습니다.</h4>
	</div>
	<%} %>

<jsp:include page="/template/footer.jsp"></jsp:include>