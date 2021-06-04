<%@page import="library.beans.PromotionInfoDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.PromotionInfoDao"%>
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

PromotionInfoDao promotionInfoDao = new PromotionInfoDao();
List<PromotionInfoDto> list = promotionInfoDao.list();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<%for(PromotionInfoDto promotionInfoDto : list){ %>

	<%if(promotionInfoDto.getFileNo() > 0){ %>
		<h3><%=promotionInfoDto.getPromotionNo() %></h3>
		<img src="promotionFile.kh?fileNo=<%=promotionInfoDto.getFileNo() %>" width="200" height="200">
		<a href="promotionFile.kh?fileNo=<%=promotionInfoDto.getFileNo() %>">다운로드</a>
		<h3><%=promotionInfoDto.getAreaNo() %></h3>
	<%} %>

<%} %>

<jsp:include page="/template/footer.jsp"></jsp:include>