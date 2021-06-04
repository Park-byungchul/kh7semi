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
%>

<jsp:include page="/service/serviceSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

	<div class="main">
		<div class="header">
			<div class="row">
				<span class="title">행사일정</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 행사일정</span>
			</div>
		</div>
		
		<div class="section plan">
			<jsp:include page="/plan/calendar.jsp"></jsp:include>
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>