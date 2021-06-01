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
RoleAreaDao roleAreaDao = new RoleAreaDao();
ClientDao clientDao = new ClientDao();
List<ClientDto> adminNormalList = clientDao.adminNormalList();
AreaDao areaDao = new AreaDao();
List<AreaDto> areaList = areaDao.list();
int clientNo = (int)session.getAttribute("clientNo");
List<RoleAreaDto> roleAreaList = roleAreaDao.areaListByClient(clientNo);
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "관리자 추가";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

	<div class="row text-left">
		<h2>관리자 추가</h2>
	</div>

	<div class="row">
			<form action="roleInsert.kh?type=partial" method="post">
				<div class="row">
					<label>관리자 이름 : </label>
					<select name="clientNo" required>
						<option value="">관리자를 선택하세요</option>
						<%for(ClientDto clientDto : adminNormalList){ %>
							<option value="<%=clientDto.getClientNo() %>">[<%=clientDto.getClientNo() %>]<%=clientDto.getClientName() %>[<%=clientDto.getClientId() %>]</option>
						<%} %>
					</select>
				</div>
				<div class="row">
					<label>지점 이름 : </label>
					<select name="areaNo" required>
						<%if(areaNo == 0 && clientDao.get(clientNo).getClientType().equals("권한관리자")){ %>
							<option value="">지점을 선택하세요</option>
							<%for(RoleAreaDto roleAreaDto : roleAreaList){ %>
								<option value="<%=roleAreaDto.getAreaNo()%>">[<%=roleAreaDto.getAreaNo() %>]<%=roleAreaDto.getAreaName() %></option>
							<%} %>
						<%}else if(areaNo == 0 && clientDao.get(clientNo).getClientType().equals("전체관리자")){ %>
							<option value="">지점을 선택하세요</option>
							<%for(AreaDto areaDto : areaList){ %>
								<option value="<%=areaDto.getAreaNo()%>">[<%=areaDto.getAreaNo() %>]<%=areaDto.getAreaName() %></option>
							<%} %>
						<%}else{ %>
							<option value="<%=areaNo%>">[<%=areaDao.detail(areaNo).getAreaNo() %>]<%=areaDao.detail(areaNo).getAreaName() %></option>
						<%} %>
					</select>
				</div>
				<div class="row">
					<input type="submit" value="등록">
					</form>
				</div>
			
		</div>


<jsp:include page="/template/footer.jsp"></jsp:include>