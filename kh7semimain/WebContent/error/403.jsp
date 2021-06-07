<%@page import="library.beans.LendBookDto"%>
<%@page import="library.beans.LendBookDao"%>
<%@page import="library.beans.board.BoardListDto"%>
<%@page import="library.beans.board.BoardListDao"%>
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
LendBookDao lendBookDao = new LendBookDao();
List<LendBookDto> lendBookRank = lendBookDao.rank(1, 3);


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

	BoardListDao boardListDao = new BoardListDao();
	
	List<BoardListDto> noticeList;
	if(areaNo == 0)
		noticeList = boardListDao.mainNotice();
	else 
		noticeList = boardListDao.mainNotice(areaNo);
%>

<jsp:include page="/template/header.jsp">
	<jsp:param value="<%=title %>" name="title" />
</jsp:include>

<div class="main">
		<div class="text-center" style="padding: 100px 0px;">
			<span style="font-size: 100px; font-weight: bold;">403 ERROR</span>
		</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
