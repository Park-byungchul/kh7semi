<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<script>
	$(function(){

		$(".menuItem").each(function(index, data){
			if(window.location.pathname == $(this).attr('href')){
				$(this).addClass("active");
			}
		});

	});
</script>

<div class="sidebarContainer">
	<span class="sidebarTitle">도서관 소개</span>
	
	<ul class="sidebarMenu">
		<li><a class="menuItem" href="<%=root %>/location/location.jsp">찾아오는길</a></li>
		<li><a class="menuItem" href="<%=root %>/dataStatus/dataStatus.jsp">자료현황</a></li>
		<li><a class="menuItem" href="<%=root %>/useInfo/useInfo.jsp">이용 안내</a></li>
	</ul>
</div>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>