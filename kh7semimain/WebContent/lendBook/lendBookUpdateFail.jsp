<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	AreaDao areaDao = new AreaDao();
	int areaNo;
	try{
		areaNo = (int)session.getAttribute("areaNo");
	}
	catch (Exception e){
		areaNo = 0;
	}
	
	String title = "관리자 메뉴";
	if(areaNo > 0){
		title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>
<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>
	<h2>해당 도서는 대여중인 책이 아닙니다.</h2>
	<br><br><br>
	<h4>가능한 오류</h4>
	<h5>1. 대여를 해야 하는 데 반납으로 했을 수 있습니다.</h5>
	<h5>2. 이미 반납 완료된 책을 2번 찍은 것일 수 있습니다.</h5>
<jsp:include page="/template/footer.jsp"></jsp:include>