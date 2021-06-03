<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<jsp:include page="/template/header.jsp"></jsp:include>
	<h2>도서 데이터 추가하기</h2>
<div class="float-container">
	<div class="left">
		<form action="insert.kh" method="post">
			<label>ISBN : </label><input type="text" name="bookIsbn" id="bookIsbn" required><br><br>
			<label>장르 번호 : </label><input type="text" name="genreNo"  required><br><br>
			<label>제목 : </label><input type="text" name="bookTitle" id="bookTitle" required><br><br>
			<label>저자 : </label><input type="text" name="bookAuthor" id="bookAuthor" required><br><br>
			<label>출판사 : </label><input type="text" name="bookPublisher" id="bookPublisher" required><br><br>
			<label>출판 날짜 : </label><input type="text" name="bookDate" id="bookDate" required><br><br>
			<label>도서 소개 : </label><textarea name="bookContent" cols="100" rows="10" style="resize:none;'" id="bookContent"></textarea><br><br>
			<label>이미지 : </label><input type="text" name="bookImg" id="bookImg" required><br><br>
			<input type="submit" value="추가하기">
			<input type="reset" class="reset" value="취소">
		</form>
	</div>
	<div class="left">
			<h2>다음api로 책 검색하기</h2>
		<form class="bookSearchForm" name="bookSearchForm" action="daumBookSearch.jsp" method="post" target="target">
				<select name="type" class="bookSearchType" >
					<option value="all" selected>전체</option>
					<option value="title">제목</option>
					<option value="authors">저자</option>
					<option value="publisher">출판사</option>
					<option value="isbn">isbn</option>
				</select>
				<input type="text" name="keyword" placeholder="검색어" class="bookSearchKeyword">
			</form>
			<button class="bookSearch-btn">검색</button>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>