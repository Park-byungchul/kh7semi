<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("UTF-8");

String root = request.getContextPath();
String title = "댓글 관리";

%>
    
    
<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<div class="main" style="min-height:800px;">
	
		<div class="header">
			<div class="row">
				<span class="title">지점 목록</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 전체관리자 > 지점 목록</span>
			</div>
		</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>