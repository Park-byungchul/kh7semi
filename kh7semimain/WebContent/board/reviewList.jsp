<%@page import="library.beans.ReviewListDto"%>
<%@page import="library.beans.ReviewListDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	/////// 리뷰 테이블로 바꿔야 함 ///////

	request.setCharacterEncoding("UTF-8");

	// 검색 변수
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
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
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<%if(isSearch) { %>
	<script>
		$(function() {
			$("select[name=type]").val("<%=type%>");
			$("input[name=keyword]").val("<%=keyword%>");
		});
	</script>
<%} %>

<script>
	$(function() {
		$(".pagination > a").click(function() {
			var pageNo = $(this).text();
			
			if(pageNo == "이전") {
				pageNo = parseInt($(".pagination > a :not(.move-link)").first().text()) - 1;
				$("input[name=pageNo]".val(pageNo));
				$(".serach-form").submit();
			}
			else if(pageNo == "다음") {
				pageNo = parseInt($(".pagination > a:not(.move-link)").last().text()) + 1;
				$("input[name=pageNo]".val(pageNo));
				$(".serach-form").submit();
			}
			else {
				$("input[name=pageNo]".val(pageNo));
				$(".serach-form").submit();
			}
		});
	});
</script>

<div class="container-1000">
	<div class="row text-left">
		<h2>도서 리뷰</h2>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
					<th>좋아요</th>
				</tr>
			</thead>
			
			<tbody>
				<%for(ReviewListDto reviewListDto : reviewList) { %>
				<tr>
					<td><%=reviewListDto.getReviewNo() %></td>
					<td align=left>
						<a href="reviewDetail.jsp?reviewNo=<%=reviewListDto.getReviewNo()%>">
							<%=reviewListDto.getReviewSubject() %>
						</a>
						<%if(reviewListDto.getReviewReply() > 0){ %>
							[<%=reviewListDto.getReviewReply()%>]
						<%} %>
					</td>
					<td><%=reviewListDto.getClientName() %></td>
					<td><%=reviewListDto.getReviewDate() %></td>
					<td><%=reviewListDto.getReviewRead() %></td>
					<td><%=reviewListDto.getReviewLike() %></td>
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
	
	<div class="row">
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
	
	<form class="search-form" action="reviewList.jsp" method="get">
		<input type="hidden" name="pageNo">
	
		<select name="type">
			<option value="review_subject">제목</option>
			<option value="client_name">작성자</option>
		</select>
		
		<input type="text" name="keyword" placeholder="검색어를 입력하세요" required>
		<input type="submit" value="검색" class="btn-style">
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>