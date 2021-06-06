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

String title = "행사 일정";
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
int planPageSize = 5;
int planPageNo;
int planCount = planDao.count(year, month, day);
int lastPlanPageNo = (planCount + planPageSize - 1) / planPageSize;
try{
	planPageNo = Integer.parseInt(request.getParameter("planPageNo"));
	if(planPageNo < 1){
		planPageNo = 1;
	} else if(planPageNo > lastPlanPageNo) {
		planPageNo = lastPlanPageNo;
	}
} catch(Exception e){
	planPageNo = 1;
}

int strNum = planPageSize * planPageNo - (planPageSize-1);
int endNum = planPageSize * planPageNo;

List<PlanDto> planList;
if(areaNo == 0){
	planList = planDao.list(year, month, day, strNum, endNum);
} else{
	planList = planDao.list(year, month, day, strNum, endNum, areaNo);
}
%>

<jsp:include page="/service/serviceSidebar.jsp">
	<jsp:param value="<%=title %>" name="title" />
</jsp:include>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">행사 일정</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img
					alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 행사 일정</span>
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
						<th colspan="2" class="left">
							<%=year %>.<%=month %>.<%=day %>
						</th>
						<th class="right">
							<button class="insertBtn" onclick="location.href='planInsert.jsp?year=<%=year %>&month=<%=month %>&day=<%=day %>'">일정 등록</button>
						</th>
					</tr>
				</thead>
				<tbody>
					<%for(PlanDto planDto : planList){ %>
					<tr onclick="location.href='planEdit.jsp?planNo=<%=planDto.getPlanNo()%>'">
						<td width="15%" class="area">
							<%if(planDto.getAreaNo() > 0){ %>
							[<%=areaDao.detail(planDto.getAreaNo()).getAreaName()%>]<br>
							<%} %>
						</td>
						<td width="65%;" class="left">
							<%=planDto.getPlanContent() %>
						</td>
						<td width="20%">
							<%=planDto.getPlanStartDate() %>
							<%if(!planDto.getPlanStartDate().equals(planDto.getPlanEndDate())){ %>
								~<br><%=planDto.getPlanEndDate() %>
							<%} %>
						</td>
					</tr>
					<%} %>
				</tbody>
			</table>
			<div class="text-center">
				<%if(planPageNo > 1){ %>
				<a href="?year=<%=year %>&month=<%=month %>&day=<%=day %>&planPageNo=<%=planPageNo - 1 %>" class="upDownBtn">▲</a>
				<%} %>
				<%if(planPageNo < lastPlanPageNo){ %>
				<a href="?year=<%=year %>&month=<%=month %>&day=<%=day %>&planPageNo=<%=planPageNo + 1 %>" class="upDownBtn">▼</a>
				<%} %>
			</div>
		</div>

		<jsp:include page="/template/footer.jsp"></jsp:include>