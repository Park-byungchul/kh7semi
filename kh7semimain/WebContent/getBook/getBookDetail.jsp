<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.GetBookSearchDto"%>
<%@page import="library.beans.GetBookSearchDao"%>
<%@page import="library.beans.RecommendDto"%>
<%@page import="library.beans.RecommendDao"%>
<%@page import="library.beans.WishlistDto"%>
<%@page import="library.beans.WishlistDao"%>
<%@page import="library.beans.ReservationDao"%>
<%@page import=  "java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
	int getBookNo = Integer.parseInt(request.getParameter("getBookNo"));
	GetBookSearchDao getBookSearchDao = new GetBookSearchDao();
	GetBookSearchDto getBookSearchDto = getBookSearchDao.get(getBookNo);
	
	RecommendDao recommendDao = new RecommendDao();
	RecommendDto recommendDto = new RecommendDto();

	WishlistDao wishlistDao = new WishlistDao();
	WishlistDto wishlistDto = new WishlistDto();
	
	ReservationDao reservationDao = new ReservationDao();
	
	
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
	
	
	boolean isRecommend = recommendDao.check(recommendDto);
	boolean isWishlist = wishlistDao.check(wishlistDto);
	int checkReservated = reservationDao.check(getBookNo);
	AreaDao areaDao = new AreaDao();
	int areaNo;
	try{
		areaNo = (int)session.getAttribute("areaNo");
	}
	catch (Exception e){
		areaNo = 0;
	}
	String title = "자료 검색";
	if(areaNo > 0){
		title += " : " + areaDao.detail(areaNo).getAreaName();
	}

%>
<jsp:include page="/search/searchSidebar.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>
	<div class="main">
		<div class="header">
			<div class="row">
				<span class="title">도서 정보</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 자료 검색 > 통합 자료 검색</span>
			</div>
		</div>
	<div class="container-800">
		
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
				<%if(isLogin && checkReservated != -1 && checkReservated != clientNo) { %>
							<div class="row">
								<span style="color:orange">다른사람이 예약중인 도서입니다.</span>
							</div>
						<%} else if (isLogin){ %>
							<div class="row bookList">
							<%if (clientNo == checkReservated) {%>
								<button class="form-btn form-btn-inline"><a class="link-btn"  href="<%=root%>/reservation/reservationDelete.kh?clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">예약취소</a></button>
							<%} else { %>
									<button class="form-btn form-btn-inline"><a class="link-btn"  href="<%=root%>/reservation/reservationInsert.kh?clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">도서예약</a></button>
							<%} %>
						<%} else { %>
							<div class="row bookList">
						<% } %>
						<%if(isLogin && isRecommend) {%>
						<button class="form-btn form-btn-inline"><a class="link-btn" href="<%=root%>/recommend/recommendDelete.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">추천취소</a></button>
						<%} else if(isLogin && !isRecommend){%>
						<button class="form-btn form-btn-inline"><a class="link-btn" href="<%=root%>/recommend/recommendInsert.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">추천하기</a></button>
						<%}%>
						
						<%if(isLogin && isWishlist) { %>
						<button class="form-btn form-btn-inline"><a class="link-btn"  href="<%=root%>/wishlist/wishlistDelete.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">관심도서 해제</a></button>
						<%} else if(isLogin && !isWishlist) { %>
						<button class="form-btn form-btn-inline"><a class="link-btn"  href="<%=root%>/wishlist/wishlistInsert.kh?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>&clientNo=<%=clientNo%>&getBookNo=<%=getBookNo%>">관심도서 담기</a></button>
						<%} %>
						</td>
				</div>
				<div class="text-center">
						<input type="button" value="목록으로" onClick="history.go(-1)" class="form-btn form-btn-inline">
				</div>
				
		</div>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>