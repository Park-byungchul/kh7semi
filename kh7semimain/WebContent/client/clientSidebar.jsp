<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<h3>로그인/회원가입</h3>
<ul>
	<li><a href="<%=root %>/client/login.jsp">로그인</a></li>
	<li><a href="<%=root %>/client/clientInsert.jsp">회원가입</a></li>
</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>