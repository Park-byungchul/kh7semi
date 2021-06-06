<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
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

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function(){	
		
	$(".bookSearch-btn").on("click",function(){
		var option = "width=850,height=900";
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

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">희망도서</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 희망도서 신청</span>
		</div>
	</div>
<div class="container-600 ">

	
	<div class="row">
				<div class="row text-left">
					<label>신청자</label>
					<input type="text"  readonly id="clientName" value="<%=clientDto.getClientName()%>" placeholder = "session으로 clientNo가져와서 처리" class="form-input form-input-underline">
				</div>
				<div class="row text-left">
					<label>휴대폰 번호</label>
					<input type="text"  readonly id="clientPhone" value="<%=clientDto.getClientPhone()%>" placeholder = "위와 동일" class="form-input form-input-underline">
				</div>
			
		<div class="row text-center search-form-back">
			<form class="bookSearchForm" name="bookSearchForm" action="hopelistBookSearch.jsp" method="post" target="target">
				<select name="type" class="select-form">
					<option value="all" selected>전체</option>
					<option value="book_title">제목</option>
					<option value="book_author">저자</option>
				</select>
				<input class="text-search-form type="text" name="keyword" placeholder="검색어" class="hopelist-bookSearch">
			</form>
			<button class="bookSearch-btn board-btn">검색</button>
		</div>	
		
			
			
			<div class="row text-left">
				<label>저자</label>
				<input type="text"  Id="bookAuthor" readonly placeholder = "검색을 통해 저자를 불러옵니다." class="form-input form-input-underline">
			</div>
			<div class="row text-left">
				<label>제목</label>
				<input type="text" Id ="bookTitle"  readonly placeholder = "검색을 통해 제목을 불러옵니다." class="form-input form-input-underline">
			</div>
				<input type="hidden" Id ="genreNo" required>
		<form action ="hopelistInsert.kh" method="post">
			<input type="hidden" id="bookIsbn" name="bookIsbn" value="1">
			<div class="row text-left">
				<label>비치희망 도서관</label>
				<select class="choice-library select-form" name="hopelistLibrary" required>
					<option value="1번도서관">1번도서관</option>
					<option value="2번도서관">2번도서관</option>
					<option value="3번도서관">3번도서관</option>
				</select>
			</div>
			<div class="row text-left">
				<label>신청사유</label>
				<textarea name="hopelistReason" rows="10" class="form-input" required></textarea> 
			</div>
			<div class="text-center">
			<input type="submit" value="신청" class="board-btn"> 
			<a href="hopelist.jsp" class="link-btn">목록</a>
			</div>
		</form>
			
	</div>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>