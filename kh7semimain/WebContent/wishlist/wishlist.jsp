<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.WishlistDto"%>
<%@page import="library.beans.WishlistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<%
	int clientNo = (int)session.getAttribute("clientNo");
	WishlistDao wishlistDao = new WishlistDao();
	List<WishlistDto> wishList = wishlistDao.myWishList(clientNo);

	BookDao bookDao = new BookDao();
	String root = request.getContextPath();
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		$(".wishlistDelete").click(function(){
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if (choice) {
				return true;
			} else {
				return false;
			}
		});
	});
</script>
<!-- -->
<div class="container-1000">
	<h2>내 관심 도서 목록</h2>
	<%if(wishList.size()==0) {%>
	<span>비어있습니다. db테이블에 데이터를 추가하거나 bookdetail에서 관심도서등록 진행해주세요</span>
	<%} else { %>
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
				<%for (WishlistDto wishlistDto : wishList) { %>
					<%BookDto bookDto = bookDao.get(wishlistDto.getBookIsbn()); %>
				<tr>
					<td><%=wishlistDto.getBookIsbn()%></td>
					<td><%=bookDto.getGenreNo()%></td>
					<td><a href="<%=root%>/book/bookDetail.jsp?bookIsbn=<%=wishlistDto.getBookIsbn()%>"><%=bookDto.getBookTitle()%></a></td>
					<td><%=bookDto.getBookAuthor()%></td>
					<td class="bookList">
					<button class="wishlistDelete"><a href="wishlistDelete.kh?bookIsbn=<%=wishlistDto.getBookIsbn()%>&clientNo=<%=clientNo%>">삭제</a></button>
					</td>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>
	<%} %>
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>