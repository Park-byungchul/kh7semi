<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
	<h2>회원가입</h2>

		<form action="insert.kh" method="post">
			<label>ISBN : </label><input type="text" name="bookIsbn" required><br><br>
			<label>장르 번호 : </label><input type="text" name="genreNo" required><br><br>
			<label>제목 : </label><input type="text" name="bookName" required><br><br>
			<label>저자 : </label><input type="text" name="bookAuthor" required><br><br>
			<input type="submit" value="추가">
		</form>
<jsp:include page="/template/footer.jsp"></jsp:include>