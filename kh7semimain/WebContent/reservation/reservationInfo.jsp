<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
	String title = "도서 예약";
%>
	
<style>
	input[type="button"] {
 			width: 300px;
			height: 50px;
	}
</style>

<jsp:include page="/service/serviceSidebar.jsp">
	<jsp:param value="<%=title %>" name="title" />
</jsp:include>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">도서 예약</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img
					alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 도서 예약</span>
		</div>
	</div>
	
		<div class="row text-center">
			<input type="button" class="board-btn" value="대출 및 예약 안내">
			<input type="button" class="board-btn" onclick="location.href='<%=root%>/search/searchInput.jsp'" value="대출 및 예약 신청">		
		</div>
			<br><br>
		
		<div class="row text-center">
			<div class="row">대출 안내</div> <br><br>
			<div class="row">대출예약 안내</div> <br><br>
			<div class="row">대출예약 신청결과 확인</div> <br><br>
			<div class="row">대출예약 선정 제외 기준</div> <br><br>
		</div>
	</div>
		
<jsp:include page="/template/footer.jsp"></jsp:include>