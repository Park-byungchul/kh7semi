<%@page import="library.beans.GetBookSearchDto"%>
<%@page import="library.beans.GetBookSearchDao"%>
<%@page import="library.beans.RecommendDto"%>
<%@page import="library.beans.RecommendDao"%>
<%@page import="library.beans.WishlistDto"%>
<%@page import="library.beans.WishlistDao"%>
<%@page import="library.beans.ReservationDto"%>
<%@page import="library.beans.ReservationDao"%>
<%@page import=  "java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
	int getBookNo = Integer.parseInt(request.getParameter("getBookNo"));
	GetBookSearchDao getBookSearchDao = new GetBookSearchDao();
	GetBookSearchDto getBookSearchDto = getBookSearchDao.get(getBookNo);
	
	RecommendDao recommendDao = new RecommendDao();
	RecommendDto recommendDto = new RecommendDto();

	WishlistDao wishlistDao = new WishlistDao();
	WishlistDto wishlistDto = new WishlistDto();
	
	ReservationDao reservationDao = new ReservationDao();
	ReservationDto reservationDto = new ReservationDto();
	
	
	boolean isLogin = session.getAttribute("clientNo") != null;
	int clientNo;
	try {
		clientNo = (int)session.getAttribute("clientNo");
		
	}
	catch (Exception e){
		clientNo = 0;
	}
	recommendDto.setClientNo(clientNo);
	recommendDto.setBookIsbn(getBookSearchDto.getBookIsbn());
	
	wishlistDto.setClientNo(clientNo);
	wishlistDto.setBookIsbn(getBookSearchDto.getBookIsbn());
	
	reservationDto.setClientNo(clientNo);
	reservationDto.setGetBookNo(getBookNo);
	
	boolean isRecommend = recommendDao.check(recommendDto);
	boolean isWishlist = wishlistDao.check(wishlistDto);
	boolean isReservated = reservationDao.check(reservationDto);
%>

<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>	

	<div class="container-800">
		<div class="row text-left">
			<h2>도서 정보</h2>
		</div>
		
		<div class="row">
			
				<div class="row">
					<span><img src="<%=getBookSearchDto.getBookImg() %>"></span>
				</div>
				<div class="row">
					<label>도서명 : </label><span><%=getBookSearchDto.getBookTitle() %></span>
				</div>
				<div class="row">
					<label>ISBN : </label><span><%=getBookSearchDto.getBookIsbn() %></span>
				</div>
				<div class="row">
					<label>저자 : </label><span><%=getBookSearchDto.getBookAuthor() %></span>
				</div>
				<div class="row">
					<label>출판사 : </label><span><%=getBookSearchDto.getBookPublisher() %></span>
				</div>
				<div class="row">
					<label>입고번호 : </label><span><%=getBookSearchDto.getGetBookNo() %></span>
				</div>
				<div class="row">
					<label>입고지점 : </label><span><%=getBookSearchDto.getAreaName() %></span>
				</div>
				<div class="row">
					<label>입고일자 : </label><span><%=getBookSearchDto.getGetBookDate() %></span>
				</div>
				<div class="row">
					<label>상태 : </label><span><%=getBookSearchDto.getGetBookStatus()%></span>
				</div>
				<div class="row bookList">
						<%if(isLogin && isRecommend) {%>
						<button class="booklist-btn"><a href="<%=root%>/recommend/recommendDelete.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">추천취소</a></button>
						<%} else if(isLogin && !isRecommend){%>
						<button class="booklist-btn"><a href="<%=root%>/recommend/recommendInsert.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">추천하기</a></button>
						<%}%>
						
						<%if(isLogin && isWishlist) { %>
						<button class="booklist-wishlistBtn-neg"><a href="<%=root%>/wishlist/wishlistDelete.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">관심도서 해제</a></button>
						<%} else if(isLogin && !isWishlist) { %>
						<button class="booklist-wishlistBtn-pos"><a href="<%=root%>/wishlist/wishlistInsert.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">관심도서 담기</a></button>
						<%} %>
						
<%-- 						<%if(isLogin && isReservated) { %> --%>
<%-- 						<button class="booklist-wishlistBtn-neg"><a href="<%=root%>/reservation/reservationDelete.kh?clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">도서예약</a></button> --%>
<%-- 						<%} else if(isLogin && !isReservated) { %> --%>
<%-- 						<button class="booklist-wishlistBtn-pos"><a href="<%=root%>/reservation/reservationInsert.kh?clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">예약취소</a></button> --%>
<%-- 						<%} %> --%>
						</td>
				</div>
				<div class="text-center">
						<input type="button" value="목록으로" onClick="history.go(-1)">
				</div>
				
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>