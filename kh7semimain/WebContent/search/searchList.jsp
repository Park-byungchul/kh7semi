<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.GetBookDto"%>
<%@page import="library.beans.GenreDto"%>
<%@page import="library.beans.GenreDao"%>
<%@page import="library.beans.RecommendDto"%>
<%@page import="library.beans.RecommendDao"%>
<%@page import="library.beans.WishlistDto"%>
<%@page import="library.beans.WishlistDao"%>
<%@page import="library.beans.GetBookSearchDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.GetBookSearchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();

	request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
		
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
	
	BookDao bookDao = new BookDao();
	BookDto bookDto = new BookDto();

	boolean isLogin = session.getAttribute("clientNo") != null;
	
 	GetBookSearchDao getBookSearchDao = new GetBookSearchDao();
 		List<GetBookSearchDto> getBookList;
 		//select값이 기본 -> '전체' 값을 null로 주고 keyword만 전송
 		if(type == null && keyword == null) {
 			getBookList = getBookSearchDao.list();
 		}
 		else if(type.equals("all") || type.equals(null)){
 			getBookList = getBookSearchDao.searchList(keyword);
 		}
 		else{ //select가 '전체'가 아니면 type과 keyword 같이 전송
 			getBookList = getBookSearchDao.searchList(type, keyword);
 		}
%>

<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>	
		<div class="row text-center">
			<h2>자료 검색</h2>
		</div>
		
		<div class="row text-center">
				<form action = "searchList.jsp" method="get">
					<select name="type">
						<option value="all">전체</option>
						<option value="book_title">서명</option>
						<option value= "book_author">저자</option>
					</select>
				
				<input type="text" name="keyword" size="50" height = "20" required>
				<input type="submit" value="검색">
				</form>					
			</div> <br><br>
		
		<div class="row text-center">
			<table border = "1" width="800" class="row text-center">
				<thead>
					<tr>
						<th>썸네일</th>
						<th width="10%">책번호</th>
						<th width="10%">지점명</th>
						<th width="20%">책제목</th>
						<th width="20%">저자</th>						
						<th>상태</th>
						<th>기능</th>
					</tr>
				</thead>
				<tbody>
					<%for(GetBookSearchDto getBookSearchDto : getBookList) {
							recommendDto.setClientNo(clientNo);
							recommendDto.setBookIsbn(getBookSearchDto.getBookIsbn());
							
							wishlistDto.setClientNo(clientNo);
							wishlistDto.setBookIsbn(getBookSearchDto.getBookIsbn());
							
							boolean isRecommend = recommendDao.check(recommendDto);
							boolean isWishlist = wishlistDao.check(wishlistDto);
							
							bookDto = bookDao.get(getBookSearchDto.getBookIsbn());
							
							
						
					%>
					<tr>
						<td><img src="<%=bookDto.getBookImg() %>"></td>
						<td><%=getBookSearchDto.getBookIsbn() %></td>
						<td><%=getBookSearchDto.getAreaName() %></td>					
						<td> <a href = "<%=root%>/getBook/getBookDetail.jsp?getBookNo=<%=getBookSearchDto.getGetBookNo()%>"><%=getBookSearchDto.getBookTitle()%></a></td>
						<td><%=getBookSearchDto.getBookAuthor() %></td>
						<td><%=getBookSearchDto.getGetBookStatus() %></td>
						<td class="bookList">
						<%if(isLogin && isRecommend) {%>
						<button class="booklist-btn"><a href="<%=root%>/recommend/recommendDelete.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>">추천취소</a></button>
						<%} else if(isLogin && !isRecommend){%>
						<button class="booklist-btn"><a href="<%=root%>/recommend/recommendInsert.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>">추천하기</a></button>
						<%}%>
						
						<%if(isLogin && isWishlist) { %>
						<button class="booklist-wishlistBtn-neg"><a href="<%=root%>/wishlist/wishlistDelete.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>">관심도서 해제</a></button>
						<%} else if(isLogin && !isWishlist) { %>
						<button class="booklist-wishlistBtn-pos"><a href="<%=root%>/wishlist/wishlistInsert.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>">관심도서 담기</a></button>
						<%} %>
						
						</td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>	

<jsp:include page="/template/footer.jsp"></jsp:include>