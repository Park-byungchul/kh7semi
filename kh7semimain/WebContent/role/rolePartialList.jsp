<%@page import="library.beans.RoleDao"%>
<%@page import="library.beans.AreaDto"%>
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

String title = "일반관리자 목록";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}

int clientNo = (int)session.getAttribute("clientNo");
ClientDao clientDao = new ClientDao();
ClientDto clientDto = clientDao.get(clientNo);
RoleAreaDao roleAreaDao = new RoleAreaDao();

List<AreaDto> areaList;
if(clientDto.getClientType().equals("전체관리자")){
	areaList = areaDao.list();
}
else{
	areaList = areaDao.list(clientNo);
}

RoleDao roleDao = new RoleDao();
boolean isAdmin = roleDao.isAdmin(clientNo, areaNo);

List<ClientDto> adminNormalList = clientDao.adminNormalList();
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

	<div class="row">
		<h1>일반관리자 목록 
		<%if(areaNo > 0){ %>
		(<%=areaDao.detail(areaNo).getAreaName() %>)
		<%} %>
		</h1>
	</div>
	
	<div class="row text-right">
		<button><a href="rolePartialInsert.jsp">관리자 추가</a></button>
	</div>
	
	<div class="row text-center"">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th width="20%">
						<span>지점</span>
					</th>
					<th>
						<span>관리자</span>
					</th>
				</tr>
			</thead>
			</tbody>
				<%if(areaNo == 0){ %>
				<%for (AreaDto areaDto : areaList){ %>
					<tr>	
						<td>
							<%=areaDto.getAreaName() %>
						</td>
						<td>
						<%for(ClientDto adminNormalDto : adminNormalList){ %>
							<%if(roleDao.isAdmin(adminNormalDto.getClientNo(), areaDto.getAreaNo())){ %>
								<a href="rolePartialDetail.jsp?rolePartialClientNo=<%=adminNormalDto.getClientNo()%>&rolePartialAreaNo=<%=areaDto.getAreaNo()%>"><%=adminNormalDto.getClientName() %></a>
							<%} %>
						<%} %>
						</td>
					</tr>
				<%} %>
				<%} else if(isAdmin || clientDto.getClientType().equals("전체관리자")){%>
					<tr>	
						<td>
							<%=areaDao.detail(areaNo).getAreaName() %>
						</td>
						<td>
							<%for(ClientDto adminNormalDto : adminNormalList){ %>
							<%if(roleDao.isAdmin(adminNormalDto.getClientNo(), areaNo)){ %>
								<a href="rolePartialDetail.jsp"><%=adminNormalDto.getClientName() %></a>
							<%} %>
						<%} %>
						</td>
					</tr>
				<%}else{ %>
					<tr>
						<td colspan="2"><span>해당 지점에 대한 관리자 권한이 없습니다</span></td>
					</tr>
				<%} %>
			</tbody>
		</table>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>