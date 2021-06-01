<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%
	String root = request.getContextPath();
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여 접수</title>
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/menu.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/test.css">
	<script>
	var is_empty = false;
	
		function insertOnClick(){
			is_empty = false;
			$('.form').find('input[type="text"]').each(function(){
			    if(!$(this).val()) {
			        is_empty = true;
			    }
			});
			if(is_empty) {
			    alert('값을 전부 입력하시오');
			}
			else{
			alert('대여 접수가 완료되었습니다.');
			}
		}
	</script>
	<%
	request.setCharacterEncoding("UTF-8");
	Integer clientNo = (Integer)session.getAttribute("clientNo");
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto;
	if(clientNo == null) {
		clientDto = null;
	}
	else {
		clientDto = clientDao.get(clientNo);
	}

%>
<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>				
		<header>
			<h2>대여 접수</h2>
		</header>
		<section>
			<div class= "float-container">
				<aside class="multi-container">
				
				</aside>
				<div class="multi-container" style="width:80%;">
			
				
			<!-- 	대여 접수 입력창 구현 -->
				<div>
					<form action = "lendBookInsert.kh" method="post" class = "form">		
<!-- 						회원번호 : <input type="text" name="clientNo" size="50" height = "20" required> -->
 						회원번호 : <input type="hidden" name="clientNo" size="50" height = "20" value = <%=clientNo%> required>
						 <br><br>
						입고번호 : <input type="text" name="getBookNo" size="50" height = "20" required>
						 <br><br>
						지점번호 : <input type="text" name="areaNo" size="50" height = "20" required>
						 <br><br>
						
						<input type="submit" onclick="insertOnClick()"value="대여 접수">
					</form>					
				</div> <br><br>
				
			</div>
		</div>		
			
		</section>
		
		<jsp:include page="/template/footer.jsp"></jsp:include>