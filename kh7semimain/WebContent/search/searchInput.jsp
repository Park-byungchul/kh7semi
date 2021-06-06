<%@page import="java.util.List"%>
<%@page import="library.beans.GetBookDto"%>
<%@page import="library.beans.GetBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();

	//목록을 구하는 서버단 코드(Java)
	//= pageNo : 현재 화면의 페이지 번호
	//= type : 검색 수행시의 분류
	//= keyword : 검색 수행시의 검색어
	
	//목록을 구하는 서버단 코드(Java)
	/* request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
		
	
 	GetBookDao getBookDao = new GetBookDao();
 		List<GetBookDto> getBookList;
 		//select값이 기본 -> '전체' 값을 null로 주고 keyword만 전송
 		if(type == null){
 			getBookList = getBookDao.searchList(keyword);
 		}
 		else{ //select가 '전체'가 아니면 type과 keyword 같이 전송
 			getBookList = getBookDao.searchList(type, keyword);
 		} */
	request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("type"); //검색 정보
	String keyword = request.getParameter("keyword"); //검색 정보
	
	String title = "통합 자료 검색";
%>

<jsp:include page="/search/searchSidebar.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>

<style>
	input[type="button"] {
 			width: 300px;
			height: 50px;
	}
</style>

	<div class="main">
		<div class="header">
			<div class="row">
				<span class="title">통합 자료 검색</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 자료 검색 > 통합 자료 검색</span>
			</div>
		</div>
		
		<div class="row text-center">
			<input type="button" class="board-btn" onclick="location.href='<%=root%>/reservation/reservationInfo.jsp'" value="대출 및 예약 안내">
			<input type="button" class="board-btn" value="자료 검색">		
		</div>
			<br><br>
			
			<div class="row text-center">
				<form class="search-form-back text-center" action = "searchList.jsp" method="get">
					<select name="type" class="select-form">
						<option value="all">전체</option>
						<option value="book_title">서명</option>
						<option value= "book_author">저자</option>
					</select>
				
				<input type="text" class="text-search-form" name="keyword" size="50"required>
				<input type="submit" class="form-btn form-btn-inline" value="검색">
				</form>					
			</div> <br><br>
		</div>
			
<jsp:include page="/template/footer.jsp"></jsp:include>