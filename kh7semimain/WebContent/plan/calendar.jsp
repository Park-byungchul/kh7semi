<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.PlanDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="library.beans.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>

<%
	String root = request.getContextPath();
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
	
	PlanDao planDao = new PlanDao();
	
	AreaDao areaDao = new AreaDao();
	
	int areaNo;
	try{
		areaNo = (int)session.getAttribute("areaNo");
	}
	catch (Exception e){
		areaNo = 0;
	}
	
%>


				
				<table cellpadding="0" cellspacing="0" id="calendar">
		
					<tr height="25%;">
						
						<th id="title" colspan="7">
							<div class="float-container">
								<div class="left">
									<a class="preMonth" href ="?year=<%=year%>&month=<%=month - 1%>">&lt</a>
									<a href="<%=root %>/plan/plan.jsp?year=<%=year %>&month=<%=month %>"><%=year%>.<%=month%></a>
									<a class="nextMonth" href ="?year=<%=year%>&month=<%= month + 1%>">&gt</a>
								</div>
								
								<div class="right">
									<span class="breakDay">■ 휴관일</span>
									<span class="planDay">■ 행사일</span>
								</div>
							</div>
						</th>
						
					</tr>
					
					<tr height="10%;">
						<th class="week">일</th>
						<th class="week">월</th>
						<th class="week">화</th>
						<th class="week">수</th>
						<th class="week">목</th>
						<th class="week">금</th>
						<th class="week">토</th>
					</tr>
		
					<tr>
						<% for(int i = 1 ; i <= first ; i++){ %>
							<td></td>
						<%} %>
		
						<% for(int i = 1 ; i <= last ; i++){ %>
								<td onclick="location.href='<%=root %>/plan/plan.jsp?year=<%=year %>&month=<%=month %>&day=<%=i %>'" class="<%=calendarDao.isToday(year, month, i) %>
									<%String today = Integer.toString(year) + (month < 10 ? "0" + Integer.toString(month) : Integer.toString(month)) + (i < 10 ? "0" + Integer.toString(i) : Integer.toString(i)); %>
									
									<%if(areaNo == 0){ %>
										
										<%if(planDao.isBreakDay(today)){ %> breakDay
										<%}else if(!planDao.isBreakDay(today) && planDao.isPlanDay(today)){ %>planDay
										<%} %>
									
									<%} else {%>
									
										<%if(planDao.isBreakDay(today, areaNo)){ %> breakDay
										<%}else if(!planDao.isBreakDay(today, areaNo) && planDao.isPlanDay(today, areaNo)){ %>planDay
										<%} %>
									
									<%} %>
										
								"><%=i %>
									
								</td>
								
								<%if(calendarDao.isToday(year, month, i) == "saturday"){%>
									</tr><tr>
								<%} %>
						<%} %>
					</tr>
		
				</table>