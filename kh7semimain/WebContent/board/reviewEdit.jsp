<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.board.ReviewDto"%>
<%@page import="library.beans.board.ReviewDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	
	ReviewDao reviewDao = new ReviewDao();
	ReviewDto reviewDto = reviewDao.find(reviewNo);
	BookDto bookDto = reviewDao.getBookInfo(reviewDto.getBookIsbn());
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	function bookSearch(){
		var option = "width=700,height=900";
		var val = $("#bookTitle").val();
		
		window.open("reviewBookSearch.jsp?", "target", option);
	}
</script>

<script>

</script>
    
<h1>리뷰 수정</h1>

<div class="container-800">
	<form action="reviewEdit.kh" method="post">
		<input type="hidden" name="reviewNo" value="<%=reviewNo%>">
	
		<table>
			<tbody>
				<tr>
					<th class="text-left" style="background-color:lightgray;">리뷰 제목</th>
					<td>
						<input type="text" name="reviewSubject" value="<%=reviewDto.getReviewSubject() %>" class="form-input" style="width:750px">
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">도서명</th>
					<td>
						<input type="text" id="bookTitle" name="bookTitle" value="<%=bookDto.getBookTitle() %>" placeholder="검색어">
						<a onclick="bookSearch()" class="link-btn">도서 검색</a>
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">저자</th>
					<td>
						<input type="text" id="bookAuthor" name="bookAuthor" value="<%=bookDto.getBookAuthor() %>">
						<input type="hidden" id="bookIsbn" name="bookIsbn">
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">출판사</th>
					<td>
						<input type="text" id="bookPublisher" value="<%=bookDto.getBookPublisher() %>">
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">내용</th>
					<td>
						<textarea name="reviewContent" rows="15" class="text-right form-input">
							<%=reviewDto.getReviewContent() %>
						</textarea>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="row">
			<input type="submit" value="수정" class="link-btn">
			<a href="reviewDetail.jsp?reviewNo=<%=reviewNo %>" class="link-btn">취소</a>
		</div>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>