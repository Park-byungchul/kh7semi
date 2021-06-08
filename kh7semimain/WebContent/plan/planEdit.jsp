<%@page import="java.util.Calendar"%>
<%@page import="library.beans.PlanDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.PlanDao"%>
<%@page import="library.beans.CalendarDao"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String root = request.getContextPath();
AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "일정수정";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}

int year;
int month;
int day;

CalendarDao calendarDao = new CalendarDao();

try{
	year = Integer.parseInt(request.getParameter("year"));
	month = Integer.parseInt(request.getParameter("month"));
	day = Integer.parseInt(request.getParameter("day"));
	int lastDay;
			
	if (month >= 13) {
		year++;
		month = 1;
	} else if (month <= 0) {
		year--;
		month = 12;
	} else if(day <= 0){
		month--;
		day = calendarDao.last(year, month);
	} else if(day > calendarDao.last(year, month)){
		month++;
		day = 1;
	}
	
} catch(Exception e){
	year = calendarDao.year;
	month = calendarDao.month;
	day = calendarDao.day;
}

PlanDao planDao = new PlanDao();
int planNo = Integer.parseInt(request.getParameter("planNo"));
PlanDto planDto = planDao.detail(planNo);
%>

<jsp:include page="/service/serviceSidebar.jsp">
	<jsp:param value="<%=title %>" name="title" />
</jsp:include>

<div class="main">
	<div class="header">
		<div>
			<span class="title">일정수정</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img
					alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 일정수정</span>
		</div>
		
	</div>

	<div class="float-container">
		<div class="plan left">
			<jsp:include page="/plan/calendar.jsp"></jsp:include>
		</div>

		<div class="planInsert right">
			<div class="planInsertForm">
				<form action="planEdit.kh" method="post">
					<input type="hidden" value="<%=planDto.getPlanNo() %>" name="planNo">
					<input type="hidden"  value="<%=areaNo %>" name="areaNo">
				<div class="row">
					<input type="text" name="planContent" value="<%=planDto.getPlanContent()%>" required autocomplete="off">
				</div>
				<div class="row">
					<input type="date" name="planStartDate" value="<%=planDto.getPlanStartDate()%>">
				</div>
				<div class="row">
					<input type="date" name="planEndDate" value="<%=planDto.getPlanEndDate()%>">
				<div class="row">
					<input type="submit" value="수정" class="board-btn">
				</form>
					<button class="board-btn"><a class="btn-text" href="plan.jsp">취소</a></button>
					<button class="board-btn"><a class="btn-text" href="planDelete.kh?planNo=<%=planDto.getPlanNo()%>">삭제</a></button>
				</div>
			</div>
		</div>

		<jsp:include page="/template/footer.jsp"></jsp:include>