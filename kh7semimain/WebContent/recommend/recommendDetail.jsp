<%@page import="library.beans.GenreDto"%>
<%@page import="library.beans.GenreDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.AreaDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String bookIsbn = request.getParameter("bookIsbn");
	BookDao bookDao = new BookDao();
	BookDto bookDto = bookDao.get(bookIsbn);

	String title = "추천 도서";
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
</script>
<jsp:include page="/search/searchSidebar.jsp"></jsp:include>

<div class="container-600">
	<div class="row text-center">
		<h2>추천 도서 상세 정보</h2>
			<img id="thumnail" style="width:240px;height:348px;"src="<%=bookDto.getBookImg()%>">
		</div>		
		<div class="row text-left">
			<label>ISBN</label><input type="text" name="bookIsbn" id="bookIsbn" class="form-input form-input-underline" required value="<%=bookDto.getBookIsbn()%>" disabled><br><br>
			<label>장르 번호 </label><input type="text" name="genreNo"  required class="form-input form-input-underline" value="<%=bookDto.getGenreNo()%>" disabled><br><br>
			<label>제목 </label><input type="text" name="bookTitle" id="bookTitle" required class="form-input form-input-underline" value="<%=bookDto.getBookTitle()%>" disabled><br><br>
			<label>저자</label><input type="text" name="bookAuthor" id="bookAuthor" required class="form-input form-input-underline" value="<%=bookDto.getBookAuthor()%>" disabled><br><br>
			<label>출판사</label><input type="text" name="bookPublisher" id="bookPublisher" required class="form-input form-input-underline" value="<%=bookDto.getBookPublisher()%>" disabled><br><br>
			<label>출판 날짜</label><input type="text" name="bookDate" id="bookDate" required class="form-input form-input-underline" value="<%=bookDto.getBookDate()%>" disabled><br><br>
			<label>도서 소개</label><br><br><textarea name="bookContent" cols="95" rows="6" style="resize:none;border:0 ;'" id="bookContent"  disabled><%=bookDto.getBookContent()%></textarea><br><br>
			<label>이미지 URL</label><input type="text" name="bookImg" id="bookImg" required class="form-input form-input-underline" value="<%=bookDto.getBookImg()%>" disabled><br><br>
	</div>
	<div class="row text-right">
			<button><a href="recommendList.jsp">목록</a></button>
	</div>
		
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>