<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	
    
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
$(function(){	
		
	$(".bookSearch-btn").on("click",function(){
		var option = "width=700,height=900";
		window.name = "parentForm"
		window.open("","target",option);
		$(".bookSearchForm").submit();
	});
	
	
});
	
</script>
<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

	<h2>도서관에 도서 추가</h2>
	<hr>
	<h3>도서 검색하기</h3>
		<div class="row text-center search-form">
			<form class="bookSearchForm search-form" name="bookSearchForm" action="getBookSearch.jsp" method="post" target="target">
				<select name="type" >
					<option value="all" selected>전체</option>
					<option value="book_title">제목</option>
					<option value="book_author">저자</option>
				</select>
				<input type="text" name="keyword" class="text-search-form" placeholder="검색어" class="hopelist-bookSearch">
			</form>
			<button class="bookSearch-btn board-btn">검색</button>
		</div>
		<hr>
		
		
	<form action="insert.kh" method="post">
		<label>ISBN : </label><input type="text" name="bookIsbn"  id="bookIsbn" required class="form-input form-input-underline"><br><br>
		<label>저자 : </label><input type="text" name="bookAuthor"  id="bookAuthor" required class="form-input form-input-underline"><br><br>
		<label>제목 : </label><input type="text" name="bookTitle" id="bookTitle" required class="form-input form-input-underline"><br><br>
		<label>지점번호 : </label><input type="text" name="areaNo" required value="<%=areaNo%>" class="form-input form-input-underline"><br><br>
		<div class="text-center">
			<input type="submit" class="board-btn" value="도서 추가">
			<button class="board-btn"><a class="btn-text" href="getBookList.jsp">목록</a></button>
		</div>
	</form>
	
	

<jsp:include page="/template/footer.jsp"></jsp:include>