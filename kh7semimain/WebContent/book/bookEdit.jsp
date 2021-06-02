<%@page import="library.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
BookDao bookDao = new BookDao();
List<BookDto> list = bookDao.list();
String bookIsbn = request.getParameter("bookIsbn");

int p;

try {
	p = Integer.parseInt(request.getParameter("p"));
} catch (Exception e) {
	p = 1;
}
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	// 목표 : 삭제버튼을 누르면 확인창 출력 후 확인을 누르면 전송
	$(function() {
		$(".bookDelete").click(function() {
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if (choice) {
				return true;
			} else {
				return false;
			}
		});
	});
</script>

<div class="container-1000">
	<div class="row text-left">
		<h2>회원 목록</h2>
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
				<%
				for (BookDto bookDto : list) {
					boolean isEdit = bookIsbn == bookDto.getBookIsbn();
				%>
				<tr>
					<td><%=bookDto.getBookIsbn()%></td>
					<%
					if (isEdit) {
					%>
					<form action="bookEdit.kh" method="post">
						<input type="hidden" name="bookIsbn"
							value="<%=bookDto.getBookIsbn()%>">
						<td><input type="text" name="genreNo" required
							value="<%=bookDto.getGenreNo()%>"></td>
						<td><input type="text" name="bookTitle" required
							value="<%=bookDto.getBookTitle()%>"></td>
						<td><input type="text" name="bookAuthor" required
							value="<%=bookDto.getBookAuthor()%>"></td>
						<td><input type="submit" value="완료">
							<button>
								<a href="bookList.jsp">취소</a>
							</button></td>
					</form>
					<%
					} else {
					%>
						<td><%=bookDto.getGenreNo()%></td>
						<td><%=bookDto.getBookTitle()%></td>
						<td><%=bookDto.getBookAuthor()%></td>
						<td><button>
							<a href="bookEdit.jsp?bookIsbn=<%=bookDto.getBookIsbn()%>">수정</a>
						</button>
						<button class="bookDelete">
							<a href="bookDelete.kh?bookIsbn=<%=bookDto.getBookIsbn()%>">삭제</a>
						</button>
					<%
					}
					%>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<div class="row">
		<ol class="pagination-list">
			<li><a href="#">&lt;이전</a></li>

			<%
			for (int i = 1; i <= 10; i++) {
			%>
			<%
			if (p == i) {
			%>
			<li class="on"><a href="#"><%=i%></a></li>
			<%
			} else {
			%>
			<li><a href="#"><%=i%></a></li>
			<%
			}
			%>
			<%
			}
			%>

			<li><a href="#">다음&gt;</a></li>
		</ol>
	</div>

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>