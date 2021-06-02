<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<h3>마이페이지</h3>
<ul>
	<li><a href="<%=root %>/client/clientDetail.jsp">회원 정보</a></li>
	<li><a href="#">대출/예약/신청 도서 관리</a></li>
	<li><a href="#">관심도서</a></li>
</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>