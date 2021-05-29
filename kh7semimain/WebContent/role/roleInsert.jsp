<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
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
AreaDao areaDao = new AreaDao();
List<AreaDto> areaList = areaDao.list();
%>

<jsp:include page="/admin/adminMenuSidebar.jsp"></jsp:include>

	<div class="row text-left">
		<h2>권한 등록</h2>
	</div>

	<div class="row">
			<form action="roleInsert.kh" method="post">
				<div class="row">
					<label>관리자 이름 : </label>
					<select name="clientNo" required>
						<%for(ClientDto clientDto : adminList){ %>
							<option value="<%=clientDto.getClientNo() %>"><%=clientDto.getClientName() %></option>
						<%} %>
					</select>
				</div>
				<div class="row">
					<label>지점 이름 : </label>
					<select name="areaNo" required>
						<%for(AreaDto areaDto : areaList){ %>
							<option value="<%=areaDto.getAreaNo()%>"><%=areaDto.getAreaName() %></option>
						<%} %>
					</select>
				</div>
				<div class="row">
					<input type="submit" value="등록">
				</div>
			</form>
		</div>


<jsp:include page="/template/footer.jsp"></jsp:include>