
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	Integer clientNo = (Integer)session.getAttribute("clientNo");
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto;
	if(clientNo == null) {
		clientDto = null;
	}
	else {
		clientDto = clientDao.get(clientNo);
	}

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
	
	
});
	
</script>
<style>
	.choice-library{
		margin-left:20px;
		margin-right:20px;
		width:150px;
	}
	.search-book{
		border:1px solid white;
		border-radius:20%;
		text-decoration:none;
		padding:0.5rem;
		background-color: green;
		color:white;
	}
</style>

	<div class="row text-center">
		<h2>희망도서 신청 페이지</h2>
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
				<input type="text"  Id="bookAuthor"readonly placeholder = "도서detail-희망도서신청으로 들어오거나" class="form-input form-input-underline">
			</div>
			<div class="row text-left">
				<label>제목</label>
				<input type="text" Id ="bookTitle" readonly placeholder = "위의 검색버튼으로 검색 후 detail-도서신청" class="form-input form-input-underline">
			</div>
			<div class="row text-left">
				<label>장르번호</label>
				<input type="text" Id ="genreNo" readonly placeholder = "위의 검색버튼으로 검색 후 detail-도서신청" class="form-input form-input-underline">
			</div>
			
			
		<form action ="hopelistInsert.kh" method="post">
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
				<textarea name="hopelistReason" rows="10" class="form-input"></textarea> 
			</div>
			<input type="submit" value="신청" class="form-btn form-btn-positive"> 
		</form>
				<hr>
				<input type="button" value="목록" class="form-btn form-btn-normal">
			
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>