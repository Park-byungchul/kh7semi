<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.RecommendDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.RecommendDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("UTF-8");
String pageNow = request.getRequestURI();

String root = request.getContextPath();
int areaNo;
AreaDao areaDao = new AreaDao();

try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}
AreaDto areaDto = areaDao.detail(areaNo);
boolean isChild = areaNo != 0;	

RecommendDao recommendDao = new RecommendDao();
List<RecommendDto> recommendRank = recommendDao.rank(1, 3);

request.setCharacterEncoding("UTF-8");

String title;
if(areaNo > 0){
	title =areaDto.getAreaName();
} else {
 title = "메인 도서관";
}



int areaPageNo;
try{
	areaPageNo = Integer.parseInt(request.getParameter("areaPageNo"));
}
catch (Exception e){
	areaPageNo = 1;
}

int areaPageSize = 5; // 1페이지에 보여줄 개수

// rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
int strNum = areaPageSize * areaPageNo - (areaPageSize-1);
int endNum = areaPageSize * areaPageNo;

List<AreaDto> list = areaDao.list(strNum, endNum);
int count = areaDao.getCount();

int blockSize = 1;
int lastBlock = (count + areaPageSize - 1) / areaPageSize;
int startBlock = (areaPageNo - 1) / blockSize * blockSize + 1;
int endBlock = startBlock + blockSize - 1;

if(endBlock > lastBlock){ // 범위를 벗어나면
endBlock = lastBlock; // 범위를 수정
}


%>

<jsp:include page="/template/header.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<style>
	
	.promotion, .notice, .plan{
		width: 32%;
		height: 300px;
	}
</style>
	
		<section>
			<%if(isChild){ %>
			
				<h1><%=areaDto.getAreaName() %> 메인</h1>
				
			<%} else{ %>
				
				<div class="float-container row">
					<%if(startBlock > 1){ %>
						<button class="areaBtnMove left" onClick="location.href='<%=root %>?areaPageNo=<%=areaPageNo - 1 %>'">이전</button>
					<%} else{ %>
						<button class="areaBtnMoveNone left"></button>
					<%} %>
				
					<div style="display: inline-block;">
						<%for (AreaDto areaList : list){ %>
							<button class="areaBtn" onClick="location.href='<%=root %>/areaSelect.kh?areaNo=<%=areaList.getAreaNo()%>&back=<%=pageNow%>'">
							<span><%=areaList.getAreaName() %></span></button>
						<%} %>
					</div>
					
					<%if(endBlock < lastBlock){ %>
						<button class="areaBtnMove right" onClick="location.href='<%=root %>?areaPageNo=<%=areaPageNo + 1 %>'">다음</button>
					<%} else{ %>
						<button class="areaBtnMoveNone right"></button>
					<%} %>
				</div>
				
				<div class="float-container row">
					<div class="promotion left">
            
					</div>
					
					<div class="notice" style="display: inline-block;">
					
					</div>
					
					<div class="plan right">
					
					</div>
				</div>
			<%} %>
		</section>
		
		<section>
			<p>추천도서-추천수순위 프로토타입</p>
			<%for(RecommendDto recommendDto : recommendRank) { %>
				<%
				String bookIsbn = recommendDto.getBookIsbn();
				BookDao bookDao = new BookDao();
				BookDto bookDto = bookDao.get(bookIsbn);
				%>
				
 				isbn= <%=recommendDto.getBookIsbn()%>
				저자= <%=bookDto.getBookAuthor()%>
				제목= <%=bookDto.getBookTitle()%>
				장르= <%=bookDto.getGenreNo()%><br>
			<%} %>
		</section>
		
<jsp:include page="/template/footer.jsp"></jsp:include>