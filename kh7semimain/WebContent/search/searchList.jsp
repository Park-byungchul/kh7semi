<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.GetBookDto"%>
<%@page import="library.beans.GenreDto"%>
<%@page import="library.beans.GenreDao"%>
<%@page import="library.beans.GetBookSearchDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.GetBookSearchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
	GetBookSearchDao getBookSearchDao = new GetBookSearchDao();
	
	BookDao bookDao = new BookDao();
	BookDto bookDto = new BookDto();
	
	int clientNo;
	try {
		clientNo = (int)session.getAttribute("clientNo");
		
	}
	catch (Exception e){
		clientNo = 0;
	}
	
	request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	boolean isSearch = keyword != null;
		
	


	
	boolean isLogin = session.getAttribute("clientNo") != null;
//-------------
int p;

try {
	p = Integer.parseInt(request.getParameter("p"));
}
catch (Exception e) {
	p = 1;
}

//--페이징
	// 페이지 번호
	int pageNo;
	
	try {
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		if(pageNo < 1) throw new Exception();
	}
	catch (Exception e) {
		pageNo = 1;
	}
	
	// 한 페이지 글 개수
	int pageSize;
	try {
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if(pageSize < 10) throw new Exception();
	}
	catch (Exception e) {
		pageSize = 10;
	}
	
	// 시작과 끝번호
	int startRow = pageNo * pageSize - (pageSize - 1);
	int endRow = pageNo * pageSize;
	
	// 페이지 네비게이션 영역 계산
	int count;
	
	
	
		List<GetBookSearchDto> getBookList;
		//select값이 기본 -> '전체' 값을 null로 주고 keyword만 전송
		if(type == null && keyword == null) {
			getBookList = getBookSearchDao.list(startRow, endRow);
			count = getBookSearchDao.getCount();
		}
		else if(type.equals("all") || type.equals(null)){
			getBookList = getBookSearchDao.searchList(keyword, startRow, endRow);
			count = getBookSearchDao.getCount(keyword);
		}
		else{ //select가 '전체'가 아니면 type과 keyword 같이 전송
			getBookList = getBookSearchDao.searchList(type, keyword, startRow, endRow);
			count = getBookSearchDao.getCount(type, keyword);
		}
		
		int blockSize = 10;
		
		int lastBlock = (count + pageSize - 1) / pageSize;	
		// int lastBlock = (count - 1) / pageSize + 1;
		
		int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		
		if(endBlock > lastBlock) // 범위를 벗어나면
			endBlock = lastBlock;
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<%if(isSearch){ %>
<script>
   $(function(){
      $("#keyword").val("<%=keyword %>");
   });
</script>
<%} %>

<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>

<script src="<%=root%>/pagination/pagination.js"></script>
		<div class="row text-center">
			<h2>자료 검색</h2>
		</div>
		
		<div class="row text-center">
				<form action = "searchList.jsp" method="get">
					<select name="type">
						<option value="all">전체</option>
						<option value="book_title">서명</option>
						<option value= "book_author">저자</option>
					</select>
				
				<input type="text" name="keyword" size="50" height = "20" id = "keyword" required>
				<input type="submit" value="검색">
				</form>					
			</div> <br><br>
		
		<div class="row">
		<table class="table table-border table-hover">
				<thead>
					<tr>
						<th>썸네일</th>
						<th>책번호</th>
						<th>지점명</th>
						<th>책제목</th>
						<th>저자</th>						
						<th>상태</th>
						<th>기능</th>
					</tr>
				</thead>
				<tbody>
					<%for(GetBookSearchDto getBookSearchDto : getBookList) {							
							bookDto = bookDao.get(getBookSearchDto.getBookIsbn());
					%>
					<tr>
						<td><img src="<%=bookDto.getBookImg() %>"></td>
						<td><%=getBookSearchDto.getBookIsbn() %></td>
						<td><%=getBookSearchDto.getAreaName() %></td>					
						<td> <a href = "<%=root%>/getBook/getBookDetail.jsp?getBookNo=<%=getBookSearchDto.getGetBookNo()%>"><%=getBookSearchDto.getBookTitle()%></a></td>
						<td><%=getBookSearchDto.getBookAuthor() %></td>
						<td><%=getBookSearchDto.getGetBookStatus() %></td>
					</tr>
					<%} %>
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
	<form class="search-form" action="searchList.jsp" method="get">
		<input type="hidden" name="pageNo">
	</form>

	

</div>	

<jsp:include page="/template/footer.jsp"></jsp:include>