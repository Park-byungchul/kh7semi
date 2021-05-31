<%@page import="library.beans.GetBookDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.GetBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
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
		
%>

<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>

<style>
	input[type="button"] {
 			width: 300px;
			height: 50px;
	}
</style>

		<div class="row text-center">
			<h2>자료 검색</h2>
		</div>
		
		<div class="row text-center">
			<input type="button"  onclick="location.href='<%=root%>/reservation/reservationInfo.jsp'" value="대출 및 예약 안내">
			<input type="button" value="자료 검색">		
		</div>
			<br><br>
			
		<!-- 	검색창 구현 -->
			<div class="row text-center">
				<form action = "searchList.jsp" method="get">
					<select name="type">
						<option value="all">전체</option>
						<option value="get_book_title">서명</option>
						<option value= "get_book_author">저자</option>
					</select>
				
				<input type="text" name="keyword" size="50" height = "20" required>
				<input type="submit" value="검색">
				</form>					
			</div> <br><br>
			
<jsp:include page="/template/footer.jsp"></jsp:include>