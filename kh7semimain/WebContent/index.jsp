<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int areaNo;
AreaDao areaDao = new AreaDao();
AreaDto areaDto;
try{
	areaNo = (int)session.getAttribute("areaNo");
	areaDto = areaDao.detail(areaNo);
}
catch (Exception e){
	areaNo = 0;
	areaDto = null;
}
boolean isChild = areaNo != 0;	

%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div>
	<article>
		<header>
			<form action="#" method="post">
				<input type="text" placeholder="통합 검색">
				<input type="submit" value="검색">
			</form>
		</header>
	
		<section>
			<%if(isChild){ %>
			<h1><%=areaDto.getAreaName() %> 메인</h1>
			<%}else{ %>
			<h1>통합도서관 메인</h1>
			<%} %>
		</section>

<jsp:include page="/template/footer.jsp"></jsp:include>