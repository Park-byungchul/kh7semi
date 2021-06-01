<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	long bookIsbn = Long.parseLong(request.getParameter("bookIsbn"));
	BookDao bookDao = new BookDao();
	BookDto bookDto = bookDao.get(bookIsbn);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="container-800">
		<div class="row text-left">
			<h2>상세 정보</h2>
		</div>
		
		<div class="row">
				<div class="row">
					<label>ISBN : </label><span><%=bookDto.getBookIsbn() %></span>
				</div>
				<div class="row">
					<label>장르 번호 : </label><input type="text" name="genreNo" value="<%=bookDto.getGenreNo()%>">
				</div>
				<div class="row">
					<label>제목 : </label><input type="text" name="bookTitle" value="<%=bookDto.getBookTitle()%>">
				</div>
				<div class="row">
					<label>저자 : </label><input type="text" name="bookAuthor" value="<%=bookDto.getBookAuthor()%>">		
				</div>
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>