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
		<span>500 오류(내부적 오류)</span>
	</div>
	<div>
		<a href="<%=root %>/index.jsp">홈으로</a>
	</div>
</body>
</html>