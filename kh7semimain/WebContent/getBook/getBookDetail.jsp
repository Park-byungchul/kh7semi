<%@page import="library.beans.GetBookSearchDto"%>
<%@page import="library.beans.GetBookSearchDao"%>
<%@page import=  "java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int getBookNo = Integer.parseInt(request.getParameter("getBookNo"));
	GetBookSearchDao getBookSearchDao = new GetBookSearchDao();
	GetBookSearchDto getBookSearchDto = getBookSearchDao.get(getBookNo);
%>

<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>	

	<div class="container-800">
		<div class="row text-left">
			<h2>도서 정보</h2>
		</div>
		
		<div class="row">
				<div class="row">
					<label>도서명 : </label><span><%=getBookSearchDto.getBookTitle() %></span>
				</div>
				<div class="row">
					<label>저자 : </label><span><%=getBookSearchDto.getBookAuthor() %></span>
				</div>
				<div class="row">
					<label>입고번호 : </label><span><%=getBookSearchDto.getGetBookNo() %></span>
				</div>
				<div class="row">
					<label>책번호 : </label><span><%=getBookSearchDto.getBookIsbn() %></span>
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
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>