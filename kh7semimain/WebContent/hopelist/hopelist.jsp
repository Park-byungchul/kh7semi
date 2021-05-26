<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.HopelistDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.HopelistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<%
	request.setCharacterEncoding("UTF-8");
	HopelistDao hopelistDao = new HopelistDao();
	List<HopelistDto> hopelist = hopelistDao.list();
	
	
	int pageNo;//현재 페이지 번호
	try{
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		if(pageNo < 1) {
			throw new Exception();
		}
	}
	catch(Exception e){
		pageNo = 1;//기본값 1페이지
	}
	
	int pageSize;
	try{
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if(pageSize < 10){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 10;//기본값 10개
	}
	
	//(2) rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	int count  = hopelistDao.getCount();
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
// 	int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
	}

%>
<div class="container-600">
	<div class="row">
		<h2>희망도서 신청 목록페이지</h2>
	</div>
	
	<div class="row text-right">
		<a href="hopelistInsert.jsp" class="link-btn">신청하기</a>
	</div>
	
	<div class="row">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>번호</th>
					<th>도서관</th>
					<th width="30%">도서명</th>
					<th>저자</th>
					<th>신청일</th>
				</tr>
			</thead>
			
			<tbody>
				<%for(HopelistDto hopelistDto : hopelist){ %>
				<tr>
					<td><%=hopelistDto.getHopelistNo()%></td>
					<td><%=hopelistDto.getHopelistLibrary()%></td>
					<td class="text-left">	
						<!-- 제목을 누르면 상세보기 페이지로 이동한다 -->
						<a href="hopelistDetail.jsp?hopelistNo=<%=hopelistDto.getHopelistNo()%>">
							<%
							BookDao bookDao = new BookDao();
							BookDto bookDto = bookDao.get(hopelistDto.getBookIsbn());
							%>
							<%=bookDto.getBookTitle() %>
						</a>
					</td>
					<td><%=bookDto.getBookAuthor()%></td>
					<td><%=hopelistDto.getHopelistDate()%></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	
	<div class="row text-right">
		<a href="hopelistInsert.jsp" class="link-btn">신청하기</a>
	</div>
	
	<div class="row">
		<!-- 페이지 네비게이션 자리 -->
		<div class="pagination">
		
			<%if(startBlock > 1){ %>
			<a class="move-link">이전</a>
			<%} %>
			
			<%for(int i = startBlock; i <= endBlock; i++){ %>
				<%if(i == pageNo){ %>
					<a class="on"><%=i%></a>
				<%}else{ %>
					<a><%=i%></a>
				<%} %>
			<%} %>
			
			<%if(endBlock < lastBlock){ %>
			<a class="move-link">다음</a>
			<%} %>
			
		</div>	
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>