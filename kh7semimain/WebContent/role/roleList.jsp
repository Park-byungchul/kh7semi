<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.RoleAreaDto"%>
<%@page import="library.beans.RoleAreaDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String root = request.getContextPath();
request.setCharacterEncoding("UTF-8");
RoleAreaDao roleAreaDao = new RoleAreaDao();
ClientDao clientDao = new ClientDao();
List<ClientDto> adminList = clientDao.adminPermmisionList();

AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "권한관리";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

	<div class="row text-left">
		<h2>권한관리자 목록</h2>
	</div>
	
	<div class="row text-right">
		<button><a href="roleInsert.jsp">권한 등록</a></button>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th width="20%">관리자</th>
					<th>지점</th>
				</tr>
			</thead>
			<tbody>
				<%for(ClientDto clientDto : adminList){ %>
					<tr>
						<td>
							<a href="<%=root%>/client/clientInfo.jsp?clientNo=<%=clientDto.getClientNo()%>">[<%=clientDto.getClientNo() %>]<%=clientDto.getClientName() %>[<%=clientDto.getClientId() %>]</a>
						</td>
						<td>
							<%List<RoleAreaDto> roleList = roleAreaDao.areaListByClient(clientDto.getClientNo()); %>
							
							<%for (RoleAreaDto roleAreaDto : roleList){ %>
								<a href="roleDetail.jsp?roleClientNo=<%=roleAreaDto.getClientNo()%>&roleAreaNo=<%=roleAreaDto.getAreaNo()%>">[<%=roleAreaDto.getAreaNo() %>]<%=roleAreaDto.getAreaName() %></a>
							<%} %>
						</td>
					</tr>
				<%} %>
			</tbody>
		</table>
	</div>


<jsp:include page="/template/footer.jsp"></jsp:include>