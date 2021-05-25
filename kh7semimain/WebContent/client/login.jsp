<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<form action="login.kh" method="post">
		<label>ID : </label><input type="text" name="clientId"><br><br>
		<label>PW : </label><input type="password" name="clientPw"><br><br>
		<input type="submit" value="로그인">
	</form>

<jsp:include page="/template/footer.jsp"></jsp:include>