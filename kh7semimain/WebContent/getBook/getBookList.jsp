<%@page import="library.beans.RecommendDto"%>
<%@page import="library.beans.RecommendDao"%>
<%@page import="library.beans.GetBookSearchDto"%>
<%@page import="library.beans.GetBookSearchDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String root = request.getContextPath(); 
GetBookSearchDao getBookSearchDao = new GetBookSearchDao();
List<GetBookSearchDto> list = getBookSearchDao.list();
int clientNo;
try {
	clientNo = (int)session.getAttribute("clientNo");
	
}
catch (Exception e){
	clientNo = 0;
}


boolean isLogin = session.getAttribute("clientNo") != null;



int p;

try {
	p = Integer.parseInt(request.getParameter("p"));
}
catch (Exception e) {
	p = 1;
}

// 페이징 -------------------------------------------------------
int pageNo;
try{
	pageNo = Integer.parseInt(request.getParameter("pageNo"));
	if(pageNo < 1) {
		throw new Exception();
	}
}
catch(Exception e){
	pageNo = 1;
}

int pageSize;
try{
	pageSize = Integer.parseInt(request.getParameter("pageSize"));
	if(pageSize < 10){
		throw new Exception();
	}
}
catch(Exception e){
	pageSize = 10;
}

int startRow = pageNo * pageSize - (pageSize-1);
int endRow = pageNo * pageSize;

int count = 1;
//int count  = getBookSearchDao.getCount(); // 구현하자!
int blockSize = 10;
int lastBlock = (count + pageSize - 1) / pageSize;
int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
int endBlock = startBlock + blockSize - 1;

if(endBlock > lastBlock){
	endBlock = lastBlock;
}
//페이징 -------------------------------------------------------
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="<%=root%>/pagination/pagination.js"></script>
<script>
	$(function(){
		$(".getBookDelete").click(function(){
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if (choice) {
				return true;
			} else {
				return false;
			}
		});

	});
</script>
<style>
.bookList>button>a{
	text-decoration: none;
}
</style>
<div class="container-1000">
	<div class="row text-left">
		<h2>입고된 도서 목록</h2>
	</div>
	<div class="row text-right">
		<a href="getBookInsert.jsp">입고하기</a>
	</div>
	
	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>입고 번호</th>
					<th>ISBN</th>
					<th>썸네일</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
				<%for (GetBookSearchDto getBookSearchDto : list) { 
	
				%>
				<tr>
					<td><%=getBookSearchDto.getBookIsbn()%></td>
					<td><%=getBookSearchDto.getBookTitle()%></td>
					<td><%=getBookSearchDto.getBookAuthor()%></td>
					<td><img src="<%=getBookSearchDto.getBookImg() %>"></td>
					<td class="bookList">
					<button><a href="getBookEdit.jsp?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>">수정</a></button>
					<button><a class="getBookDelete" href="getBookDelete.kh?getBookNo=<%=getBookSearchDto.getGetBookNo()%>">삭제</a></button>
					<button><a href="bookDetail.jsp?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>">상세보기</a></button>
					</td>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>

	<div class="row text-center">
		<div class="pagination">
			<%if(startBlock > 1) { %>
				<a class="move-link">이전</a>
			<%} %>
			<%for(int i = startBlock; i <= endBlock; i++) {%>
				<%if(i == pageNo) {%>
					<a class="on"><%=i %></a>
				<%} else { %>
					<a><%=i %></a>
				<%} %>
			<%} %>
	 		<%if(endBlock < lastBlock) { %>
				<a class="move-link">다음</a>
			<%} %>
		</div>
	</div>
	<form class="search-form" action="bookList.jsp" method="get">
		<input type="hidden" name="pageNo">
	</form>

	<div class="row text-right">
		<a href="getBookInsert.jsp">책 등록하기</a>
	</div>

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>