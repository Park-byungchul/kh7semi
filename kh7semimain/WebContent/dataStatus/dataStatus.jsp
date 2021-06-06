<%@page import="library.beans.BookCountDao"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	AreaDao areaDao = new AreaDao();
	String root = request.getContextPath();
	request.setCharacterEncoding("UTF-8");
	int areaNo;
	try {
		areaNo = (int)session.getAttribute("areaNo");
		
	}
	catch (Exception e) {
		areaNo = 0;
	}

	BookCountDao bookCountDao = new BookCountDao();

String title = "자료 현황";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}

%>

<jsp:include page="/location/locationSidebar.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>

	<div class="main">
		<div class="header">
			<div class="row">
				<span class="title">자료현황</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 도서관 소개 > 자료현황</span>
			</div>
		</div>
		
		<div class="container-800">
			
				<h3>전체 도서</h3>
					<table class="table table-border table-hover text-center">
						<tr>
							<th>전체도서관</th>
							<th>당산도서관</th>
							<th>종로도서관</th>
							<th>강남도서관</th>
						</tr>
						<tr>
							<td><%=bookCountDao.count()%></td>
							<td><%=bookCountDao.count(1) %></td>
							<td><%=bookCountDao.count(2) %></td>
							<td><%=bookCountDao.count(3) %></td>	
						</tr>
					</table>
					
					<br><br><br>
					
					<h3>대여 가능 도서</h3>
					<table class="table table-border table-hover text-center">
						<tr>
							<th>전체도서관</th>
							<th>당산도서관</th>
							<th>종로도서관</th>
							<th>강남도서관</th>
						</tr>
						<tr>
							<td><%=bookCountDao.lendAbleCount()%></td>
							<td><%=bookCountDao.lendAbleCount(1) %></td>
							<td><%=bookCountDao.lendAbleCount(2) %></td>
							<td><%=bookCountDao.lendAbleCount(3) %></td>	
						</tr>
					</table>
		</div>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>