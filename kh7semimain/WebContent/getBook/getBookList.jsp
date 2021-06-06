<%@page import="library.beans.AreaDao"%>
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
	
	int clientNo;
	try {
		clientNo = (int)session.getAttribute("clientNo");
	
	}
	catch (Exception e){
		clientNo = 0;
	}

	
// 브라우저 이름 정하기
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

	//--------------------------------
	request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");

	boolean isLogin = session.getAttribute("clientNo") != null;
// 	List<GetBookSearchDto> getBookList;
// 		//select값이 기본 -> '전체' 값을 null로 주고 keyword만 전송
// 		if(type == null && keyword == null) {
// 			getBookList = getBookSearchDao.list(startRow, endRow);
// 		}
// 		else if(type.equals("all") || type.equals(null)){
// 			getBookList = getBookSearchDao.searchList(keyword);
// 		}
// 		else{ //select가 '전체'가 아니면 type과 keyword 같이 전송
// 			getBookList = getBookSearchDao.searchList(type, keyword);
// 		}
//-----------------------------------
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
		count  = getBookSearchDao.getCount();
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
<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>


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
<div class="container-900">
	<div class="row text-center">
		<h2>입고된 도서 목록</h2>
	</div>
	<div class="row text-center search-form">
				<form  class="search-form" action = "getBookList.jsp" method="get">
					<select name="type">
						<option value="all">전체</option>
						<option value="book_title">서명</option>
						<option value= "book_author">저자</option>
					</select>
				
				<input type="text" name="keyword" class="text-search-form" size="50" height = "20" >
				<input type="submit" class="form-btn form-btn-inline" value="검색">
				</form>					
			</div>
	<div class="row text-right">
		<a class="link-btn" href="getBookInsert.jsp">입고하기</a>
	</div>
	
	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>입고번호</th>
					<th>도서명</th>
					<th>저자</th>
					<th>썸네일</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
				<%for (GetBookSearchDto getBookSearchDto : getBookList) { 
	
				%>
				<tr>
					<td><%=getBookSearchDto.getGetBookNo()%></td>
					<td><%=getBookSearchDto.getBookTitle()%></td>
					<td><%=getBookSearchDto.getBookAuthor()%></td>
					<td><img src="<%=getBookSearchDto.getBookImg() %>"></td>
					<td class="bookList">
					<button class="board-btn"><a class="btn-text" href="getBookEdit.jsp?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>">수정</a></button>
					<button class="board-btn"><a class="getBookDelete btn-text" href="getBookDelete.kh?getBookNo=<%=getBookSearchDto.getGetBookNo()%>">삭제</a></button>
					<button class="board-btn"><a class="btn-text" href="bookDetail.jsp?bookIsbn=<%=getBookSearchDto.getBookIsbn()%>">상세보기</a></button>
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
  
	<form action="bookList.jsp" method="get" class="">
		<input type="hidden" name="pageNo">
	</form>

	<div class="row text-right">
		<a class="link-btn" href="getBookInsert.jsp">책 등록하기</a>
	</div>

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>