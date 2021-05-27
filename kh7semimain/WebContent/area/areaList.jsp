<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
AreaDao areaDao = new AreaDao();
List<AreaDto> list = areaDao.list();

int p;

try {
	p = Integer.parseInt(request.getParameter("p"));
} catch (Exception e) {
	p = 1;
}
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

	<h2>관리자 메뉴</h2>
	<ul>
		<li><a href="<%=request.getContextPath() %>/client/clientList.jsp">회원목록</a></li>
		<li><a href="<%=request.getContextPath() %>/area/areaList.jsp">지점목록</a></li>
	</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>

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
					<th>지점번호</th>
					<th>지점명</th>
					<th>지점위치</th>
					<th>전화번호</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (AreaDto areaDto : list) {
				%>
				<tr>
					<td><%=areaDto.getAreaNo()%></td>
					<td><a href="areaDetail.jsp?areaNo=<%=areaDto.getAreaNo()%>"><%=areaDto.getAreaName()%></a></td>
					<td><%=areaDto.getAreaLocation()%></td>
					<td><%=areaDto.getAreaCall()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	
	<div class="row text-center">
		<ol class="pagination-list">
		<li><a href="#">&lt;이전</a></li>
		
		<%for(int i = 1; i <= 10; i++) { %>
			<%if(p == i) { %>
				<li class="on"><a href="#"><%=i%></a></li>
			<%} else {%>
				<li><a href="#"><%=i%></a></li>
			<%} %>
		<%} %>

		<li><a href="#">다음&gt;</a></li>
		</ol>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>