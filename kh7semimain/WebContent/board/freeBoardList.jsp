<%@page import="library.beans.board.BoardListDto"%>
<%@page import="library.beans.board.BoardListDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

	String root = request.getContextPath();

	// 검색 변수
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
	if(keyword == null)
		keyword = "";
	
	boolean isSearch = type != null && keyword != null && !keyword.trim().equals("");
	
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
	
	BoardListDao boardListDao = new BoardListDao();
	List<BoardListDto> boardList;
	
	// 시작과 끝번호
	int startRow = pageNo * pageSize - (pageSize - 1);
	int endRow = pageNo * pageSize;
	
	// 페이지 네비게이션 영역 계산
	int count;
	
	if(isSearch) count = boardListDao.getCount(type, keyword, 3);
	else count = boardListDao.getCount(3);
	
	int blockSize = 10;
	
	int lastBlock = (count + pageSize - 1) / pageSize;	
	
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock) // 범위를 벗어나면
		endBlock = lastBlock;

	// 목록 출력 (일반 목록 / 검색)
	if(!isSearch)
		boardList = boardListDao.list(3, startRow, endRow);
	else
		boardList = boardListDao.search(3, type, keyword, startRow, endRow);
	
	// 회원 정보
	Integer clientNo = (Integer)session.getAttribute("clientNo");
	boolean isLogin = (clientNo != null);
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto;
	
	if(clientNo == null)
		clientDto = null;
	else
		clientDto = clientDao.get(clientNo);
	
	String title = "자유게시판";
%>

<jsp:include page="/board/boardMenuSidebar.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>

<%if(isSearch) { %>
	<script>
		$(function() {
			$("select[name=type]").val("<%=type%>").prop("selected", true);
			$("input[name=keyword]").val("<%=keyword%>");
		});
	</script>
<%} %>

<script>
	$(function() {
		$(".pagination > a").click(function(){
			var pageNo = $(this).text();
			
			if(pageNo == "이전") {
				pageNo = parseInt($(".pagination > a:not(.move-link)").first().text()) - 1;
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();
			}	
			else if(pageNo == "다음") {
				pageNo = parseInt($(".pagination > a:not(.move-link)").last().text()) + 1;
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();
			}
			else {
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();
			}
		});
	});
</script>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">자유게시판</span>
		</div>
				
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 열린 공간 > 자유게시판</span>
		</div>
	</div>
	
	<form class="search-form search-form-back text-center" action="freeBoardList.jsp" method="get">
		<input type="hidden" name="pageNo">
	
		<select name="type" class="select-form">
			<option value="board_title">제목</option>
			<option value="client_name">작성자</option>
		</select>
		
		<input type="text" name="keyword" value="<%=keyword %>" class="text-search-form" placeholder="검색어를 입력하세요" required>
		<input type="submit" value="검색" class="form-btn form-btn-inline">
	</form>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th width="8%">번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th width="8%">조회</th>
					<th width="8%">추천</th>
				</tr>
			</thead>
			
			<tbody>
				<%for(BoardListDto boardListDto : boardList) { %>
				<tr>
					<td><%=boardListDto.getBoardSepNo() %></td>
					<td align=left>
						<a href="boardDetail.jsp?boardNo=<%=boardListDto.getBoardNo()%>">
							<%=boardListDto.getBoardTitle() %>
						</a>
						<%if(boardListDto.getBoardReply() > 0){ %>
							[<%=boardListDto.getBoardReply()%>]
						<%} %>
					</td>
					<td><%=boardListDto.getClientName() %></td>
					<td><%=boardListDto.getBoardDate() %></td>
					<td><%=boardListDto.getBoardRead() %></td>
					<td><%=boardListDto.getBoardLike() %></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>

	<%if(isLogin) { %>
		<div class="row text-right">
			<a href="boardWrite.jsp?boardTypeNo=3" class="link-btn">글쓰기</a>
		</div>
	<%} %>
	
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
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>