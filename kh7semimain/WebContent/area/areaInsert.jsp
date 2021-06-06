<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();

	String title = "지점 등록";
%>


<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

	
	<div class="main">
		
			<div class="header">
				<div class="row">
					<span class="title">지점 등록</span>
				</div>
				
				<div class="row">
					<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 전체관리자 > 지점 등록</span>
				</div>
			</div>
		
		<div class="row">
			<form action="areaInsert.kh" method="post">
				<div class="row">
					<label>지점명 : </label><input type="text" class="login-form" name="areaName" required>
				</div>
				<div class="row">
					<label>지점 위치 : </label><input type="text" class="login-form" name="areaLocation" required>
				</div>
				<div class="row">
					<label>지점 전화번호 : </label><input type="text" class="login-form" name="areaCall" required>
				</div>
				<div class="row">
					<input type="submit" class="board-btn" value="등록">
				</div>
			</form>
		</div>

<jsp:include page="/template/footer.jsp"></jsp:include>