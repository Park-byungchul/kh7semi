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
String root = request.getContextPath(); 
BookDao bookDao = new BookDao();
BookDto bookDto = new BookDto();


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

RecommendDao recommendDao = new RecommendDao();
List<RecommendDto> recommendList;

String type = request.getParameter("type");
String keyword = request.getParameter("keyword");
boolean isSearch = type != null && keyword != null && !keyword.trim().equals("");

if(!isSearch){
	recommendList = recommendDao.rank(startRow, endRow);
}
else if(type.equals("all")){
	recommendList = recommendDao.search(keyword,startRow,endRow);
}
else{
	recommendList = recommendDao.search(type, keyword,startRow,endRow);
}

String title = "추천 도서";
//페이징 -------------------------------------------------------
%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="<%=root%>/pagination/pagination.js"></script>
<script>
</script>
<jsp:include page="/search/searchSidebar.jsp"></jsp:include>
<style>
.bookList>button>a{
	text-decoration: none;
}
</style>
<div class="container-1000">
	<div class="row text-center" style="margin-left:-50px;">
		<h1>추천 도서</h1>
			<form action = "recommendList.jsp" method="get" class="search-form text-center">
				<select name="type" class="select-form">
					<option value="all">전체</option>
					<option value="book_title">제목</option>
					<option value= "book_author">저자</option>
				</select>
				
				<input type="text" name="keyword" size="50" height = "20" class="text-search-form">
				<input type="submit" value="검색" class="form-btn form-btn-inline">
				</form>					
	</div> <br>
	
		<div class="recommendList">
		<%for (RecommendDto recommendDto : recommendList) { 
			bookDto = bookDao.get(recommendDto.getBookIsbn());
			
		%>
			<div style="position:relative;padding:17px 20px;overflow:hidden;height:200px;margin-left:10px;">
				<div class="img" style="position:absolute;top:30px;left:0px;">
					<img src="<%=bookDto.getBookImg()%>">
				</div>
					<div class="row" style="margin-left:120px;font-size:13px">
								<a href="<%=root%>/recommend/recommendDetail.jsp?bookIsbn=<%=bookDto.getBookIsbn()%>" style="font-size:16px;font-weight: bold;padding:5px 0px;"><%=bookDto.getBookTitle()%></a><br>
								<span>저자 : <%=bookDto.getBookAuthor()%> | </span>
								<span>출판사 : <%=bookDto.getBookPublisher()%> | </span>
								<span>발행 : <%=bookDto.getBookDate()%> | </span><br><br>
								<textarea cols="120" rows="6" style="resize:none;border:0 ;"><%=bookDto.getBookContent()%></textarea>
					</div>
			</div>
						
						
				
					
			
				
		
		<%}%>
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
	<form class="search-form" action="recommendList.jsp" method="get">
		<input type="hidden" name="pageNo">
	</form>

	

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>