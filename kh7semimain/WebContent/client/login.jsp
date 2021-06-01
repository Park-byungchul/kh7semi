<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
AreaDao areaDao = new AreaDao();
int areaNo;
try {
	areaNo = (int) session.getAttribute("areaNo");
} catch (Exception e) {
	areaNo = 0;
}

String title = "로그인";
if (areaNo > 0) {
	title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>

<jsp:include page="/template/header.jsp">
	<jsp:param value="<%=title%>" name="title" />
</jsp:include>

<div>
	<article>
		<header>
			<h2>로그인</h2>
		</header>
		<section>
			<form action="login.kh" method="post">
				<label>ID : </label><input type="text" name="clientId"><br>
				<br> <label>PW : </label><input type="password" name="clientPw"><br>
				<br> <input type="submit" value="로그인">
			</form>
		</section>

		<jsp:include page="/template/footer.jsp"></jsp:include>