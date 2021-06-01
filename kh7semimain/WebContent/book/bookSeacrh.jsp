<%@page import="library.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
	//계산
	//= type과 keyword가 둘 다 있으면 검색 , 아니면 목록
	//목록 : type == null || keyword == null
	//검색 : type != null && keyword != null
	
	BookDao bookDao = new BookDao();
	//List<ProductDto> productList = 목록 또는 검색결과;
	List<BookDto> bookList;
	if(type == null || keyword == null){//목록
		bookList = bookDao.list();
	}
	else if(type == "all"){
		bookList = bookDao.search(keyword);
	}
	else{
		bookList = bookDao.search(type, keyword);
	}
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<section>
			<div class= "float-container">
				<aside class="multi-container">
				
				</aside>
				<div class="multi-container" style="width:80%;">
			<div>
				<input type="button"  onclick="location.href='<%=root%>/reservation/reservationInfo.jsp'" value="대출 및 예약 안내">
				<input type="button" value="자료 검색">
			</div>
				<br><br>
			
			<!-- 	검색창 구현 -->
				<div>
					<form action = "bookList.jsp" method="get">
						<select name="type">
 						<option value="all">전체</option>
 						<option value="book_title">서명</option>
 						<option value= "book_author">저자</option>
 					</select>
					
					<input type="text" name="keyword" size="50" height = "20" required>
					<input type="submit" value="검색">
					</form>					
				</div> <br><br>
				
			</div>
		</div>		
			
		</section>

<jsp:include page="/template/footer.jsp"></jsp:include>