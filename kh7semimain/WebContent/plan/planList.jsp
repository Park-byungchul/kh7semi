<%@page import="java.util.List"%>
<%@page import="library.beans.PlanDto"%>
<%@page import="library.beans.CalendarDao"%>
<%@page import="library.beans.PlanDao"%>
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

String title = "일정 목록";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}

int year;
int month;
int day;

boolean isDetail;

CalendarDao calendarDao = new CalendarDao();

try{
	year = Integer.parseInt(request.getParameter("year"));
	month = Integer.parseInt(request.getParameter("month"));
	day = Integer.parseInt(request.getParameter("day"));
	isDetail = true;
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
	year = 0;
	month = 0;
	day = 0;
	isDetail = false;
}

PlanDao planDao = new PlanDao();
List<PlanDto> planList = planDao.list(year, month, day);
%>

<jsp:include page="/service/serviceSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

	<div class="main">
		<div class="header">
			<div class="row">
				<span class="title">일정 목록</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 행사일정 > 일정 목록</span>
			</div>
		</div>
		
		
			<%if(!isDetail){ %>
			<div class="section plan">
				<jsp:include page="/plan/calendar.jsp"></jsp:include>
			</div>
			<%} else{ %>
			<div class="calendarDetail">
				<table class="table" id="calendar">
					<thead>
						<tr>
							<th colspan="3">
								<a href ="?year=<%=year%>&month=<%=month%>&day=<%=day - 1%>">&lt</a>
									<%=year %>년 <%=month %>월 <%=day %>일
								<a href ="?year=<%=year%>&month=<%=month%>&day=<%=day + 1%>">&gt</a>
							</th>
						</tr>
						<tr>
							<th>일정내용
							</th>
							<th>시작일
							</th>
							<th>종료일
							</th>
						</tr>
					</thead>
					<tbody>
						<%for(PlanDto planDto : planList){ %>
						<tr>
							<td>
							<%=planDto.getPlanContent() %>
							</td>
							<td>
							<%=planDto.getPlanStartDate() %>
							</td>
							<td>
							<%=planDto.getPlanEndDate() %>
							</td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div>
			<%} %>

<jsp:include page="/template/footer.jsp"></jsp:include>