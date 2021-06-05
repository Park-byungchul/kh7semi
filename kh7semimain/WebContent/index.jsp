<%@page import="library.beans.NewBookDto"%>
<%@page import="library.beans.NewBookDao"%>
<%@page import="library.beans.PromotionInfoDto"%>
<%@page import="library.beans.PromotionInfoDao"%>
<%@page import="library.beans.CalendarDao"%>
<%@page import="library.beans.GenreDto"%>
<%@page import="library.beans.GenreDao"%>
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
CalendarDao calendarDao = new CalendarDao();
int year;
int month;
try {
	year = Integer.parseInt(request.getParameter("year"));
	month = Integer.parseInt(request.getParameter("month"));
	if (month >= 13) {
		year++;
		month = 1;
	} else if (month <= 0) {
		year--;
		month = 12;
	}
} catch (Exception e) {
	year = calendarDao.year;
	month = calendarDao.month;
}
int first = calendarDao.first(year, month);
int last = calendarDao.last(year, month);
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
NewBookDao newBookDao = new NewBookDao();
List<NewBookDto> newBookRank = newBookDao.rank(1, 3); 


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
int areaPageSize = 6; // 1페이지에 보여줄 개수
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

PromotionInfoDao promotionInfoDao = new PromotionInfoDao();
int promotionCount;
if(areaNo != 0){
	promotionCount = promotionInfoDao.count(areaNo);
} else{
	promotionCount = promotionInfoDao.count();
}

int promotionPage;
try{
	promotionPage = Integer.parseInt(request.getParameter("promotionPage"));
	if (promotionPage < 1){
		promotionPage = promotionCount;
	} else if(promotionPage > promotionCount){
		promotionPage = 1;
	}
} catch (Exception e){
	promotionPage = 1;
}

PromotionInfoDto promotionInfoDto;
if(areaNo != 0){
	promotionInfoDto = promotionInfoDao.detail(promotionPage, areaNo);
} else{
	promotionInfoDto = promotionInfoDao.detail(promotionPage);
}
%>

<jsp:include page="/template/header.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<style>
	.float-container.recommend , .float-container.newbook {
		margin:10px;
		width:300px; 
		height:300px; 
		display:inline-block;
	}
	.recommend-input , .newbook-input{
		padding:0.2rem;
		text-align:center;
		width:300px;
		height:30px;
		display:block;
		white-space: nowrap; 
		overflow: hidden; 
		text-overflow: ellipsis;
	}
	.main-btn {
		width: 300px;
	    height: 60px;
	    margin: 10px -4px;
	    border: 1px none gray;
	    background-color:#4B97FF; 
	    color: white;
	    font-size:18px;
	}
	.main-btn:hover{
		background-color:#1359B5; 
	}
</style>
<script>
$(function(){
	$(".main-btn.recommend").on("click",function(e){
		
		$(".float-container.recommend").show();
		$(".float-container.newbook").hide();
		$(".float-container.lendbest").hide();
	});
	$(".main-btn.newbook").on("click",function(e){
		
		$(".float-container.newbook").show();
		$(".float-container.recommend").hide();
		$(".float-container.lendbest").hide();
	});
});
</script>
		<section>
			<%if(!isChild){ %>
			
				<div class="float-container row">
					<%if(startBlock > 1){ %>
						<button class="areaBtnMove left" onClick="location.href='<%=root %>?areaPageNo=<%=areaPageNo - 1 %>'">&lt;</button>
					<%} else{ %>
						<button class="areaBtnMoveInactive left">&lt;</button>
					<%} %>
				
					<div style="display: inline-block;">
						<%for (AreaDto areaList : list){ %>
							<button class="areaBtn" onClick="location.href='<%=root %>/areaSelect.kh?areaNo=<%=areaList.getAreaNo()%>&back=<%=pageNow%>'">
							<span><%=areaList.getAreaName() %></span></button>
						<%} %>
					</div>
					
					<%if(endBlock < lastBlock){ %>
						<button class="areaBtnMove right" onClick="location.href='<%=root %>?areaPageNo=<%=areaPageNo + 1 %>'">&gt;</button>
					<%} else{ %>
						<button class="areaBtnMoveInactive right">&gt;</button>
					<%} %>
				</div>
				
			<%} %>
				
				
				
				<div class="float-container row">
					<div class="promotion left">

						<%if(promotionInfoDto != null){%>
						<img id="promotionImg" src="<%=root %>/promotion/promotionFile.kh?fileNo=<%=promotionInfoDto.getFileNo() %>">
						<span>
							<%if(promotionInfoDto.getAreaNo() != 0){%>
								<%=areaDao.detail(promotionInfoDto.getAreaNo()).getAreaName() %> 
							<%} %>
						</span>
						<%} %>
						
						<button class="btn-pre" onclick="location.href='?promotionPage=<%=promotionPage -1 %>'">&lt</button>
						
						<button class="btn-next" onclick="location.href='?promotionPage=<%=promotionPage + 1 %>'">&gt</button>
						
						<span></span>
						
					</div>
					
					<div class="notice" style="display: inline-block;">
					
					</div>
					
					<div class="planIndex right">
						<jsp:include page="/plan/calendar.jsp"></jsp:include>
					</div>
				</div>

		</section>
		
		<section style="height:500px;">
		<div class="row">
		<button class="main-btn recommend">추천도서</button>
		<button class="main-btn newbook">신착도서</button>
		<button class="main-btn lendbest">대출베스트</button>
		</div>
			
			<%for(RecommendDto recommendDto : recommendRank) { %>
				<%
				String bookIsbn = recommendDto.getBookIsbn();
				BookDao bookDao = new BookDao();
				BookDto bookDto = bookDao.get(bookIsbn);
				
				GenreDao genreDao = new GenreDao();
				GenreDto genreDto = genreDao.get(bookDto.getGenreNo());
				%>	
				<div class="float-container recommend">
					<div class="row text-center">
						<img src="<%=bookDto.getBookImg()%>">
						<br>
						<span class="recommend-input"><%=bookDto.getBookTitle()%></span>
						<strong>저자</strong><span class="recommend-input"><%=bookDto.getBookAuthor()%></span>
						<strong>장르</strong><span class="recommend-input"><%=genreDto.getGenreName()%></span>
					</div>
	
				</div>
			<%} %>
			
			
			<%for(NewBookDto newBookDto : newBookRank) { %>
				<div class="float-container newbook" style="display:none;">
					<div class="row text-center">
						<img src="<%=newBookDto.getBookImg()%>">
						<br>
						<span class="newbook-input"><%=newBookDto.getBookTitle()%></span>
						<strong>저자</strong><span class="newbook-input"><%=newBookDto.getBookAuthor()%></span>
						<strong>장르</strong><span class="newbook-input"><%=newBookDto.getGenreName()%></span>
					</div>
	
				</div>
			<%} %>
		</section>
		
<jsp:include page="/template/footer.jsp"></jsp:include>