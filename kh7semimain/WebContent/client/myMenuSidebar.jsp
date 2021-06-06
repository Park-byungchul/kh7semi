<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

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
	<span class="sidebarTitle">마이페이지</span>
	
	<ul class="sidebarMenu">
		<li><a class="menuItem" href="<%=root %>/client/clientDetail.jsp">회원 정보</a></li>
		<li><a class="menuItem" href="#">대출/예약/신청 도서 관리</a></li>
		<li><a class="menuItem" href="#">관심도서</a></li>
	</ul>
</div>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>