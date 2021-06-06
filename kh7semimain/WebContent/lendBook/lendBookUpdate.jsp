<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여 반납</title>
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/menu.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/test.css">

	<script>
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
			alert('대여 반납이 완료되었습니다.');
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
<style>
	input[type="button"]{
		width: 150px;
		height: 50px;
	}
</style>	
		<header>
			<h2>대여 반납</h2>
		</header>
		<section>
			<div class="row text-right">
				<input type="button" onclick="location.href='<%=root%>/lendBook/lendBookInsert.jsp'" value="대여 접수">
			</div>
			<div class= "float-container">
				<aside class="multi-container">
				
				</aside>
				<div class="multi-container" style="width:80%;">
				
			<!-- 	대여 반납 입력창 구현 -->
				<div>
					<form action = "lendBookUpdate.kh" method="post" class = "form">		
<!-- 						회원번호 : <input type="text" name="clientNo" size="50" height = "20" required> -->
<%--  						회원번호 : <input type="text" name="clientNo" size="50" height = "20" value = <%=clientNo%> required> --%>
						 <br><br>
						입고번호 : <input type="text" name="getBookNo" size="50" height = "20" required>
						 <br><br>
<!-- 							지점번호 : <input type="text" name="areaNo" size="50" height = "20" required> -->
						 <br><br>
						
						<input type="submit" onclick="insertOnClick()"value="대여 반납">
					</form>					
				</div> <br><br>
				
			</div>
		</div>		
			<div class="row text-right">
						<input type="button" onclick="location.href='<%=root%>/lendBook/lendBookList.jsp'" value="대출목록 조회">
					</div>
		</section>
		
		<jsp:include page="/template/footer.jsp"></jsp:include>	
						