<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="library.beans.LendBookDto"%>
<%@page import="library.beans.LendBookDao"%>
<%@page import="java.util.List"%>
    
<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>	
<%
	String root = request.getContextPath();
	LendBookDao lendBookDao = new LendBookDao();
	
	request.setCharacterEncoding("UTF-8");
	String keyword = request.getParameter("keyword");
	boolean isSearch = keyword != null;
	
	
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
	
	
	
	List<LendBookDto> lendBookList;
 	if(keyword == null) {
 			lendBookList = lendBookDao.list(startRow, endRow);
 			count = lendBookDao.getCount();
 		}
 		else{
 			lendBookList = lendBookDao.list(Integer.parseInt(keyword), startRow, endRow);
 			count = lendBookDao.getCount(Integer.parseInt(keyword));
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


<script src="<%=root%>/pagination/pagination.js"></script>
		<div class="row text-center">
			<h2>대여 목록</h2>
		</div>
		
		<div class="row text-center">
			<form action = "lendBookList.jsp" method="get">
				
				
				<input type="text" name="keyword" size="50" height="20" id = "keyword" placeholder="회원번호 입력">
				<input type="submit" value="검색">
			</form>
		</div> <br><br>
		
	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>입고번호</th>
					<th>책제목</th>
					<th>대출일</th>
					<th>반납기한</th>
				</tr>
			</thead>
			<tbody>
				<%for(LendBookDto lendBookDto : lendBookList) {%>
					<tr>
						<td><%=lendBookDto.getClientNo() %></td>					
						<td><%=lendBookDto.getGetBookNo() %></td>
						<td> <a href = "<%=root%>/getBook/getBookDetail.jsp?getBookNo=<%=lendBookDto.getGetBookNo()%>"><%=lendBookDto.getBookTitle()%></a></td>
						<td><%=lendBookDto.getLendBookDate() %></td>
						<td><%=lendBookDto.getLendBookLimit() %></td>
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
	<form class="search-form" action="lendBookList.jsp" method="get">
		<input type="hidden" name="pageNo">
	</form>
	
<jsp:include page="/template/footer.jsp"></jsp:include>