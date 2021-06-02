<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function(){
	$(".bookSearch").click(function(){
		var title = $(".bookTitle").val();
	    event.preventDefault();
	    if(title !== undefined && title !== ""){
	        $.ajax({
	          url: "https://dapi.kakao.com/v3/search/book",
	          headers: {'Authorization': 'KakaoAK 0c7c4690db5e43829555bc3a5cc334a4'},
	          type : "get",
	          data:{
	              query: title,
	             target:'title'
	          },
	          success : function(result){
	              let data = result.documents[0];
	              $(".bookTitle").val(data.title);
 	              $('.bookAuthor').val(data.authors);
	              $('.bookPublisher').val(data.publisher);
 	              $('.bookIsbn').val(data.isbn);
 	              $('.bookContent').val(data.contents+"...");
 	              let date = data.datetime.split('T')[0];
	              $('.bookDate').val(date);
 	              $('.bookImgUrl').val(data.thumbnail);
	          }
	      });
	    }
	});
	
	
});

</script>
<jsp:include page="/template/header.jsp"></jsp:include>
	<h2>회원가입</h2>

		<form action="insert.kh" method="post">
			<label>ISBN : </label><input type="text" name="bookIsbn" class="bookIsbn"><br><br>
			<label>장르 번호 : </label><input type="text" name="genreNo" ><br><br>
			<label>제목 : </label><input type="text" name="bookTitle" class="bookTitle" ><button class="bookSearch">검색</button><br><br>
			<label>저자 : </label><input type="text" name="bookAuthor" class="bookAuthor"><br><br>
			<label>출판사 : </label><input type="text" name="bookPublisher" class="bookPublisher"><br><br>
			<label>출판 날짜 : </label><input type="text" name="bookDate" class="bookDate"><br><br>
			<label>도서 소개 : </label><textarea name="bookContent" cols="100" rows="10" style="resize:none;'" class="bookContent"></textarea>
			<label>이미지 : </label><input type="text" name="bookImg" class="bookImgUrl"><br><br>
			<input type="submit" value="추가하기">
		</form>
<jsp:include page="/template/footer.jsp"></jsp:include>