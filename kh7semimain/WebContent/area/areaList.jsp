<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	AreaDao areaDao = new AreaDao();
	List<AreaDto> list = areaDao.list();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<table>
		<tr>
			<th>지점번호</th>
			<th>지점명</th>
			<th>지점위치</th>
			<th>전화번호</th>
		</tr>
		<%for(AreaDto areaDto : list){ %>
			<tr>
				<td><%=areaDto.getAreaNo() %></td>
				<td><%=areaDto.getAreaName() %></td>
				<td><%=areaDto.getAreaLocation() %></td>
				<td><%=areaDto.getAreaCall() %></td>
				<td><a href="areaEdit.jsp?areaNo=<%=areaDto.getAreaNo() %>">수정</a></td>
				<td><a href="areaDelete.kh?areaNo=<%=areaDto.getAreaNo() %>">삭제</a></td>
			</tr>
		<%} %>
	</table>

<jsp:include page="/template/footer.jsp"></jsp:include>