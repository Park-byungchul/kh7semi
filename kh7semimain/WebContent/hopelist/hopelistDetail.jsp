<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.HopelistDao"%>
<%@page import="library.beans.HopelistDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<%
	int hopelistNo = Integer.parseInt(request.getParameter("hopelistNo"));
	HopelistDao hopelistDao = new HopelistDao();
	HopelistDto hopelistDto = hopelistDao.get(hopelistNo);
	
	BookDao bookDao = new BookDao();
	BookDto bookDto = bookDao.get(hopelistDto.getBookIsbn());

%>
<div class="container-600">
	<h2>내 희망도서 신청 <%=hopelistNo%>번 페이지</h2>
	
		<div class="row">
			도서명 : 
			<%=bookDto.getBookTitle()%>
		</div>
		<div class="row">
			저자 : 
			<%=bookDto.getBookAuthor()%>
		</div>
		<div class="row">
			신청 날짜 :
			<%=hopelistDto.getHopelistDate()%>
		</div>
		<div class="row">
			희망 도서관 :
			<%=hopelistDto.getHopelistLibrary()%>
		</div>
	
		<div class="row text-left" style="min-height:300px;">
			<label>신청 이유</label>
			<pre><%=hopelistDto.getHopelistReason()%></pre>
		</div>
		
		<div class="row text-right">
			<a href="boardWrite.jsp" class="link-btn">신청하러가기</a>
		
			<!-- 본인 및 관리자에게만 표시되도록 하는 것이 좋다 -->
			<a href="hopelistEdit.jsp?hopelistNo=<%=hopelistNo%>" class="link-btn">수정</a>
			<a href="hopelistDelete.kh?hopelistNo=<%=hopelistNo%>" class="link-btn">삭제</a>
			
			
			<a href="hopelist.jsp" class="link-btn">목록</a>
		</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>