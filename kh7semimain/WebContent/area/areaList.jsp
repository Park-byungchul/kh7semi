<%@page import="library.beans.RoleAreaDto"%>
<%@page import="library.beans.RoleAreaDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
AreaDao areaDao = new AreaDao();
List<AreaDto> list = areaDao.list();
%>

<jsp:include page="/admin/adminMenuSidebar.jsp"></jsp:include>

	<div class="row text-left">
		<h2>지점 목록</h2>
	</div>

	<div class="row text-right">
		<button><a href="areaInsert.jsp">지점 등록</a></button>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>지점명</th>
					<th>지점 전화번호</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (AreaDto areaDto : list) {
				%>
				<tr>
					<td>[<%=areaDto.getAreaNo()%>]<a href="areaDetail.jsp?areaNo=<%=areaDto.getAreaNo()%>"><%=areaDto.getAreaName()%></a></td>
					<td><%=areaDto.getAreaCall() %></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>