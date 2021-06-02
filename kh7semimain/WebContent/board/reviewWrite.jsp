<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Integer clientNo = (Integer)session.getAttribute("clientNo");

	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(clientNo);
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
    
<h1>리뷰 작성</h1>

<div class="container-800">
	<form action="reviewInsert.kh" method="post">
		<table>
			<tbody>
				<tr>
					<th class="text-left" style="background-color:lightgray;">리뷰 제목</th>
					<td>
						<input type="text" name="reviewSubject" class="form-input" style="width:750px">
					</td>
				</tr>
					
				<tr>
					<th class="text-left" style="background-color:lightgray;">작성자</th>
					<td>
						<p><%=clientDto.getClientName()%></p>
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">도서명</th>
					<td>
						<input type="text" id="bookTitle" name="bookTitle" placeholder="검색어">
						<a onclick="bookSearch()" class="link-btn">도서 검색</a>
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">저자</th>
					<td>
						<input type="text" id="bookAuthor" name="bookAuthor">
						<input type="hidden" id="bookIsbn" name="bookIsbn">
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">출판사</th>
					<td>
						<input type="text" id="bookPublisher">
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">내용</th>
					<td>
						<textarea name="reviewContent" rows="15" class="text-right form-input"></textarea>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="row">
			<input type="submit" value="등록">
			<a href="reviewList.jsp" class="link-btn">목록</a>
		</div>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>