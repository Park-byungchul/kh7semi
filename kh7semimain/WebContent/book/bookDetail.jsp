<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.BookDetailDto"%>
<%@page import="library.beans.BookDetailDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String bookIsbn = request.getParameter("bookIsbn");
	BookDetailDao bookDetailDao = new BookDetailDao();
	BookDetailDto bookDetailDto = bookDetailDao.get(bookIsbn);

%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="container-800">
		<div class="row text-left">
			<h2>상세 정보</h2>
		</div>
		
		<div class="row">
				<div class="row">
					<label>ISBN : <%=bookDetailDto.getBookIsbn() %></label>
				</div>
				<div class="row">
					<label>장르 번호 : <%=bookDetailDto.getGenreNo()%></label>
				</div>
				<div class="row">
					<label>장르 : <%=bookDetailDto.getGenreName()%></label>
				</div>
				<div class="row">
					<label>제목 : <%=bookDetailDto.getBookTitle()%></label>
				</div>
				<div class="row">
					<label>저자 : <%=bookDetailDto.getBookAuthor()%></label>		
				</div>
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>