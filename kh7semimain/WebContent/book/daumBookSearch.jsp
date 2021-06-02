<%@page import="library.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
 	String keyword = request.getParameter("keyword");
 	String type = request.getParameter("type");
 
	String root = request.getContextPath();
	
	BookDao bookDao = new BookDao();

	boolean isSearch = type != null && keyword != null && !keyword.trim().equals("");
	
 %>
 <html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<title>도서 검색</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
 <script>
$(function(){
	$(".bookSearchType").val("<%=type%>").attr("selected", "selected");
	
	
	
	$(window).on('load',function(){
		var keyword = "<%=keyword%>";
		var target = "<%=type%>";
	
	    event.preventDefault();
	    if(keyword !== undefined && keyword !== ""){
	        $.ajax({
	          url: "https://dapi.kakao.com/v3/search/book",
	          headers: {'Authorization': 'KakaoAK 0c7c4690db5e43829555bc3a5cc334a4'},
	          type : "get",
	          data:{
	              query: keyword
	              //target이 제대로 안잡힘
	          },
	          success : function(result){
	              let data = result.documents[0];
	              $(".bookTitle").text(data.title);
		          $('.bookAuthor').text(data.authors);
	              $('.bookPublisher').text(data.publisher);
		          $('.bookIsbn').text(data.isbn);
		          $('.bookContent').text(data.contents+"...");
		          let date = data.datetime.split('T')[0];
	              $('.bookDate').text(date);
		          $(".bookImg").attr("src", data.thumbnail);
	          }
	      });
	    }
	});
					
});
</script>
<style>
td{
    max-width: 150px; /** Adjust width to your needs */
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
</style>
<body>
<div class="container-600">

</div>
<div class="row">
		<form class="bookSearchForm" name="bookSearchForm" action="daumBookSearch" method="post" target="target">
			<select name="type" class="bookSearchType">
				<option value="all">전체</option>
				<option value="title">제목</option>
				<option value="authors">저자</option>
				<option value="publisher">출판사</option>
				<option value="isbn">isbn</option>
			</select>
			<input type="text" name="keyword" value=<%=keyword%> class="bookSearchKeyword">
			<input type="submit" value="검색" class="bookSearch-btn">
		</form>
</div>
<hr>	

<div class="row text-left">
	<h2>책 목록</h2>
</div>

<div class="row">
	<table class="table table-border table-hover">
		<thead>
			<tr>
				<th>도서명</th>
				<th>저자</th>
				<th>출판사</th>
				<th>ISBN</th>
				<th>내용</th>
				<th>출간일</th>
				<th>썸네일</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="bookTitle"></td>
				<td class="bookAuthor"></td>
				<td class="bookPublisher"></td>
				<td class="bookIsbn"></td>
				<td class="bookContent"></td>
				<td class="bookDate"></td>
				<td class="bookImg"><img class="bookimg"></td>
				<td>
				<button class="choice-btn">선택하기</button>
				</td>
			</tr>
		</tbody>
	</table>
</div>


</body>
</html>


 