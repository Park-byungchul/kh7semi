<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
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
	
	AreaDao areaDao = new AreaDao();
	int areaNo;
	try{
		areaNo = (int)session.getAttribute("areaNo");
	}
	catch (Exception e){
		areaNo = 0;
	}

	String title = "관리자 메뉴";
	if(areaNo > 0){
		title += " : " + areaDao.detail(areaNo).getAreaName();
	}
%>
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

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>
<style>
	input[type="button"]{
		width: 150px;
		height: 50px;
	}
</style>	
<div class="main" style="height:800px;">
	<div class="header">
		<div class="row">
			<span class="title">대여 반납</span>
		</div>
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 전체관리자 > 대여 반납</span>
		</div>
	</div>		
		<section>
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
						 <label class="text-left">입고번호 : </label>
						 <input type="text" name="getBookNo" size="50" height = "20" required class="form-input form-input-underline" style="width:80%;">
						 <br><br>
<!-- 							지점번호 : <input type="text" name="areaNo" size="50" height = "20" required> -->
						 <br><br>
						
						<input type="submit" onclick="insertOnClick()"value="대여 반납" class="form-btn form-btn-inline">
					</form>					
				</div> <br><br>
				
			</div>
		</div>		
			<div class="row text-right">
				<input type="button" onclick="location.href='<%=root%>/lendBook/lendBookInsert.jsp'" value="대여 접수" class="form-btn form-btn-inline">	
				<input type="button" onclick="location.href='<%=root%>/lendBook/lendBookList.jsp'" value="대출목록 조회" class="form-btn form-btn-inline">
			</div>
		</section>
</div>	
<jsp:include page="/template/footer.jsp"></jsp:include>	
						