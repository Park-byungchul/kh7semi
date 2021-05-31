<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String root = request.getContextPath();
%>
    
<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>
	
<style>
	input[type="button"] {
 			width: 300px;
			height: 50px;
	}
</style>
	
		<div class="row text-center">
			<h2>대출 및 예약 안내</h2>
		</div>

			<div class="row text-center">
				<input type="button" value="대출 및 예약 안내">
				<input type="button" onclick="location.href='<%=root%>/search/searchInput.jsp'" value="대출 및 예약 신청">		
			</div>
				<br><br>
			
			<div class="row text-center">
				<div class="row">대출 안내</div> <br><br>
				<div class="row">대출예약 안내</div> <br><br>
				<div class="row">대출예약 신청결과 확인</div> <br><br>
				<div class="row">대출예약 선정 제외 기준</div> <br><br>
			</div>	
		
<jsp:include page="/template/footer.jsp"></jsp:include>