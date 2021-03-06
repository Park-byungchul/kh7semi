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
	<h2>해당 도서는 대여가 불가능합니다.</h2>
	<br><br><br>
	<h4>가능한 오류</h4>
	<h5>1. 회원 번호나 책번호를 잘못 입력한 것일 수 있습니다.</h5>
	<h5>2. 해당 지점의 도서가 맞는지 확인해주세요.</h5>
<jsp:include page="/template/footer.jsp"></jsp:include>