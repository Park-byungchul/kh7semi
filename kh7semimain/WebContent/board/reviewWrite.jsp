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
	
	String root = request.getContextPath();
%>
    
<jsp:include page="/board/boardMenuSidebar.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	function bookSearch(){
		var option = "width=700,height=900";
		var val = $("#bookTitle").val();
		
		window.open("reviewBookSearch.jsp?", "target", option);
	}
	
	// 높이 자동 설정
	function resize(obj) {
  		obj.style.height = "1px";
  		obj.style.height = (12+obj.scrollHeight)+"px";
	}
</script>

<style>
	th {
		width:15%;
	}
</style>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">도서 리뷰</span>
		</div>
				
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 열린 공간 > 도서 리뷰</span>
		</div>
	</div>
	
	<form action="reviewInsert.kh" method="post">
		<table class="table table-border table-hover board-table">
			<tbody>
				<tr>
					<th>리뷰 제목</th>
					<td>
						<input maxlength="300" type="text" name="reviewSubject" class="form-input" style="width:750px">
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						<p style="margin:0"><%=clientDto.getClientName()%></p>
					</td>
				</tr>
				<tr>
					<th>도서명</th>
					<td>
						<div>
							<input class="review-write-text" type="text" id="bookTitle" name="bookTitle" placeholder="검색어">
							<a onclick="bookSearch()" class="text-right link-btn">도서 검색</a>
						</div>
					</td>
				</tr>
				<tr>
					<th>저자</th>
					<td>
						<input class="form-input" type="text" id="bookAuthor" name="bookAuthor">
						<input type="hidden" id="bookIsbn" name="bookIsbn">
					</td>
				</tr>
				
				<tr>
					<th>출판사</th>
					<td>
						<input class="form-input" type="text" id="bookPublisher">
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea maxlength="4000" class="board-write-area" onkeydown="resize(this)" onkeyup="resize(this)" name="reviewContent" rows="15"></textarea>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="row text-right">
			<input type="submit" class="board-btn" value="등록">
			<a href="reviewList.jsp" class="link-btn">목록</a>
		</div>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>