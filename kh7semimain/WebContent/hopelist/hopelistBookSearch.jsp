<%@page import="java.util.List"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.BookDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

	
<%
	request.setCharacterEncoding("UTF-8");
 	String keyword = request.getParameter("keyword");
 	String type = request.getParameter("type");
 
	String root = request.getContextPath();
	
	BookDao bookDao = new BookDao();

	boolean isSearch = type != null && keyword != null && !keyword.trim().equals("");
	
	List<BookDto> bookList;
	if(!isSearch){
		bookList = bookDao.list();
	}
	else if(type.equals("all")){
		bookList = bookDao.search(keyword);
	}
	else {
		bookList = bookDao.search(type, keyword);
	}
 %>
 
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<title>도서 검색</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
//this 를 사용하기위해 독립모듈방식으로 변경하였음.
$(function(){
	$(".choice-btn").click(function(){
		var choiceBtn = $(this);
		
		var tr = choiceBtn.parent().parent();
		var td = tr.children();
		
		
		var isbn = td.eq(0).text();
		var genre = td.eq(1).text();
		var title = td.eq(2).text();
		var author = td.eq(3).text();
			
	    opener.document.getElementById("bookAuthor").value = author;
	    opener.document.getElementById("bookTitle").value = title;
	    opener.document.getElementById("bookIsbn").value = isbn;
	    opener.document.getElementById("genreNo").value = genre;
	    window.close();
	});
	
	$(".choice-type").val("<%=type%>").attr("selected", "selected");
});




	
</script>
<style>

</style>
<body>
	<div class="container-600">
	
	</div>
	<div class="row">
			<form class="bookSearchForm" name="bookSearchForm" action="hopelistBookSearch.jsp" method="post" target="target">
				<select name="type" class="choice-type">
					<option value="all" selected>전체</option>
					<option value="book_title">제목</option>
					<option value="book_author">저자</option>
				</select>
				<input type="text" name="keyword" value=<%=keyword %>>
				<input type="submit" value="검색" class="bookSearch-btn">
			</form>
	</div>
	<hr>	
	
	<div class="row text-left">
		<h2>책 목록</h2>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>ISBN</th>
					<th>장르</th>
					<th>도서명</th>
					<th>저자</th>
					<th>썸네일</th>
				</tr>
			</thead>
			<tbody>
				<%for (BookDto bookDto : bookList) { %>
				<tr>
					<td Id="searched-bookIsbn"><%=bookDto.getBookIsbn()%></td>
					<td Id="searched-genreNo"><%=bookDto.getGenreNo()%></td>
					<td Id="searched-bookTitle"><%=bookDto.getBookTitle()%></td>
					<td Id="searched-bookAuthor"><%=bookDto.getBookAuthor()%></td>
					<td Id="searched-bookImg"><img src="<%=bookDto.getBookImg() %>"></td>
					<td>
					<button class="choice-btn">선택하기</button>
					</td>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>
	

</body>
</html>