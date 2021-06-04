<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	int areaNo = (int)session.getAttribute("areaNo");
    
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
<jsp:include page="/template/header.jsp"></jsp:include>

	<h2>도서관에 도서 추가</h2>
	<hr>
	<h3>도서 검색하기</h3>
		<div class="row">
			<form class="bookSearchForm" name="bookSearchForm" action="getBookSearch.jsp" method="post" target="target">
				<select name="type" >
					<option value="all" selected>전체</option>
					<option value="book_title">제목</option>
					<option value="book_author">저자</option>
				</select>
				<input type="text" name="keyword" placeholder="검색어" class="hopelist-bookSearch">
			</form>
			<button class="bookSearch-btn">검색</button>
		</div>
		<hr>
		
		
	<form action="insert.kh" method="post">
		<label>ISBN : </label><input type="text" name="bookIsbn"  id="bookIsbn" required class="form-input form-input-underline"><br><br>
		<label>저자 : </label><input type="text" name="bookAuthor"  id="bookAuthor" required class="form-input form-input-underline"><br><br>
		<label>제목 : </label><input type="text" name="bookTitle" id="bookTitle" required class="form-input form-input-underline"><br><br>
		<label>지점번호 : </label><input type="text" name="areaNo" required value="<%=areaNo%>" class="form-input form-input-underline"><br><br>
		<label>입고일자 : </label><input type="date" name="getBookDate" required><br><br>
		<label>상태 : </label><input type="text" name="getBookStatus" required class="form-input form-input-underline"><br><br>
		<input type="submit" value="도서 추가">
	</form>
	
	

<jsp:include page="/template/footer.jsp"></jsp:include>