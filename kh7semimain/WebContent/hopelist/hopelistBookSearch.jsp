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
	List<BookDto> list = bookDao.list();
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
});

// function setParentText(obj){
	
// 	var choiceBtn = $(obj);
// 	var tr = choiceBtn.parent().parent();
// 	var td = tr.children();
	
	
// 	var isbn = td.eq(0).text();
// 	var genre = td.eq(1).text();
// 	var title = td.eq(2).text();
// 	var author = td.eq(3).text();
		
//     opener.document.getElementById("bookAuthor").value = author;
//     opener.document.getElementById("bookTitle").value = title;
//     opener.document.getElementById("bookIsbn").value = isbn;
//     opener.document.getElementById("genreNo").value = genre;
//     window.close();
// }




	
</script>
<style>

</style>
<body>
	<div class="container-600">
	<input type="text" value=<%=keyword %>>
	<input type="text" value=<%=type%>>
	<hr>
	</div>
	
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
				</tr>
			</thead>
			<tbody>
				<%for (BookDto bookDto : list) { %>
				<tr>
					<td Id="searched-bookIsbn"><%=bookDto.getBookIsbn()%></td>
					<td Id="searched-genreNo"><%=bookDto.getGenreNo()%></td>
					<td Id="searched-bookTitle"><%=bookDto.getBookTitle()%></td>
					<td Id="searched-bookAuthor"><%=bookDto.getBookAuthor()%></td>
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