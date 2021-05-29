<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.RoleAreaDto"%>
<%@page import="library.beans.RoleAreaDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
RoleAreaDao roleAreaDao = new RoleAreaDao();
ClientDao clientDao = new ClientDao();
List<ClientDto> adminList = clientDao.adminList();
%>

<jsp:include page="/admin/adminMenuSidebar.jsp"></jsp:include>

	<div class="row text-left">
		<h2>관리자 권한 목록</h2>
	</div>
	
	<div class="row text-right">
		<button><a href="roleInsert.jsp">권한 등록</a></button>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th width="15%">관리자 이름</th>
					<th>지점</th>
				</tr>
			</thead>
			<tbody>
				<%for(ClientDto clientDto : adminList){ %>
					<tr>
						<td>
							<%=clientDto.getClientName() %>(<%=clientDto.getClientNo() %>)
						</td>
						<td>
							<%List<RoleAreaDto> roleList = roleAreaDao.areaListByClient(clientDto.getClientNo()); %>
							
							<%for (RoleAreaDto roleAreaDto : roleList){ %>
								<%=roleAreaDto.getAreaName() %>
							<%} %>
						</td>
					</tr>
				<%} %>
			</tbody>
		</table>
	</div>


<jsp:include page="/template/footer.jsp"></jsp:include>