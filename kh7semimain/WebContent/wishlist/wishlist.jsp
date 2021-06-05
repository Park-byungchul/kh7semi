<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.WishlistDto"%>
<%@page import="library.beans.WishlistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int clientNo = (int)session.getAttribute("clientNo");
	WishlistDao wishlistDao = new WishlistDao();
	List<WishlistDto> wishList = wishlistDao.myWishList(clientNo);

	BookDao bookDao = new BookDao();
	String root = request.getContextPath();
	
	AreaDao areaDao = new AreaDao();
	int areaNo;
	try{
		areaNo = (int)session.getAttribute("areaNo");
	}
	catch (Exception e){
		areaNo = 0;
	}
	String title = "관심도서";
	if(areaNo > 0){
		title += " : " + areaDao.detail(areaNo).getAreaName();
	}
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
<jsp:include page="/client/myMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>
<!-- -->
<div class="container-1000">
	<div class="header">
		<div class="row">
			<span class="title">관심도서</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 마이페이지 > 관심도서</span>
		</div>
	</div>		
	<%if(wishList.size()==0) {%>
	<span>비어있습니다. 관심도서를 추가해보세요</span>
	<%} else { %>
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
				<%for (WishlistDto wishlistDto : wishList) { %>
					<%BookDto bookDto = bookDao.get(wishlistDto.getBookIsbn()); %>
				<tr>
					<td><%=wishlistDto.getBookIsbn()%></td>
					<td><%=bookDto.getGenreNo()%></td>
					<td><a href="<%=root%>/book/bookDetail.jsp?bookIsbn=<%=wishlistDto.getBookIsbn()%>"><%=bookDto.getBookTitle()%></a></td>
					<td><%=bookDto.getBookAuthor()%></td>
					<td><img src="<%=bookDto.getBookImg()%>"></td>
					<td class="bookList text-center">
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