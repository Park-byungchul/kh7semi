<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<h2>열린 공간</h2>
<ul>
	<li><a href="<%=root %>/board/noticeList.jsp">공지사항</a></li>
	<li><a href="<%=root %>/board/qnaList.jsp">질문 답변</a></li>
	<li><a href="<%=root %>/board/freeBoardList.jsp">자유게시판</a></li>
	<li><a href="<%=root %>/board/reviewList.jsp">도서리뷰</a></li>
</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>