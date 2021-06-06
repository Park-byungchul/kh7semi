<%@page import="library.beans.GenreDto"%>
<%@page import="library.beans.GenreDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.AreaDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String bookIsbn = request.getParameter("bookIsbn");
	BookDao bookDao = new BookDao();
	BookDto bookDto = bookDao.get(bookIsbn);

	
	request.setCharacterEncoding("UTF-8");
	AreaDao areaDao = new AreaDao();
	int areaNo;
	try{
		areaNo = (int)session.getAttribute("areaNo");
	}
	catch (Exception e){
		areaNo = 0;
	}

	String title = "관리자 메뉴";
	if(areaNo > 0){
		title += " : " + areaDao.detail(areaNo).getAreaName();
	}
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function() {
	$(".bookDelete").click(function() {
		var choice = window.confirm("정말 삭제하시겠습니까?");
		if (choice) {
			return true;
		} else {
			return false;
		}
	});
});
</script>
<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<div class="container-600">
	<div class="row text-center">
		<h2>도서 수정</h2>
			<img id="thumnail" style="width:240px;height:348px;"src="<%=bookDto.getBookImg()%>">
		</div>
		
		
		<form action="bookEdit.kh" method="post">
			<div class="row text-left">
				<label>ISBN</label><input type="text" name="bookIsbn" id="bookIsbn" class="form-input form-input-underline" required value="<%=bookDto.getBookIsbn()%>"><br><br>
				<label>장르 번호 </label><input type="text" name="genreNo"  required class="form-input form-input-underline" value="<%=bookDto.getGenreNo()%>"><br><br>
				<label>제목 </label><input type="text" name="bookTitle" id="bookTitle" required class="form-input form-input-underline" value="<%=bookDto.getBookTitle()%>"><br><br>
				<label>저자</label><input type="text" name="bookAuthor" id="bookAuthor" required class="form-input form-input-underline" value="<%=bookDto.getBookAuthor()%>"><br><br>
				<label>출판사</label><input type="text" name="bookPublisher" id="bookPublisher" required class="form-input form-input-underline" value="<%=bookDto.getBookPublisher()%>"><br><br>
				<label>출판 날짜</label><input type="text" name="bookDate" id="bookDate" required class="form-input form-input-underline" value="<%=bookDto.getBookDate()%>"><br><br>
				<label>도서 소개</label><br><br><textarea name="bookContent" cols="95" rows="6" style="resize:none;border:0 ;'" id="bookContent" ><%=bookDto.getBookContent()%></textarea><br><br>
				<label>이미지 URL</label><input type="text" name="bookImg" id="bookImg" required class="form-input form-input-underline" value="<%=bookDto.getBookImg()%>"><br><br>
			</div>
			<div class="row text-right">
				<input type="submit" value="수정완료">
				<button><a href="bookList.jsp">목록</a></button>
				<button><a href="bookDelete.kh?bookIsbn=<%=bookDto.getBookIsbn()%>" class="bookDelete">삭제</a></button>
			</div>
		</form>	
		
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>