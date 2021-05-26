<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<h2>회원가입</h2>

	<form action="insert.kh" method="post">
		<label>ID : </label><input type="text" name="clientId" required><br><br>
		<label>PW : </label><input type="password" name="clientPw" required><br><br>
		<label>NAME : </label><input type="text" name="clientName" required><br><br>
		<label>Email : </label><input type="text" name="clientEmail" required><br><br>
		<label>Phone : </label><input type="text" name="clientPhone" required><br><br>
		<input type="submit" value="가입하기">
	</form>

<jsp:include page="/template/footer.jsp"></jsp:include>