<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="insert.kh" method="post">
		<input type="text" name="clientId" required>
		<input type="password" name="clientPw" required>
		<input type="text" name="clientName" required>
		<input type="text" name="clientEmail" required>
		<input type="text" name="clientType" required>
		<input type="submit" value="등록">
	</form>
</body>
</html>