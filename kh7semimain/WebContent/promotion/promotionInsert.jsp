<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<form id="promotionInsert" action="promotionInsert.kh" method="post" enctype="multipart/form-data">

	<input type="hidden" name="areaNo" value="<%=areaNo %>">

	홍보파일 : <input type="file" name="promotionFile" accept=".png, .jpg, .gif">
	
	<input type="submit" value="등록">
	
	
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>