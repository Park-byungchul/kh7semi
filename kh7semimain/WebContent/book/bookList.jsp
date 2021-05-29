<%@page import="library.beans.RecommendDto"%>
<%@page import="library.beans.RecommendDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
BookDao bookDao = new BookDao();
List<BookDto> list = bookDao.list();
int clientNo;
try {
	clientNo = (int)session.getAttribute("clientNo");
	
}
catch (Exception e){
	clientNo = 0;
}


RecommendDao recommendDao = new RecommendDao();
RecommendDto recommendDto = new RecommendDto();

boolean isLogin = session.getAttribute("clientNo") != null;


int p;

try {
	p = Integer.parseInt(request.getParameter("p"));
}
catch (Exception e) {
	p = 1;
}
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	$(function(){
		$(".bookDelete").click(function(){
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if (choice) {
				return true;
			} else {
				return false;
			}
		});
		
		$(".bookRecommend").click(function(){
			
		});
	});
</script>
<style>
.bookList>button>a{
	text-decoration: none;
}
</style>
<div class="container-1000">
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
					<td><%=bookDto.getBookIsbn()%></td>
					<td><%=bookDto.getGenreNo()%></td>
					<td><%=bookDto.getBookTitle()%></td>
					<td><%=bookDto.getBookAuthor()%></td>
					<td class="bookList">
					<button><a href="bookEdit.jsp?bookIsbn=<%=bookDto.getBookIsbn()%>">수정</a></button>
					<button class="bookDelete"><a href="bookDelete.kh?bookIsbn=<%=bookDto.getBookIsbn()%>">삭제</a></button>
					<%
						recommendDto.setClientNo(clientNo);
						recommendDto.setBookIsbn(bookDto.getBookIsbn());
						boolean isRecommend = recommendDao.check(recommendDto);
						
						if(isLogin && isRecommend) {
					%>
					<button class="bookRecommend"><a href="bookRecommendDelete.kh?bookIsbn=<%=bookDto.getBookIsbn()%>&clientNo=<%=clientNo%>">추천취소</a></button>
					<%} else if(isLogin && !isRecommend){%>
					<button class="bookRecommend"><a href="bookRecommendInsert.kh?bookIsbn=<%=bookDto.getBookIsbn()%>&clientNo=<%=clientNo%>">추천하기</a></button>
					<%}%>
					</td>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>

	<div class="row">
		<ol class="pagination-list">
		<li><a href="#">&lt;이전</a></li>
		
		<%for(int i = 1; i <= 10; i++) { %>
			<%if(p == i) { %>
				<li class="on"><a href="#"><%=i%></a></li>
			<%} else {%>
				<li><a href="#"><%=i%></a></li>
			<%} %>
		<%} %>

		<li><a href="#">다음&gt;</a></li>
		</ol>
	</div>

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>