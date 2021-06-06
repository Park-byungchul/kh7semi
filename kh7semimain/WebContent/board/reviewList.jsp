<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.board.ReviewDao"%>
<%@page import="library.beans.board.ReviewDto"%>
<%@page import="library.beans.board.ReviewListDto"%>
<%@page import="library.beans.board.ReviewListDao"%>
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
	
	ReviewListDao reviewListDao = new ReviewListDao();
	List<ReviewListDto> reviewList;
	ReviewDao reviewDao = new ReviewDao();
	
	// 시작과 끝번호
	int startRow = pageNo * pageSize - (pageSize - 1);
	int endRow = pageNo * pageSize;
	
	// 페이지 네비게이션 영역 계산
	int count;
	
	if(isSearch) count = reviewListDao.getCount(type, keyword);
	else count = reviewListDao.getCount();
	
	int blockSize = 10;
	
	int lastBlock = (count + pageSize - 1) / pageSize;	
	
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock) // 범위를 벗어나면
		endBlock = lastBlock;

	// 목록 출력 (일반 목록 / 검색)
	if(!isSearch)
		reviewList = reviewListDao.list(startRow, endRow);
	else
		reviewList = reviewListDao.search(type, keyword, startRow, endRow);
	
	// 회원 정보
	Integer clientNo = (Integer)session.getAttribute("clientNo");
	boolean isLogin = (clientNo != null);
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto;
	
	if(clientNo == null)
		clientDto = null;
	else
		clientDto = clientDao.get(clientNo);
	
	String title = "도서 리뷰";
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
				<span class="title">도서 리뷰</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 열린 공간 > 도서 리뷰</span>
			</div>
		</div>
	
	<form class="search-form text-center" action="reviewList.jsp" method="get">
		<input type="hidden" name="pageNo">
	
		<select name="type" class="select-form">
			<option value="review_subject">제목</option>
			<option value="client_name">작성자</option>
		</select>
		
		<input type="text" name="keyword" class="text-search-form" placeholder="검색어를 입력하세요" value="<%=keyword %>" required>
		<input type="submit" value="검색" class="form-btn form-btn-inline">
	</form>

	<div class="row">
		<table class="table table-border table-hover board-table">
			<thead>
				<tr>
					<th width="8%">번호</th>
					<th width="15%"></th>
					<th>리뷰 정보</th>
				</tr>
			</thead>
			
			<tbody>
				<%for(ReviewListDto reviewListDto : reviewList) { %>
				<tr>
					<%System.out.println(reviewListDto.getReviewNo()); %>
					<td><%=reviewListDto.getReviewNo() %></td>
					<td><img src=<%=reviewDao.getBookInfo(reviewListDto.getBookIsbn()).getBookImg() %>></td>
					<td align=left>
						<a href="../book/bookDetail.jsp?bookIsbn=<%=reviewListDto.getBookIsbn() %>" class="review-title">
							<%=reviewDao.getBookInfo(reviewListDto.getBookIsbn()).getBookTitle() %>
						</a>
						<p><%=reviewDao.getBookInfo(reviewListDto.getBookIsbn()).getBookAuthor() %></p>
						<p>
							<%=reviewDao.getBookInfo(reviewListDto.getBookIsbn()).getBookPublisher() %>,
							<%=reviewDao.getBookInfo(reviewListDto.getBookIsbn()).getBookDate().getYear() + 1900 %>
						</p>
						<div class="review-border">
							<a href="reviewDetail.jsp?reviewNo=<%=reviewListDto.getReviewNo()%>" class="review-subject">
								<%=reviewListDto.getReviewSubject() %>
							</a>
							<span class="review-right">
								<span><%=reviewListDto.getClientName() %></span>
								<span>&nbsp;</span>
								<span><%=reviewListDto.getReviewDate() %></span>
							</span>
						</div>
					</td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>

	<%if(isLogin) { %>
		<div class="row text-right">
			<a href="reviewWrite.jsp" class="link-btn">글쓰기</a>
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