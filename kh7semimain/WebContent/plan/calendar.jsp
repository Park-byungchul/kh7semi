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
%>


				
				<table cellpadding="0" cellspacing="0" id="calendar">
		
					<tr height="15%;">
						
						<th id="title" colspan="7">
						<a href ="?year=<%=year%>&month=<%=month - 1%>">&lt</a>
						<%=year%>년 <%=month%>월
						<a href ="?year=<%=year%>&month=<%= month + 1%>">&gt</a>
						</th>
						
					</tr>
					
					<tr height="12%;">
						<td class="sun">일</td>
						<td>월</td>
						<td>화</td>
						<td>수</td>
						<td>목</td>
						<td>금</td>
						<td class="sat">토</td>
					</tr>
		
					<tr>
						<% for(int i = 1 ; i <= first ; i++){ %>
							<td></td>
						<%} %>
		
						<% for(int i = 1 ; i <= last ; i++){ %>
								<td onclick="location.href='<%=root %>/plan/planList.jsp?year=<%=year %>&month=<%=month %>&day=<%=i %>'" class="<%=calendarDao.isToday(year, month, i) %>"><%=i %></td>
								<%if(calendarDao.isToday(year, month, i) == "saturday"){%>
									</tr><tr>
								<%} %>
						<%} %>
					</tr>
		
				</table>