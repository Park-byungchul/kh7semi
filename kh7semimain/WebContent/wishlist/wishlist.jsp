<%@page import="library.beans.GenreDto"%>
<%@page import="library.beans.GenreDao"%>
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
	GenreDao genreDao = new GenreDao();
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
		$(".form-btn.form-btn-inline").click(function(){
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
<div class="main">
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
		
				<%for (WishlistDto wishlistDto : wishList) { %>
					<%
					BookDto bookDto = bookDao.get(wishlistDto.getBookIsbn());
					GenreDto genreDto = genreDao.get(bookDto.getGenreNo());
					%>
				<div style="position:relative;padding:17px 20px;overflow:hidden;height:200px;margin-left:10px;">
						<div class="img" style="position:absolute;top:30px;left:0px;">
							<img src="<%=bookDto.getBookImg()%>">
						</div>
							<div class="row" style="margin-left:120px;font-size:13px">
										<a href="<%=root%>/wishlist/wishlistDetail.jsp?bookIsbn=<%=wishlistDto.getBookIsbn()%>&wishlistNo=<%=wishlistDto.getWishlistNo()%>" style="font-size:16px;font-weight: bold;padding:5px 0px;color:black"><%=bookDto.getBookTitle()%></a><br>
										<span>저자 : <%=bookDto.getBookAuthor()%></span><br>
										<span>장르명 : <%=genreDto.getGenreName()%></span><br>
										<span>ISBN : <%=wishlistDto.getBookIsbn()%></span><br>
										<span>발행 : <%=bookDto.getBookDate()%></span>
							</div>
					</div>
					<hr class="notice-hr hr-plus">
<%-- 					<td><%=wishlistDto.getBookIsbn()%></td> --%>
<%-- 					<td><%=bookDto.getGenreNo()%></td> --%>
<%-- 					<td><a href="<%=root%>/book/bookDetail.jsp?bookIsbn=<%=wishlistDto.getBookIsbn()%>" style="font-size:16px;font-weight: bold;padding:5px 0px;color:black"><%=bookDto.getBookTitle()%></a> --%>
<%-- 					<td><%=bookDto.getBookAuthor()%></td> --%>
<%-- 					<td><img src="<%=bookDto.getBookImg()%>"></td> --%>
				
				<%}%>
			
	</div>
	<%} %>
</div>
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>