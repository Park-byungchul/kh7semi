<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<form action="insert.kh" method="post">
		<label>ID : </label><input type="text" name="clientId" required>
		<label>PW : </label><input type="password" name="clientPw" required>
		<label>NICKNAME : </label><input type="text" name="clientName" required>
		<label>Email : </label><input type="text" name="clientEmail" required>
		<input type="submit" value="등록">
	</form>

<jsp:include page="/template/footer.jsp"></jsp:include>