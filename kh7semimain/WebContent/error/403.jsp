<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String title = "ERROR";
%>

<jsp:include page="/template/header.jsp">
	<jsp:param value="<%=title %>" name="title" />
</jsp:include>

<div class="main">
		<div class="text-center" style="padding: 100px 0px;">
			<span style="font-size: 100px; font-weight: bold;">403 ERROR</span>
		</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
