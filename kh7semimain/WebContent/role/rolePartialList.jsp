<%@page import="library.beans.RoleAreaDto"%>
<%@page import="library.beans.RoleAreaDao"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("UTF-8");
AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "지점권한 관리";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}

int clientNo = (int)session.getAttribute("clientNo");
ClientDao clientDao = new ClientDao();
ClientDto clientDto = clientDao.get(clientNo);
RoleAreaDao roleAreaDao = new RoleAreaDao();

List<RoleAreaDto> roleList = roleAreaDao.areaListByClient(clientDto.getClientNo());
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

	<div class="row">
		<h1>지점 권한 관리</h1>
	</div>
	
	<div class="row text-center"">
		<table class="table table-border">
			<tr>
				<th width="20%">
					<span>지점</span>
				</th>
				<th>
					<span>관리자</span>
				</th>
			</tr>
			<%for (RoleAreaDto roleAreaDto : roleList){ %>
				<tr>	
					<td>
					<%=roleAreaDto.getAreaName() %>
					</td>
					<td>
						ddddddd
					</td>
				</tr>
			<%} %>
		</table>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>