<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.HopelistDao"%>
<%@page import="library.beans.HopelistDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int hopelistNo = Integer.parseInt(request.getParameter("hopelistNo"));
	HopelistDao hopelistDao = new HopelistDao();
	HopelistDto hopelistDto = hopelistDao.get(hopelistNo);
	String root = request.getContextPath();	
	BookDao bookDao = new BookDao();
	BookDto bookDto = bookDao.get(hopelistDto.getBookIsbn());

	Integer clientNo = (Integer)session.getAttribute("clientNo");
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto;
	if(clientNo == null) {
		clientDto = null;
	}
	else {
		clientDto = clientDao.get(clientNo);
	}
	
	AreaDao areaDao = new AreaDao();
	int areaNo;
	try{
		areaNo = (int)session.getAttribute("areaNo");
	}
	catch (Exception e){
		areaNo = 0;
	}
	String title = "희망도서";
	if(areaNo > 0){
		title += " : " + areaDao.detail(areaNo).getAreaName();
	}
%>

<jsp:include page="/service/serviceSidebar.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>
<script>
$(function(){
	$("#hopelistDelete").click(function(){
		var choice = window.confirm("정말 삭제하시겠습니까?");
		if (choice) {
			return true;
		} else {
			return false;
		}
	});

});
</script>
<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">희망도서</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 희망도서 상세보기</span>
		</div>
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
		</div>
	
		<div class="row text-left">
				<label>저자</label>
				<input type="text"  Id="bookAuthor"readonly value = "<%=bookDto.getBookAuthor()%>"class="form-input form-input-underline">
			</div>
			<div class="row text-left">
				<label>제목</label>
				<input type="text" Id ="bookTitle" readonly value = "<%=bookDto.getBookTitle()%>" class="form-input form-input-underline">
			</div>
				<input type="hidden" Id ="genreNo"  value = "<%=bookDto.getGenreNo()%>" class="form-input form-input-underline">
			<input type="hidden" name="hopelistNo" value="<%=hopelistDto.getHopelistNo()%>">
			<input type="hidden" id="bookIsbn" name="bookIsbn" value="1">
			<div class="row text-left">
				<label>비치희망 도서관</label>
			<input type="text" Id =""  value = "<%=hopelistDto.getHopelistLibrary()%>" class="form-input form-input-underline">
			</div>
			<div class="row text-left">
				<label>신청사유</label>
				<textarea name="hopelistReason" rows="10" class="form-input"  style="resize:none;border:0;"readonly><%=hopelistDto.getHopelistReason()%></textarea> 
			</div>
		
		<div class="row text-right">
			<a href="hopelistInsert.jsp" class="link-btn">신청하러가기</a>
		
			<!-- 본인 및 관리자에게만 표시되도록 하는 것이 좋다 -->
			<a href="hopelistEdit.jsp?hopelistNo=<%=hopelistNo%>" class="link-btn">수정</a>
			<a href="hopelistDelete.kh?hopelistNo=<%=hopelistNo%>" class="link-btn" id=hopelistDelete>삭제</a>
			
			
			<a href="hopelist.jsp" class="link-btn">목록</a>
		</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>