<%@page import="library.beans.GenreDto"%>
<%@page import="library.beans.GenreDao"%>
<%@page import="library.beans.WishlistDto"%>
<%@page import="library.beans.WishlistDao"%>
<%@page import="library.beans.RecommendDto"%>
<%@page import="library.beans.RecommendDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String root = request.getContextPath(); 
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

WishlistDao wishlistDao = new WishlistDao();
WishlistDto wishlistDto = new WishlistDto();

boolean isLogin = session.getAttribute("clientNo") != null;



int p;

try {
	p = Integer.parseInt(request.getParameter("p"));
}
catch (Exception e) {
	p = 1;
}

// 페이징 -------------------------------------------------------
int pageNo;
try{
	pageNo = Integer.parseInt(request.getParameter("pageNo"));
	if(pageNo < 1) {
		throw new Exception();
	}
}
catch(Exception e){
	pageNo = 1;
}

int pageSize;
try{
	pageSize = Integer.parseInt(request.getParameter("pageSize"));
	if(pageSize < 10){
		throw new Exception();
	}
}
catch(Exception e){
	pageSize = 10;
}

int startRow = pageNo * pageSize - (pageSize-1);
int endRow = pageNo * pageSize;

int count  = bookDao.getCount();
int blockSize = 10;
int lastBlock = (count + pageSize - 1) / pageSize;
int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
int endBlock = startBlock + blockSize - 1;

if(endBlock > lastBlock){
	endBlock = lastBlock;
}
//페이징 -------------------------------------------------------
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="<%=root%>/pagination/pagination.js"></script>
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
		
		$(".booklist-wishlistBtn-neg").click(function(){
			window.alert("관심도서가 해제되었습니다.")
		});
		$(".booklist-wishlistBtn-pos").click(function(){
			window.alert("관심도서 목록에 추가되었습니다.")
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
	<div class="row text-right">
		<a href="bookInsert.jsp">책 등록하기</a>
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
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
				<%for (BookDto bookDto : list) { 
					recommendDto.setClientNo(clientNo);
					recommendDto.setBookIsbn(bookDto.getBookIsbn());
					
					wishlistDto.setClientNo(clientNo);
					wishlistDto.setBookIsbn(bookDto.getBookIsbn());
					
					boolean isRecommend = recommendDao.check(recommendDto);
					boolean isWishlist = wishlistDao.check(wishlistDto);
					
					GenreDao genreDao = new GenreDao();
					GenreDto genreDto = genreDao.get(bookDto.getGenreNo());
				%>
				<tr>
					<td><%=bookDto.getBookIsbn()%></td>
					<td><%=genreDto.getGenreName()%></td>
					<td><%=bookDto.getBookTitle()%></td>
					<td><%=bookDto.getBookAuthor()%></td>
					<td><img src="<%=bookDto.getBookImg() %>"></td>
					<td class="bookList">
					<button><a href="bookEdit.jsp?bookIsbn=<%=bookDto.getBookIsbn()%>">수정</a></button>
					<button><a class="bookDelete" href="bookDelete.kh?bookIsbn=<%=bookDto.getBookIsbn()%>">삭제</a></button>
					<button><a href="bookDetail.jsp?bookIsbn=<%=bookDto.getBookIsbn()%>">상세보기</a></button>
					<%if(isLogin && isRecommend) {%>
					<button class="booklist-btn"><a href="bookRecommendDelete.kh?bookIsbn=<%=bookDto.getBookIsbn()%>&clientNo=<%=clientNo%>">추천취소</a></button>
					<%} else if(isLogin && !isRecommend){%>
					<button class="booklist-btn"><a href="bookRecommendInsert.kh?bookIsbn=<%=bookDto.getBookIsbn()%>&clientNo=<%=clientNo%>">추천하기</a></button>
					<%}%>
					
					<%if(isLogin && isWishlist) { %>
					<button class="booklist-wishlistBtn-neg"><a href="bookWishlistDelete.kh?bookIsbn=<%=bookDto.getBookIsbn()%>&clientNo=<%=clientNo%>">관심도서 해제</a></button>
					<%} else if(isLogin && !isWishlist) { %>
					<button class="booklist-wishlistBtn-pos"><a href="bookWishlistInsert.kh?bookIsbn=<%=bookDto.getBookIsbn()%>&clientNo=<%=clientNo%>">관심도서 담기</a></button>
					<%} %>	
					</td>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>

	<div class="row text-center">
		<div class="pagination">
			<%if(startBlock > 1) { %>
				<a class="move-link">이전</a>
			<%} %>
			<%for(int i = startBlock; i <= endBlock; i++) {%>
				<%if(i == pageNo) {%>
					<a class="on"><%=i %></a>
				<%} else { %>
					<a><%=i %></a>
				<%} %>
			<%} %>
	 		<%if(endBlock < lastBlock) { %>
				<a class="move-link">다음</a>
			<%} %>
		</div>
	</div>
	<form class="search-form" action="bookList.jsp" method="get">
		<input type="hidden" name="pageNo">
	</form>

	<div class="row text-right">
		<a href="bookInsert.jsp">책 등록하기</a>
	</div>

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>