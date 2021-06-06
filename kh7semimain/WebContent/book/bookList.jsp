<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.GenreDto"%>
<%@page import="library.beans.GenreDao"%>
<%@page import="library.beans.WishlistDto"%>
<%@page import="library.beans.WishlistDao"%>
<%@page import="library.beans.RecommendDto"%>
<%@page import="library.beans.RecommendDao"%>
<%@page import="library.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

String root = request.getContextPath(); 
BookDao bookDao = new BookDao();


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

int count  = bookDao.getCount();
int blockSize = 10;
int lastBlock = (count + pageSize - 1) / pageSize;
int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
int endBlock = startBlock + blockSize - 1;

if(endBlock > lastBlock){
	endBlock = lastBlock;
}

List<BookDto> list = bookDao.list(startRow, endRow);

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
//페이징 -------------------------------------------------------
%>
<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script src="<%=root%>/pagination/pagination.js"></script>
<script>
	$(function(){
		$(".bookDelete").click(function(){
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
<div class="main" style="min-height:800px;">
	<div class="header">
		<div class="row">
			<span class="title">도서 목록</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 전체관리자 > 도서 목록</span>
		</div>
	</div>		
<div class="container-800">
	<div class="row text-right">
		<a class="link-btn" href="bookInsert.jsp">책 등록하기</a>
	</div>
	
	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>ISBN</th>
					<th>장르</th>
					<th>도서명</th>
					<th>저자</th>
					<th>썸네일</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
				<%for (BookDto bookDto : list) { 
	
					GenreDao genreDao = new GenreDao();
					GenreDto genreDto = genreDao.get(bookDto.getGenreNo());
				%>
				<tr>
					<td><%=bookDto.getBookIsbn()%></td>
					<td><%=genreDto.getGenreName()%></td>
					<td><%=bookDto.getBookTitle()%></td>
					<td><%=bookDto.getBookAuthor()%></td>
					<td><img src="<%=bookDto.getBookImg() %>"></td>
					<td class="bookList">
					<button class="board-btn" style="border-bottom: 1px solid white; width: 88px;"><a class="btn-text" href="bookEdit.jsp?bookIsbn=<%=bookDto.getBookIsbn()%>">수정</a></button>
					<button class="board-btn" style="border-bottom: 1px solid white; width: 88px;"><a class="bookDelete btn-text" href="bookDelete.kh?bookIsbn=<%=bookDto.getBookIsbn()%>">삭제</a></button>
					<button class="board-btn" style="border-bottom: 1px solid white; width: 88px;"><a class="btn-text" href="bookDetail.jsp?bookIsbn=<%=bookDto.getBookIsbn()%>">상세보기</a></button>
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
	
	<form action="bookList.jsp" method="get" class="search-form">
		<input type="hidden" name="pageNo">
	</form>

	<div class="row text-right">
		<a class="link-btn" href="bookInsert.jsp">책 등록하기</a>
	</div>

</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>