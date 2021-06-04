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

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	$(function(){
		$("#promotionInsert").submit(function(evt){
			<%if(areaNo == 0){%>
				window.alert("각 지점에서 배너를 등록하세요");
				evt.preventDefault();
			<%}%>
		});
	});
</script>

<form id="promotionInsert" action="promotionInsert.kh" method="post" enctype="multipart/form-data">

	<input type="hidden" name="areaNo" value="<%=areaNo %>">

	홍보파일 : <input type="file" name="promotionFile" accept=".png, .jpg, .gif">
	
	<input type="submit" value="등록">
	
	
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>