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

String title = "일정등록";
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
%>

<jsp:include page="/service/serviceSidebar.jsp">
	<jsp:param value="<%=title %>" name="title" />
</jsp:include>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">일정등록</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img
					alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 일정등록</span>
		</div>
		
	</div>

	<div class="float-container">
		<div class="plan left">
			<jsp:include page="/plan/calendar.jsp"></jsp:include>
		</div>

		<div class="planInsert right">
			<div class="planInsertForm">
				<form action="planInsert.kh" method="post">
					<input type="hidden"  value="<%=areaNo %>" name="areaNo">
				<div class="row">
					<input type="text" name="planContent" required autocomplete="off">
				</div>
				<div class="row">
					<input type="date" name="planStartDate" value="<%=year%>-<%=month < 10 ? "0" + Integer.toString(month) : Integer.toString(month) %>-<%=day < 10 ? "0" + Integer.toString(day) : Integer.toString(day)%>">
				</div>
				<div class="row">
					<input type="date" name="planEndDate" value="<%=year%>-<%=month < 10 ? "0" + Integer.toString(month) : Integer.toString(month) %>-<%=day < 10 ? "0" + Integer.toString(day) : Integer.toString(day)%>">
				</div>
				<div class="row">
					<input type="submit" value="등록" class="board-btn">
				</div>
				</form>
			</div>
		</div>
	</div>
</div>

		<jsp:include page="/template/footer.jsp"></jsp:include>