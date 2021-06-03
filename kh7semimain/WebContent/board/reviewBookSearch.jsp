<%@page import="java.util.List"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.BookDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	
<%
	request.setCharacterEncoding("UTF-8");

	String keyword = request.getParameter("keyword");
 	String root = request.getContextPath();
 
	BookDao bookDao = new BookDao();
	List<BookDto> bookList = null;

	if(keyword != null)
		bookList = bookDao.search("book_title", keyword);
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
	$(function() {
		$(".choice-btn").click(function(){
			var choiceBtn = $(this);
			
			var tr = choiceBtn.parent().parent();
			var td = tr.children();
			
			var isbn = td.eq(0).text();
			var title = td.eq(1).text();
			var author = td.eq(2).text();
			var publisher = td.eq(3).text();

			opener.document.getElementById("bookIsbn").value = isbn;
		    opener.document.getElementById("bookAuthor").value = author;
		    opener.document.getElementById("bookTitle").value = title;
		    opener.document.getElementById("bookPublisher").value = publisher;
		    window.close();
		});
	});
</script>


<body>
	<div class="row">
			<form class="bookSearchForm" name="bookSearchForm" action="reviewBookSearch.jsp" method="post" target="target">
				<p>도서명을 검색할 수 있습니다. 해당하는 도서가 없는 경우 직접 입력바랍니다.</p>
				<input type="text" name="keyword">
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
					<th>도서명</th>
					<th>저자</th>
					<th>출판사</th>
				</tr>
			</thead>
			<tbody>
				<%if(bookList != null) { %>
					<%for (BookDto bookDto : bookList) { %>
					<tr>
						<td id="searched-bookIsbn"><%=bookDto.getBookIsbn()%></td>
						<td id="searched-bookTitle"><%=bookDto.getBookTitle()%></td>
						<td id="searched-bookAuthor"><%=bookDto.getBookAuthor()%></td>
						<td id="searched-bookPublisher"><%=bookDto.getBookPublisher()%></td>
						<td>
						<button class="choice-btn">선택하기</button>
						</td>
					</tr>
					<%}%>
				<%} %>
			</tbody>
		</table>
	</div>
	

</body>
</html>