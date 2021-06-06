<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
	String title = "이용 안내";
%>

	<jsp:include page="/service/serviceSidebar.jsp">
		<jsp:param value="<%=title %>" name="title" />
	</jsp:include>
	
	<div class="main">
		<div class="header">
			<div class="row">
				<span class="title">이용 안내</span>
			</div>
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img
						alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 이용 안내</span>
			</div>
		</div>
		
		<div class="row">
					<div>이용안내</div> <br><br>
					<div>이용방법</div> <br><br>
					<div>이용관련 문의</div> <br><br>
		</div>

<jsp:include page="/template/footer.jsp"></jsp:include>