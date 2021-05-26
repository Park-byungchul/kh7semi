<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<h2>도서관에 도서 추가</h2>

	<form action="insert.kh" method="post">
		<label>ISBN : </label><input type="text" name="bookIsbn" required><br><br>
		<label>지점번호 : </label><input type="text" name="areaNo" required><br><br>
		<label>입고일자 : </label><input type="text" name="getBookDate" required><br><br>
		<label>상태 : </label><input type="text" name="getBookStatus" required><br><br>
		<input type="submit" value="도서 추가">
	</form>

<jsp:include page="/template/footer.jsp"></jsp:include>