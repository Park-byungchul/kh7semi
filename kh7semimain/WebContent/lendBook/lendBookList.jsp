<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="library.beans.LendBookDto"%>
<%@page import="library.beans.LendBookDao"%>
<%@page import="java.util.List"%>
<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>	
<%
	String root = request.getContextPath();

	request.setCharacterEncoding("UTF-8");
	String clientNo = request.getParameter("clientNo");
	String getBookNo = request.getParameter("getBookNo");
	
	
%>

<jsp:include page="/template/footer.jsp"></jsp:include>