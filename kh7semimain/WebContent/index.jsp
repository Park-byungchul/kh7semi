<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int libraryNo;
AreaDao areaDao = new AreaDao();
AreaDto areaDto;
try{
	libraryNo = Integer.parseInt(request.getParameter("libraryNo"));
	areaDto = areaDao.detail(libraryNo);
}
catch(Exception e){
	libraryNo = 0;
	areaDto = null;
}
boolean isChild = libraryNo != 0;	


%>

<jsp:include page="/template/header.jsp"></jsp:include>

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
	<h1>메인</h1>
	<%} %>
</section>


<div>
<article>

<jsp:include page="/template/footer.jsp"></jsp:include>