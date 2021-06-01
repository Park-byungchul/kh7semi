<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.HopelistDto"%>
<%@page import="library.beans.HopelistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int hopelistNo = Integer.parseInt(request.getParameter("hopelistNo"));
	HopelistDao hopelistDao = new HopelistDao();
	HopelistDto hopelistDto = hopelistDao.get(hopelistNo);	
	
	BookDao bookDao = new BookDao();
	BookDto bookDto = bookDao.get(hopelistDto.getBookIsbn());
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(hopelistDto.getClientNo());
%>

<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function(){	
		
	$(".bookSearch-btn").on("click",function(){
		var option = "width=700,height=900";
		window.name = "parentForm"
		window.open("","target",option);
		$(".bookSearchForm").submit();
	});
	
	$(".choice-library").val("<%=hopelistDto.getHopelistLibrary()%>").attr("selected", "selected");


});
	
</script>

	<div class="row text-center">
		<h2>희망도서 신청 수정</h2>
	</div>
		<div class="row">
				<div class="row text-left">
					<label>신청자</label>
					<input type="text"  readonly id="clientName" value="<%=clientDto.getClientName()%>" placeholder = "session으로 clientNo가져와서 처리" class="form-input form-input-underline">
				</div>
				<div class="row text-left">
					<label>휴대폰 번호</label>
					<input type="text"  readonly id="clientPhone" value="<%=clientDto.getClientPhone()%>" placeholder = "위와 동일" class="form-input form-input-underline">
				</div>
			
		<div class="row">
			<form class="bookSearchForm" name="bookSearchForm" action="hopelistBookSearch.jsp" method="post" target="target">
				<select name="type" >
					<option value="all" selected>전체</option>
					<option value="book_title">제목</option>
					<option value="book_author">저자</option>
				</select>
				<input type="text" name="keyword" placeholder="검색어" class="hopelist-bookSearch">
			</form>
			<button class="bookSearch-btn">검색</button>
		</div>	
		
			
			
			<div class="row text-left">
				<label>저자</label>
				<input type="text"  Id="bookAuthor"readonly value = "<%=bookDto.getBookAuthor()%>"class="form-input form-input-underline">
			</div>
			<div class="row text-left">
				<label>제목</label>
				<input type="text" Id ="bookTitle" readonly value = "<%=bookDto.getBookTitle()%>" class="form-input form-input-underline">
			</div>
			<div class="row text-left">
				<label>장르번호</label>
				<input type="text" Id ="genreNo" readonly value = "<%=bookDto.getGenreNo()%>" class="form-input form-input-underline">
			</div>
			
			
		<form action ="hopelistEdit.kh" method="post">
			<input type="hidden" name="hopelistNo" value="<%=hopelistDto.getHopelistNo()%>">
			<input type="hidden" id="bookIsbn" name="bookIsbn" value="1">
			<div class="row text-left">
				<label>비치희망 도서관</label>
				<select class="choice-library" name="hopelistLibrary">
					<option value="1번도서관">1번도서관</option>
					<option value="2번도서관">2번도서관</option>
					<option value="3번도서관">3번도서관</option>
				</select>
			</div>
			<div class="row text-left">
				<label>신청사유</label>
				<textarea name="hopelistReason" rows="10" class="form-input"><%=hopelistDto.getHopelistReason()%></textarea> 
			</div>
			<input type="submit" value="수정" class="form-btn form-btn-positive"> 
		</form>
				<hr>
				<a href="hopelist.jsp">
				<input type="button" value="목록" class="form-btn form-btn-normal">
				</a>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>