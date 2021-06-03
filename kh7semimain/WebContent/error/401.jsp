<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
</head>
<body>
	<div>
		<span>401 오류(로그인 먼저)</span>
	</div>
	<div>
		<a href="<%=root %>/index.jsp">홈으로</a>
	</div>
</body>
</html>
