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

String title = "행사일정";
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
List<PlanDto> planList = planDao.list(year, month, day);
%>

<jsp:include page="/service/serviceSidebar.jsp">
	<jsp:param value="<%=title %>" name="title" />
</jsp:include>

<div class="main">
	<div class="header">
		<div>
			<span class="title">행사일정</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img
					alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 행사일정</span>
		</div>
		
	</div>

	<div class="float-container">
		<div class="plan left">
			<jsp:include page="/plan/calendar.jsp"></jsp:include>
		</div>

		<div class="planList right">
			<table class="planTable">
				<thead>
					<tr>
						<th colspan="2">
							<%=year %>.<%=month %>.<%=day %>
						</th>
					</tr>
				</thead>
				<tbody>
					<%for(PlanDto planDto : planList){ %>
					<tr>
						<td width="30%;"><%=planDto.getPlanContent() %></td>
						<%if(planDto.getPlanStartDate().equals(planDto.getPlanEndDate())){ %>
						<td><%=planDto.getPlanStartDate() %></td>
						<%}else{ %>
						<td><%=planDto.getPlanStartDate() %>~<%=planDto.getPlanEndDate() %></td>
						<%} %>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>

		<jsp:include page="/template/footer.jsp"></jsp:include>