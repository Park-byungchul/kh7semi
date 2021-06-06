<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String root = request.getContextPath();
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
$(function(){
	
	$(".bookSearch-btn").on("click",function(){
		var option = "width=1100,height=900";
		window.name = "parentForm"
		window.open("","target",option);
		$(".bookSearchForm").submit();
	});
	
	
	
	
});

</script>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>
<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">도서 목록</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 전체관리자 > 도서 목록</span>
		</div>
	</div>		
<div class="container-800">
		<div class="row text-center">
	<h2>도서 데이터 추가하기</h2>
			<img id="thumnail">
		</div>
		<div class="row text-center search-form">
			<form class="bookSearchForm search-form" name="bookSearchForm" action="daumBookSearch.jsp" method="post" target="target">
					<select name="type" class="bookSearchType" >
						<option value="all" selected>전체</option>
						<option value="title">제목</option>
						<option value="authors">저자</option>
						<option value="publisher">출판사</option>
						<option value="isbn">isbn</option>
					</select>
					<input type="text" name="keyword" placeholder="검색어" class="bookSearchKeyword text-search-form" required>
			</form>
				<button class="bookSearch-btn form-btn form-btn-inline">검색</button>
		</div>
	
		<form action="insert.kh" method="post">
			<label>ISBN</label><input type="text" name="bookIsbn" id="bookIsbn" class="form-input form-input-underline" required><br><br>
			<label>장르 번호 : </label><input type="text" name="genreNo"  required class="form-input form-input-underline"><br><br>
			<label>제목 : </label><input type="text" name="bookTitle" id="bookTitle" required class="form-input form-input-underline"><br><br>
			<label>저자 : </label><input type="text" name="bookAuthor" id="bookAuthor" required class="form-input form-input-underline"><br><br>
			<label>출판사 : </label><input type="text" name="bookPublisher" id="bookPublisher" required class="form-input form-input-underline"><br><br>
			<label>출판 날짜 : </label><input type="text" name="bookDate" id="bookDate" required class="form-input form-input-underline"><br><br>
			<label>도서 소개 : </label><br><br><textarea name="bookContent" cols="95" rows="6" style="resize:none;border:0;" id="bookContent"></textarea><br><br>
			<label>이미지 URL : </label><input type="text" name="bookImg" id="bookImg" required class="form-input form-input-underline"><br><br>
			<div class="text-center">
				<input type="submit" class="form-btn form-btn-inline" value="추가하기">
				<input type="reset" class="reset form-btn form-btn-inline" value="초기화">
				<a href="bookList.jsp"><input type="button" class="form-btn form-btn-inline" value="목록으로"></a>
			</div>
		</form>
	</div>
	
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>