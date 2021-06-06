<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.NewBookDto"%>
<%@page import="library.beans.NewBookDao"%>
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
NewBookDao newBookDao = new NewBookDao();
String area = request.getParameter("area");
String genre = request.getParameter("genre");
String term = request.getParameter("term");
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
int count; 
List<NewBookDto> bookList = null;
// boolean isNotSelect = area.equals("메인도서관") && genre.equals("all") && term.equals("90");
boolean isMain = area == null && genre == null && term == null;
int termInt;

if(isMain) {
	bookList = newBookDao.newBookList(startRow, endRow);
	count = newBookDao.getCount();
}
else if(area.equals("메인도서관") && genre.equals("all") && term.equals("90")) {
	bookList = newBookDao.newBookList(startRow, endRow);
	count = newBookDao.getCount();
}
else if(!area.equals("메인도서관") && genre.equals("all") && term.equals("90")){
	termInt = Integer.parseInt(term);
	bookList = newBookDao.newBookList1(area, termInt, startRow, endRow);
	count = newBookDao.getCount(area);
}
else if(area.equals("메인도서관") && !genre.equals("all")){
	termInt = Integer.parseInt(term);
	bookList = newBookDao.newBookList1(genre, termInt, startRow, endRow);
	count = newBookDao.getCount(genre);
}
else if(area.equals("메인도서관") && genre.equals("all") && !term.equals("90")){
	termInt = Integer.parseInt(term);
	bookList = newBookDao.newBookList2(termInt, startRow, endRow);
	count = newBookDao.getCount(termInt);
}
else {
	termInt = Integer.parseInt(term);
	bookList = newBookDao.newBookList3(termInt, area, genre, startRow, endRow);
	count = newBookDao.getCount(termInt, area, genre);
}

int blockSize = 10;
int lastBlock = (count + pageSize - 1) / pageSize;
int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
int endBlock = startBlock + blockSize - 1;
if(endBlock > lastBlock){
	endBlock = lastBlock;
}
AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}
String title = "신착 도서";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>
<jsp:include page="/search/searchSidebar.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>
<script src="<%=root%>/pagination/pagination.js"></script>

<style>
.bookList>button>a{
	text-decoration: none;
}
</style>

<div class="main">
		<div class="header">
			<div class="row">
				<span class="title">신착 도서</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 자료 검색 > 신착 도서</span>
			</div>
		</div>
		
		<div class="container-800">
			<div class="row text-center">
					<form action = "newbooklist.jsp" method="get">
						<select name="area" class="select-form">
							<option value="메인도서관">전체도서관</option>
							<option value="강남도서관">강남도서관</option>
							<option value= "종로도서관">종로도서관</option>
							<option value= "당산도서관">당산도서관</option>
						</select>
						<select name="genre" class="select-form">
							<option value="all">전체</option>
							<option value="총류">총류</option>
							<option value= "철학">철학</option>
							<option value="종교">종교</option>
							<option value= "사회과학">사회과학</option>
							<option value="순수과학">순수과학</option>
							<option value= "기술과학">기술과학</option>
							<option value="예술">예술</option>
							<option value= "언어">언어</option>
							<option value= "문학">문학</option>
							<option value= "역사">역사</option>
						</select>
						<select name="term" class="select-form">
							<option value="90">3달이내</option>
							<option value="60">1달이내</option>
							<option value="30">1주이내</option>
						</select>
						<input type="submit" value="검색" class="form-btn form-btn-inline">
					</form>					
			</div> <br>
			
				<div class="recommendList">
				<%for(NewBookDto newBookDto : bookList) {%>
					<div style="position:relative;padding:17px 20px;overflow:hidden;height:200px;margin-left:10px;">
						<div class="img" style="position:absolute;top:30px;left:0px;">
							<img src="<%=newBookDto.getBookImg()%>">
						</div>
							<div class="row" style="margin-left:120px;font-size:13px">
										<a href="<%=root%>/newbook/newbookDetail.jsp?bookIsbn=<%=newBookDto.getBookIsbn()%>" style="font-size:16px;font-weight: bold;padding:5px 0px;"><%=newBookDto.getBookTitle()%></a><br>
										<span>저자 : <%=newBookDto.getBookAuthor()%> | </span>
										<span>출판사 : <%=newBookDto.getBookPublisher()%> | </span>
										<span>발행일 : <%=newBookDto.getBookDate()%> | </span><br>
										<span>isbn : <%=newBookDto.getBookIsbn()%> | </span>
										<span>장르 : <%=newBookDto.getGenreName()%> | </span><br>
										<span>도서관 : <%=newBookDto.getAreaName()%></span>	
							</div>
					</div>
				<%} %>
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
			<form class="search-form" action="newbooklist.jsp" method="get">
				<input type="hidden" name="pageNo">
			</form>
		
		</div>
	</div>
	
<jsp:include page="/template/footer.jsp"></jsp:include>